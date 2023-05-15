docker build -t hungvi/multi-client:latest -t hungvi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hungvi/multi-server:latest -t hungvi/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t hungvi/multi-worker:latest -t hungvi/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push hungvi/multi-client:latest
docker push hungvi/multi-server:latest
docker push hungvi/multi-worker:latest
docker push hungvi/multi-client:$SHA
docker push hungvi/multi-server:$SHA
docker push hungvi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hungvi/multi-client:$SHA
kubectl set image deployments/server-deployment server=hungvi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hungvi/multi-worker:$SHA

