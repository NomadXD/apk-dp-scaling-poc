#!/bin/sh

kubectl top po --containers -A > "resources-start.txt"
kubectl get po -owide -A > "pods-distribution.txt"
nohup sh -c "sleep 300 && kubectl top po --containers -A > resources-5min.txt" >/dev/null &
nohup sh -c "sleep 600 && kubectl top po --containers -A > resources-10min.txt" >/dev/null &
nohup sh -c "sleep 900 && kubectl top po --containers -A > resources-15min.txt" >/dev/null &