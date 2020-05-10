docker build -t truongco/multi-client:latest -t truongco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t truongco/multi-server:latest -t truongco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t truongco/multi-worker:latest -t truongco/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push truongco/multi-client:latest
docker push truongco/multi-server:latest
docker push truongco/multi-worker:latest

docker push truongco/multi-client:$SHA
docker push truongco/multi-server:$SHA
docker push truongco/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=truongco/multi-server:$SHA
kubectl set image deployments/client-deployment client=truongco/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=truongco/multi-worker:$SHA
