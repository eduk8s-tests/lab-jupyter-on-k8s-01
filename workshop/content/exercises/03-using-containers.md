Running Jupyter notebooks on your own computer means having to have a Python language runtime installed, and you will need to install yourself all the required packages. This can be fiddly to get right, but a bigger problem is being able to recreate the same configuration as others when wishing to share Jupyter notebooks files.

Factors which make this complicated are the use of different operating systems, different Python language runtime versions, and different versions of the Jupyter notebook software and packages required by a specific Jupyter notebook.

One solution which can help reduce the difficulty in ensuring that a group of people cooperating together have the same configuration, is to run Jupyter notebooks under a container runtime such as Docker or podman.

When using a container runtime, the Jupyter notebook software is packaged up as a container image, with everything required to run the Jupyter notebook application pre-installed in the image. All that needs to be installed on the local computer is the container runtime. The host operating system does not need to have the Python language runtime or Jupyter notebook software installed.

Rather than everyone needing to create their own container image for the Jupyter notebook software, a range of pre-built container images are supplied by the Jupyter project.

* jupyter/base-notebook
* jupyter/r-notebook
* jupyter/minimal-notebook
* jupyter/scipy-notebook
* jupyter/tensorflow-notebook
* jupyter/datascience-notebook
* jupyter/pyspark-notebook
* jupyter/all-spark-notebook

The GitHub repository used to create these images can be found at:

https://github.com/jupyter/docker-stacks

The standard notebook image is ``jupyter/minimal-notebook``. It includes the Jupyter notebook application and JupyterLab extension, as well as the kernels for using Jupyter notebooks with the Python language.

The other notebooks include other language kernels, or have a range of additional Python packages pre-installed in the image to save you needing to install them yourself.

In this workshop environment we can't use ``docker`` or ``podman`` to directly run these images in a container, but the process would involve running the following command:

```
$ docker run -p 8888:8888 jupyter/minimal-notebook
Executing the command: jupyter notebook
[I 06:47:20.180 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[I 06:47:20.617 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.7/site-packages/jupyterlab
[I 06:47:20.617 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 06:47:20.620 NotebookApp] Serving notebooks from local directory: /home/jovyan
[I 06:47:20.620 NotebookApp] The Jupyter Notebook is running at:
[I 06:47:20.620 NotebookApp] http://f1375efacd6f:8888/?token=27258442b9c8a08c6d1e1c71258dd190969539853adcc72b
[I 06:47:20.620 NotebookApp]  or http://127.0.0.1:8888/?token=27258442b9c8a08c6d1e1c71258dd190969539853adcc72b
[I 06:47:20.620 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 06:47:20.625 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
    Or copy and paste one of these URLs:
        http://f1375efacd6f:8888/?token=27258442b9c8a08c6d1e1c71258dd190969539853adcc72b
     or http://127.0.0.1:8888/?token=27258442b9c8a08c6d1e1c71258dd190969539853adcc72b
```

With the container running, to access the Jupyter notebook instance, you would use the last URL listed.

When the Jupyter notebook interface comes up in the browser you will not need to log in, as the token given as argument in the URL acts as a secret access token.

One issue with running Jupyter notebooks in containers is that what files you have access to is only whatever was built into the container image. In order to work on your own notebook files, you would need to upload them via the Jupyter notebook web interface. When they are uploaded, they are though only stored within the temporary file system of the container. This means that when the container is stopped, you will loose any changes you may have made to them.

The alternative to uploading the notebook files is to use the ability of the container runtime to mount in a volume from your local computer into the running container. If this is done, you will be able to see any notebook files in the directory you mounted from the local computer, and changes will also be saved back to your local computer file system.

The purpose of this workshop is to explore how to deploy Jupyter notebooks to Kubernetes. The examples so far show how you could run it on your local computer. They highlight a couple of issues that will need to be dealt with when running Jupyter notebooks in Kubernetes. These are user authentication, and persistence of the workspace in which you work.
