The Jupyter notebook interface you saw is what is called the classic interface. A more up to date interface for working with Jupyter notebooks is provided by the JupyterLab interface.

To use the JupyterLab interface, you first need to install it, as it is not bundled with the base Jupyter notebook package but is an extension. Install it by running:

```terminal:execute
command: pip install jupyterlab
```

JupyterLab uses a different configuration file from the classic Jupyter notebook. To set the password for JupyterLab you will instead need to run:

```terminal:execute
command: jupyter server password
```

This will prompt you to enter the password and then confirm it. Enter:

```terminal:input
text: jupyter
```

and then to verify it, again enter:

```terminal:input
text: jupyter
```

This will update the file ``$HOME/.jupyter/jupyter_server_config.json`` with a hash of the credentials. You can view the contents of the file by running:

```terminal:execute
command: cat $HOME/.jupyter/jupyter_server_config.json
```

You can now start up the Jupyter notebook again, but this time using the JupyterLab interface, by running:

```terminal:execute
command: jupyter lab --ip 0.0.0.0 --port 8888
```

Click on the URL again to bring up the JupyterLab interface.

```dashboard:open-url
url: {{ingress_protocol}}://local-8888-{{session_namespace}}.{{ingress_domain}}/
```

Login using the same credentials as before.

![JupyterLab Interface](notebook-jupyterlab.png)

You will see that JupyterLab provides an all in one interface where Jupyter notebooks are opened in the same page. In the classic interface, Jupyter notebooks were always opened in a new browser window or tab.

When you are done trying out the JupyterLab interface, kill the Jupyter notebook application using:

```terminal:interrupt
```

You will be prompted if you want to shutdown the application so confirm that you do using:

```terminal:input
text: y
```
