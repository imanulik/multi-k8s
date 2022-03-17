docker build -t irik777/multi-client:latest -t irik777/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t irik777/multi-server:latest -t irik777/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t irik777/multi-worker:latest -t irik777/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push irik777/multi-client:latest
docker push irik777/multi-server:latest
docker push irik777/multi-worker:latest

docker push irik777/multi-client:$SHA 
docker push irik777/multi-server:$SHA 
docker push irik777/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=irik777/multi-server:$SHA
kubectl set image deployments/client-deployment client=irik777/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=irik777/multi-worker:$SHA