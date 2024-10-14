When the Jupyter notebook application was installed and run locally, it was possible to generate a configuration file which contained a hash for a password, with the password then used to access the notebook.

To view again what this configuration file looked like, run:

```terminal:execute
command: cat $HOME/.jupyter/jupyter_server_config.json
```

It should be similar to:

```
{
  "IdentityProvider": {
    "hashed_password": "argon2:$argon2id$v=19$m=10240,t=10,p=8$nASioQSh/HSW9xH+e4cJxQ$MIDOSN4q1E8kcXohx6DlnllST0tFa223YVnm8bfpn6o"
  }
}
```

When a container was used for deployment, it was instead necessary to use an access token. The value of this access token wasn't known in advance, and needed to be extracted from the logs for the Jupyter notebook application. Alternatively, you needed to access the container to query the running Jupyter notebook application and list the access token.

One way around the need to do this, is to incorporate the contents of the generated config file ``jupyter_server_config.json`` into a Kubernetes resource called a ``ConfigMap``. This resource can then be mounted into the container for the Jupyter notebook application as a file at the required location.

To create the ``ConfigMap`` resource, run:

```terminal:execute
command: kubectl create configmap notebook --from-file=$HOME/.jupyter/jupyter_server_config.json
```

This should output:

```
configmap/notebook created
```

To query back what the resource looked like that was created, run:

```terminal:execute
command: kubectl get configmap/notebook -o yaml
```

This should yield a resource definition which incorporates the following:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: notebook
data:
  jupyter_server_config.json: |-
    {
      "IdentityProvider": {
        "hashed_password": "argon2:$argon2id$v=19$m=10240,t=10,p=8$nASioQSh/HSW9xH+e4cJxQ$MIDOSN4q1E8kcXohx6DlnllST0tFa223YVnm8bfpn6o"
      }
    }
```

To have this mounted into the container of the Jupyter notebook application, we need an updated ``Deployment`` resource that mounts it.

To view the updated deployment configuration, run:

```terminal:execute
command: cat notebook-v2/deployment.yaml
```

This should yield:

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
        ports:
        - name: 8888-tcp
          containerPort: 8888
          protocol: TCP
        resources:
          limits:
            memory: 512Mi
          requests:
            memory: 512Mi
        volumeMounts:
        - name: config
          mountPath: /home/jovyan/.jupyter
      volumes:
      - name: config
        configMap:
          name: notebook
```

The difference is the declaration of the config map as a volume that can be mounted, with it in turn being mounted into the container for the notebook application.

Deploy the Jupyter notebook application using this new configuration by running:

```terminal:execute
command: kubectl apply -f notebook-v2
```

Monitor the deployment to ensure it has completed by running:

```terminal:execute
command: kubectl rollout status deployment/notebook
```

When completed, access the notebook using the URL for the ingress route.

```dashboard:open-url
url: http://notebook-{{session_namespace}}.{{ingress_domain}}/
```

This time you should be presented with a simple login prompt. As the password, enter:

```workshop:copy
text: jupyter
```

Still a bit fiddly to setup, but at least we can now access the Jupyter notebook by a URL and use a normal password.
