Download resources
----------------

for n in $(kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob)
do
    mkdir -p $(dirname $n)
    kubectl get -o=yaml --export $n > $n.yaml
done


export deployment
---------------------
for n in $(kubectl get -o=name deployment)
do
    mkdir -p $(dirname $n)
    kubectl get -o=yaml --export $n > $n.yaml
done



for n in $(kubectl get deployments --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n testns)
do
    kubectl get deployments $n -o yaml -n testns > $n.yaml
done



Describe pod
---------------------

for n in $(kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n testns)
do
	kubectl describe pod $n -n testns > $n_describe.yaml
done


rollout restart
--------------


for n in $(kubectl get deployments --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n testns)
do
    kubectl rollout restart deployment $n -n testns
done


env variable
--------------

for n in $(kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n testns)
do
	kubectl exec $n -n testns -- env > $n.txt
done
