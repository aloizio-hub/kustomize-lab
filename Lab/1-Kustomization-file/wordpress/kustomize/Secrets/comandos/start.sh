#! /bin/sh

# Create a namespace for the lecture
kubectl create ns techtalk-ns

# Set the current namespace to techtalk-ns
kubectl config set-context --current --namespace=techtalk-ns
# Apply the kustomization to the cluster
kubectl apply -k .
