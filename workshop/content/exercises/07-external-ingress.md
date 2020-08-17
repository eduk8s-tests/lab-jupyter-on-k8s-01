To avoid the need to manually set up port forwarding every time you want to access the Jupyter notebook, and allow anyone to access it via a URL as necessary, you need to create Kubernetes ``Service`` and ``Ingress`` resources.

The purpose of the ``Service`` resource is to describe how the application can be accessed within the cluster. The ``Ingress`` describes how to setup the external ingress router to forward requests via the Jupyter notebook service, including the hostname which will need to be used in the URL.

To view the details of the service, run:

```terminal:execute
command: cat notebook-v1/service.yaml
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

```terminal:execute
command: cat notebook-v1/ingress.yaml
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
  - host: notebook-{{session_namespace}}.{{ingress_domain}}
    http:
      paths:
      - backend:
          serviceName: notebook
          servicePort: 8888
        path: /
```

To have the resources created, run:

```terminal:execute
command: kubectl apply -f notebook-v1
```

The output should be:

```
deployment.apps/notebook unchanged
service/notebook created
ingress.extensions/notebook created
```

Because we applied all the configuration in the ``notebook-v1`` directory, the configuration for the deployment was reapplied, but it wasn't modified so will be unchanged.

With the service and ingress created, the Jupyter notebook application can now be accessed without needing to use port forwarding. In this case the URL will be:

```dashboard:open-url
url: http://notebook-{{session_namespace}}.{{ingress_domain}}/
```

If you click on this, you will find though that we still need to be able to retrieve the access token to supply it on the login page. So we still have more work to do to make this more usable. For now, delete the Jupyter notebook application by running:

```terminal:execute
command: kubectl delete all,ingress -l app=notebook
```
