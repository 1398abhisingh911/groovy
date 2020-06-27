if ! kubectl get pvc | grep web-pvc
then
  kubectl create -f ../1-Git-Pull/K8s-YAML/pvc.yml
fi

if ! kubectl get svc | grep web-svc
then
  kubectl create -f ../1-Git-Pull/K8s-YAML/service.yml
fi

if ls /root/.jenkins/workspace/1-Git-Pull/*.* | grep html
then
  if ! kubectl get pods | grep http | grep Running
  then
    kubectl create -f ../1-Git-Pull/K8s-YAML/http.yml

    while kubectl get pods | grep http | grep ContainerCreating
    do
      sleep 1
    done    
    kubectl cp ../1-Git-Pull/*.html $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/usr/local/apache2/htdocs

  else
    kubectl cp ../1-Git-Pull/*.html $(kubectl get pods -o=jsonpath='{.items[0].metadata.name}'):/usr/local/apache2/htdocs
  fi
fi
