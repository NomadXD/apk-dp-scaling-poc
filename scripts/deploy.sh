#!/bin/sh

function substituteEnv() {
    max=3
    for i in `seq 1 $max`
    do
        export APK_API_NAME="http-bin-api-basic-template-$i"
        export APK_API_CONTEXT="http-bin-api-basic-template-$i"
        export APK_API_VERSION="1.0.8"
        export APK_API_PROD_ROUTE="prod-http-route-http-bin-api-template-$i"
        export APK_API_SAND_ROUTE="sand-http-route-http-bin-api-template-$i"
        cat resources/cr/basic/basic.template.yaml | envsubst | kubectl apply -f -
    done
}

function streamLogs() {
    kubectl logs -f apk-test-wso2-apk-gateway-runtime-deployment-7cf557d5cf-hfwl4 -c router -n apk | tee logs.txt
}

function getPodTimestamps() {
    kubectl get pod apk-test-wso2-apk-gateway-runtime-deployment-7cf557d5cf-hfwl4 -o json -n apk | jq -r '.status.conditions'
}

# function getAdapterLogs() {
    
# }

# function

# getPodTimestamps

result=$(kubectl get pods -n apk | grep "apk-test-wso2-apk-gateway-runtime-deployment" | tr "2/2" "")
echo $result[0]
