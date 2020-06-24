#!/bin/bash

envsubst < exercises/notebook-v1/ingress.yaml.in > exercises/notebook-v1/ingress.yaml
envsubst < exercises/notebook-v2/ingress.yaml.in > exercises/notebook-v2/ingress.yaml
envsubst < exercises/notebook-v3/ingress.yaml.in > exercises/notebook-v3/ingress.yaml
