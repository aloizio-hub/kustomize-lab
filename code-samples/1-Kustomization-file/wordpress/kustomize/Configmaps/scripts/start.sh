#! /bin/sh


# Create a namespace for the lecture
kubectl create ns lec-12

# Set the current namespace to lec-12
kubectl config set-context --current --namespace=lec-12

# Apply the kustomization to the cluster
kubectl apply -k .

# Get the postgres database ip address
kubectl get svc/lec-12-mysql --output="jsonpath={.spec.clusterIP}"
