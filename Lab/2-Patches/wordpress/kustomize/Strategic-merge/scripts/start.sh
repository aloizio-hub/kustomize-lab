#! /bin/sh

# Set the current namespace to lec-12
kubectl config set-context --current --namespace=lec-18

# Apply the kustomization to the cluster
kubectl apply -k .
