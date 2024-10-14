Where only a ``Deployment`` has been created, the only way to access the Jupyter notebook instance outside of the Kubernetes cluster is by using port forwarding. To set up port forwarding, run the command:

```terminal:execute
command: kubectl port-forward deployment/notebook 8888:8888
session: 1
```

It will generate the output:

```
Forwarding from 127.0.0.1:8888 -> 8888
```

indicating port forwarding is active.

If this were being run on your own local computer, you could then access the Jupyter notebook application using the url ``http://127.0.0.1:8888``.

As we are running the Jupyter notebook application in this hosted workshop environment, you will instead need to again use the following URL to access it.

```dashboard:open-url
url: {{ingress_protocol}}://local-8888-{{session_namespace}}.{{ingress_domain}}/
```

Clicking on this URL to access the web interface for the Jupyter notebook, you will see that what it displays this time is quite different.

![Token Access](notebook-token-access.png)

This is because we haven't been able to set a password, nor were we shown the URL with access token to use when accessing the Jupyter notebook application.

In order to work out what the access token is, we either have to look at the container logs kept by Kubernetes, or access the container to dump out a list of the Jupyter notebook instances.

To view the logs for the Jupyter notebook application, run:

```terminal:execute
command: kubectl logs deployment/notebook
session: 2
```

You should see a section in the logs similar to:

```
To access the server, open this file in a browser:
    file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
Or copy and paste one of these URLs:
    http://notebook-5474d74498-ktcv6:8888/?token=68c199acba9a8feea241c15e156f00f0d788608355cda8a0
 or http://127.0.0.1:8888/?token=68c199acba9a8feea241c15e156f00f0d788608355cda8a0
 ```

To login to the Jupyter notebook application you would need to copy the access token shown in the logs and use it with the login page.

Instead of looking at the container logs, you could instead run the ``jupyter server list`` where the Jupyter notebook application is running:

```terminal:execute
command: kubectl exec deployment/notebook -- jupyter server list
session: 2
```

This should display a list similar to:

```
Currently running servers:
http://0.0.0.0:8888/?token=68c199acba9a8feea241c15e156f00f0d788608355cda8a0 :: /home/jovyan
```

As before, you would copy the access token for use with the login page.

Having to work out what the access token is using either of these methods is not particularly convenient, nor is the need to setup port forwarding each time you need to access the Jupyter notebook.

Before we continue and look at solutions for improving on this, shutdown the port forwarding by running:

```terminal:interrupt
```
