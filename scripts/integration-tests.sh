#!/bin/bash
set -e

source /scripts/common.sh
source /scripts/bootstrap-helm.sh

run_tests() {
    echo Running tests...

    POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=opsdroid,app.kubernetes.io/instance=opsdroid" -o jsonpath="{.items[0].metadata.name}")
    wait_pod_ready $POD_NAME

}

main(){
    /scripts/build-helmfile.sh
    helm install --generate-name ./charts/opsdroid
    run_tests
}

main