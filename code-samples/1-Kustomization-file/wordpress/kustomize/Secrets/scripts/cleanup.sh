#! /bin/sh

# Delete all created resources in this section
kubectl delete -k .

# Delete the results.yml file if exist
rm -f results.yml