docker build -t adamj335/multi-client:latest -t adamj335/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adamj335/multi-server -t adamj335/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adamj335/multi-worker -t adamj335/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adamj335/multi-client:latest
docker push adamj335/multi-server:latest
docker push adamj335/multi-worker:latest

docker push adamj335/multi-client:$SHA
docker push adamj335/multi-server:$SHA
docker push adamj335/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adamj335/multi-server:$SHA
kubectl set image deployments/client-deployment client=adamj335/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adamj335/multi-worker:$SHA
