#!/bin/bash

envsubst < notebook-v1/ingress.yaml.in > notebook-v1/ingress.yaml
envsubst < notebook-v2/ingress.yaml.in > notebook-v2/ingress.yaml
