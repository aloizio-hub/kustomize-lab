#! /bin/sh

# Delete all created resources in the namespace
kubectl delete namespace lec-19

# Delete the results.yml file if exist
rm -f results.yml
