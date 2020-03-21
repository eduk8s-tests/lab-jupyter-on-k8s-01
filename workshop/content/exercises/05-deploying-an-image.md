The Jupyter notebook application image we want to deploy is the ``jupyter/minimal-notebook`` image we showed earlier. To create a deployment for this we need to define a ``Deployment`` resource.

To see the definition of this resource, run:

```execute
cat notebook/deployment.yaml
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
      - name: workshop
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
```

In short, it says to run the required container image, giving it 512Mi of memory. Also, that only one instance of the notebook is required.

To load this resource definition into Kubernetes, run the command:

```execute
kubectl apply -f notebook/deployment.yaml
```

The output should be:

```
deployment.apps/notebook created
```

This indicates that the resource definition was accepted. Kubernetes will now go about the task of pulling down the container image to the cluster if necessary, creating a container for the image, and running the Jupyter notebook application bundled within the image.

To monitor the deployment so you know when it has completed, run:

```execute
kubectl rollout status deployment/notebook
```

If this is the first time the container image is being used in the Kubernetes cluster, because the Jupyter notebook images can be quite large, it may take some time to pull down the image and deploy it.
