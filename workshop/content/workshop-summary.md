As seen, Kubernetes provides the components necessary to host instances of Jupyter notebook applications. These mechanisms are however not something that you would want to expose to a typical user of a Jupyter notebook. Such a user shouldn't have access to the Kubernetes cluster, and there is no good reason for them to even know that Kubernetes was being used to host the Jupyter notebooks.

More work thus needs to be done to hide the details of how Jupyter notebooks are being deployed in the case of using Kubernetes. This could take the form of a high level web based application that can provide access to the Jupyter notebooks.

For power users who do need access to the Kubernetes layer, although they may need to work with Kubernetes resource objects for other reasons, it would still be advantageous to provide a higher level abstraction via custom resources to encapsulate and simplify deployment of the Jupyter notebook applications.

In the next workshop on this topic of deploying Jupyter notebook to Kubernetes, we will look at using custom resources and operators to implement a method of managing the deployments of the Jupyter notebook application.
