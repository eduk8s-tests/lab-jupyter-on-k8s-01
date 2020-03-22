To avoid the need to manually set up port forwarding every time you want to access the Jupyter notebook, and allow anyone to access it via a URL as necessary, you need to create Kubernetes ``Service`` and ``Ingress`` resources.

The purpose of the ``Service`` resource is to describe how the application can be accessed within the cluster. The ``Ingress`` describes the how to setup the external ingress router to forward requests through to the Jupyter notebook instance, including the hostname which will need to be used in the URL.

To view the details of the service, run:

```execute
cat notebook-v1/service.yaml
```

This should yield:

```
apiVersion: v1
kind: Service
metadata:
  name: notebook
  labels:
    app: notebook
spec:
  type: ClusterIP
  selector:
    deployment: notebook
  ports:
  - name: 8888-tcp
    port: 8888
    protocol: TCP
    targetPort: 8888
```

To view the details of the ingress, run:

```execute
cat notebook-v1/ingress.yaml
```

This should yield:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: notebook
  labels:
    app: notebook
spec:
  rules:
  - host: notebook-%session_namespace%.%ingress_domain%
    http:
      paths:
      - backend:
          serviceName: notebook
          servicePort: 8888
        path: /
```

To have the resources created, run:

```execute
kubectl apply -f notebook-v1
```

The output should be:

```
deployment.apps/notebook unchanged
service/notebook created
ingress.extensions/notebook created
```

Because we applied all the configuration in the ``notebook-v1`` directory, the configuration for the deployment was reapplied, but it wasn't modified so will be unchanged.
