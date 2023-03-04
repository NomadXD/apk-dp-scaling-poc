#!/bin/sh

function getRouterLogs() {
    while [ -z $ROUTER_POD ]
    do
        ROUTER_POD=$(kubectl get pods --selector=app.kubernetes.io/app=router -n apk -o custom-columns=":metadata.name")
        sleep 1;
        echo $ROUTER_POD
        echo "Retrying get pods: router"
    done
    kubectl logs -f $ROUTER_POD -c router -n apk | tee router_logs.txt
}

function getClusterCount() {
    while [ -z $ROUTER_IP ]
    do
        ROUTER_IP=$(kubectl get svc apk-test-wso2-apk-router-service --output jsonpath='{.status.loadBalancer.ingress[0].ip}' -n apk)
        sleep 1;
        echo $ROUTER_IP
        echo "Retrying get pods: router"
    done
    while true
    do
        curl -X GET http://$ROUTER_IP:9000/stats?filter=cluster_manager.active_clusters&format=json&type=All&histogram_buckets=cumulative
    done
}

getClusterCount