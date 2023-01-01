docker build -t arjunank/multi-client-k8s:latest -t arjunank/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t arjunank/multi-server-k8s-pgfix:latest -t arjunank/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t arjunank/multi-worker-k8s:latest -t arjunank/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push arjunank/multi-client-k8s:latest
docker push arjunank/multi-server-k8s-pgfix:latest
docker push arjunank/multi-worker-k8s:latest

docker push arjunank/multi-client-k8s:$SHA
docker push arjunank/multi-server-k8s-pgfix:$SHA
docker push arjunank/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arjunank/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=arjunank/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=arjunank/multi-worker-k8s:$SHA