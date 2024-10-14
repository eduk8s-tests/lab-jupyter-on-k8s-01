The Jupyter notebook interface you saw is what is called the classic interface. A more up to date interface for working with Jupyter notebooks is provided by the JupyterLab interface.

To use the JupyterLab interface, you first need to install it, as it is not bundled with the base Jupyter notebook package but is an extension. Install it by running:

```terminal:execute
command: pip install jupyterlab
```

You can now start up the Jupyter notebook again, but this time using the JupyterLab interface, by running:

```terminal:execute
command: jupyter lab --ip 0.0.0.0 --port 8888
```

Click on the URL again to bring up the JupyterLab interface.

```dashboard:open-url
url: {{ingress_protocol}}://local-8888-{{session_namespace}}.{{ingress_domain}}/
```

Because you already logged in using the classic interface you shouldn't need to login again, however if prompted to login again use the same credentials as before.

![JupyterLab Interface](notebook-jupyterlab.png)

You will see that JupyterLab provides an all in one interface where Jupyter notebooks are opened in the same page. In the classic interface, Jupyter notebooks were always opened in a new browser window or tab.

When you are done trying out the JupyterLab interface, kill the Jupyter notebook application using:

```terminal:interrupt
```

You will be prompted if you want to shutdown the application so confirm that you do using:

```terminal:input
text: y
```
