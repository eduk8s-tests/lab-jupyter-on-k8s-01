Where only a ``Deployment`` has been created, the only way to access the Jupyter notebook instance outside of the Kubernetes cluster is by using port forwarding. To set up port forwarding, run the command:

```execute
kubectl port-forward deployment/notebook 8888:8888
```

It will generate the output:

```
Forwarding from 127.0.0.1:8888 -> 8888
```

indicating port forwarding is active.

If this were being run on your own local computer, you could then access the Jupyter notebook application using the url ``http://127.0.0.1:8888``.

As we are running the Jupyter notebook application in this hosted workshop environment, you will instead need to again use the following URL to access it.

%ingress_protocol%://%session_namespace%-local-8888.%ingress_domain%/

When accessing the web interface for the Jupyter notebook, you will see that what it displays this time is quite different.
