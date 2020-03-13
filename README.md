LAB - Markdown Sample
=====================

This repository holds source files for a workshop on deploying Jupyter notebooks to Kubernetes.

If you want to review the workshop content, you can browse the files and subdirectories under [workshop/content](workshop/content).

To deploy the workshop, install the [eduk8s](https://github.com/eduk8s/eduk8s-operator) operator, then run:

```
kubectl apply -k github.com/eduk8s-tests/lab-jupyter-on-k8s-01
```

To delete the workshop when finished, run:

```
kubectl delete -k github.com/eduk8s-tests/lab-jupyter-on-k8s-01
```
