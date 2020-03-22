The Jupyter notebook application image we want to deploy is the ``jupyter/minimal-notebook`` image we showed earlier. To create a deployment for this we need to define a ``Deployment`` resource.

To see the definition of this resource, run:

```execute
cat notebook-v1/deployment.yaml
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
kubectl apply -f notebook-v1/deployment.yaml
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

Although we only created a ``Deployment`` resource, under the cover this results in the creation of additional resources. To see all the resources that currently exist for the deployment, run:

```execute
kubectl get all
```

This should shield output similar to:

```
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/notebook   1/1     1            1           30s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/notebook-5474d74498   1         1         1       30s

NAME                            READY   STATUS    RESTARTS   AGE
pod/notebook-5474d74498-vd7jx   1/1     Running   0          30s
```

The ``ReplicaSet`` resource is created as a side effect of the ``Deployment`` resource being created, where the ``Deployment`` acts as a template for it. The ``Pod`` resource is then created to satisfy the criteria for the deployment specified by the ``ReplicaSet``. It is a pod which represents a single instance of the deployed application running in a container.

If we query just the pod, but request additional details by running:

```execute
kubectl get pods -o wide
```

we will get output similar to:

```
NAME                       READY  STATUS   RESTARTS  AGE  IP          NODE      NOMINATED NODE  READINESS GATES
notebook-5474d74498-vd7jx  1/1    Running  0         60s  172.17.0.7  minikube  <none>          <none>
```

You will see an IP address listed, which can be used to connect to any application running in the pod. This IP address is only accessible though inside of the Kubernetes cluster, and may even only be accessible within the context of the namespace that the pod is running.

The IP address cannot be used to access the Jupyter notebook application outside of the Kubernetes cluster.
