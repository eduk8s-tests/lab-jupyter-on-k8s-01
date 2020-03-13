The typical way that Jupyter notebooks would be run is to run them directly on your own local computer. This involves having the Python language interpreter available

```execute
virtualenv venv
```

```execute
source venv/bin/activate
```

```execute
pip install notebook
```

```execute
jupyter notebook password
```

```execute
eduk8s
```

```execute
eduk8s
```

```execute
jupyter notebook --ip 0.0.0.0 --port 8888
```

%ingress_protocol%://%session_namespace%-local-8888.%ingress_domain%/

```execute
<ctrl-c>
```

```execute
y
```

```execute
pip install jupyterlab
```

```execute
jupyter lab --ip 0.0.0.0 --port 8888
```

%ingress_protocol%://%session_namespace%-local-8888.%ingress_domain%/

```execute
<ctrl-c>
```

```execute
y
```
