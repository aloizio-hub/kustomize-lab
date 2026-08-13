#! /bin/sh


# Create a namespace for the lecture
k create ns techtalk-cm

# Set the current namespace to techtalk-cm
k config set-context --current --namespace=techtalk-cm

# Apply the kustomization to the cluster
k apply -k .

# Get the postgres database ip address
k get svc/lec-12-mysql --output="jsonpath={.spec.clusterIP}"
