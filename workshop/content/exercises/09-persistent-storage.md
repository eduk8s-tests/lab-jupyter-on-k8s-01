When running a Jupyter notebook in a container hosted in a remote Kubernetes cluster, it is not possible to mount a local volume from your own computer into the container. The application therefore has no access to your notebook files. You can upload the notebook files and any data, but if the container stops and the application restarted, you will loose your files and any changes.

The best one can do is to mount a persistent volume into the container so that anything you do upload is stored in that volume. This way any work will not be lost when the container is stopped and the application restarted.

To use a persistent volume, it is necessary to create a ``PersistentVolumeClaim`` resource. As the name implies, this makes a claim for persistent storage of a certain size.

To view the details of this resource run:

```terminal:execute
command: cat notebook-v3/persistentvolumeclaim.yaml
```

The output should be:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: notebook
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

This needs to be mounted into the container, so the deployment needs to be updated.

To see the update deployment configuration run:

```terminal:execute
command: cat notebook-v3/deployment.yaml
```

The output should be:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: notebook
  labels:
    app: notebook
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      deployment: notebook
  template:
    metadata:
      labels:
        deployment: notebook
    spec:
      containers:
      - name: notebook
        image: jupyter/minimal-notebook:latest
        args:
        - start-notebook.sh
        - --config
        - /var/run/jupyter/jupyter_server_config.json
        - --ip=0.0.0.0
        - --port=8888
        ports:
        - name: 8888-tcp
          containerPort: 8888
          protocol: TCP
        resources:
          limits:
            memory: 512Mi
          requests:
            memory: 512Mi
        env:
        - name: JUPYTER_ENABLE_LAB
          value: "true"
        volumeMounts:
        - name: config
          mountPath: /var/run/jupyter
        - name: data
          mountPath: /home/jovyan
      volumes:
      - name: config
        configMap:
          name: notebook
      - name: data
        persistentVolumeClaim:
          claimName: notebook
```

A volume definition linked to the persistent volume claim has been added, and the volume then mounted on the directory ``/home/jovyan``.

Because the existing volume mount for the config map conflicted with where the volume for data storage is being mounted, it was necessary to relocate where the config map was mounted. In doing this it was necessary to override the command arguments when the container is started, to reference the configuration from its new location.

To apply the updated configuration run:

```terminal:execute
command: kubectl apply -f notebook-v3
```

The output should be:

```
persistentvolumeclaim/notebook created
deployment.apps/notebook configured
ingress.extensions/notebook unchanged
service/notebook unchanged
```

Monitor the deployment to ensure it has completed by running:

```terminal:execute
command: kubectl rollout status deployment/notebook
```

You can once again access the notebook using the URL:

```dashboard:open-url
url: http://notebook-{{session_namespace}}.{{ingress_domain}}/
```

This time if you were to upload any notebooks or data files, they will be placed in the persistent volume, and would still be present if for any reason the container was shutdown and the Jupyter notebook application was restarted.

Do note though, that this only extends to notebooks and data files you upload. If you were to install additional Python packages from the terminal within the Jupyter notebook application, or from a notebook, these packages are stored elsewhere, outside of the persistent volume. So if you had installed extra packages and the container were restarted, you would have to reinstall them.

That packages would have to be reinstalled is due to the Python environment in which they are installed being under the directory ``/opt/conda``. To allow updates to also be saved when new packages are installed requires a different approach. This is in part due to how Anaconda Python works, but also how the Jupyter project images have been constructed. Because the solution to that isn't as simple, we will deal with that in a future workshop.
