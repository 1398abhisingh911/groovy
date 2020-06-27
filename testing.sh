nodeport=$(kubectl get svc -o jsonpath={.items[*].spec.ports[*].nodePort})
status=$(curl -s -w "%{http_code}" -o /dev/null http://192.168.99.117:$nodeport)

if [ $status -eq 200 ]
then
  exit 1
else 
  exit 0
fi
