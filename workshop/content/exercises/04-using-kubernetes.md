For running workloads in containers, Kubernetes is becoming a popular solution. The big question is whether this can help, or is a hinderance, in providing a platform for running Jupyter notebooks.

Kubernetes can certainly be beneficial in centralising computer resources in an organisation, but Kubernetes is primary a platform for operations. Kubernetes is arguably not that friendly for developers, and even less so as something you would provide to end users, especially the non technical type of people who are often the ones who want to run Jupyter notebooks.

In evaluating whether Kubernetes is suitable as a platform for hosting Jupyter notebooks, let's look at what is actually involved in hosting a Jupyter notebook application in Kubernetes.

The first problem, of how to package up the Jupyter notebook application, is actually already solved for us. This is because Kubernetes is a platform for running applications in containers. So long as you have a container image built to the Open Container Initiative (OCI) image specification, it can be hosted on Kubernetes. All those container images we saw previously from the Jupyter project satisfy this requirement.

The next step is therefore to work out how we tell Kubernetes to run the container image for the Jupyter notebook application, and expose it so that it can be accessed from our web browser.

When doing any task with Kubernetes, rather than running a set of imperative commands to tell it what to do, you instead provide a declarative description of what you want the final result to look like. So rather than tell it to run this container, you declare how the deployment should look. It is then the job of Kubernetes to work out what to do to satisfy the required end state.

Configuration of Kubernetes is therefore performed by creating a set of resource definitions which describe what you want. These are provided as YAML definitions (but can also be JSON).

In the case of wanting to deploy our Jupyter notebook application, we first need to look at creating a **Deployment** resource. This is a description of the application deployment we want to create and the container image to use.
