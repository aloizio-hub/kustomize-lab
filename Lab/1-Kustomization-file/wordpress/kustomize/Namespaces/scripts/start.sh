#! /bin/sh

# Create a namespace for the lecture
kubectl create ns lec-15

# Set the current namespace to lec-12
kubectl config set-context --current --namespace=lec-15

# Apply the kustomization to the cluster
kubectl apply -k .
