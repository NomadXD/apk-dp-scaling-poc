#!/bin/sh

function substituteEnv() {
    for i in `seq $1 $2`
    do
        echo $i
        export APK_API_NAME="http-bin-api-basic-template-$i"
        export APK_API_CONTEXT="http-bin-api-basic-template-$i"
        export APK_API_VERSION="v1"
        export APK_API_PROD_ROUTE="prod-http-route-http-bin-api-template-$i"
        export APK_API_SAND_ROUTE="sand-http-route-http-bin-api-template-$i"
        cat resources/cr/basic/basic.template.yaml | envsubst | kubectl delete -f -
    done
}


function deployCRDsConcurrently() {
  mul=1000
  max=4
  for i in `seq 1 $max`
  do
    limit=$(($i * $mul));
    start=$(($limit - 999))
    # echo $start $limit
    substituteEnv $start $limit &
  done
}

deployCRDsConcurrently