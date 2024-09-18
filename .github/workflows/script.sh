#!/bin/bash
POD_NAME=$(kubectl get pods --selector=job-name=kaniko-build --output=jsonpath='{.items[0].metadata.name}')
echo "Streaming logs for Kaniko job pod: $POD_NAME"

# Stream logs until pod reaches a terminal state
kubectl logs -f $POD_NAME &  # Stream logs in the background

while true; do
  POD_STATUS=$(kubectl get pod $POD_NAME --output=jsonpath='{.status.phase}')
  
  if [ "$POD_STATUS" == "Succeeded" ]; then
    echo "Kaniko Pod has successfully completed."
    break
  elif [ "$POD_STATUS" == "Failed" ] || [ "$POD_STATUS" == "CrashLoopBackOff" ]; then
    echo "Kaniko Pod is in an error state: $POD_STATUS"
    kubectl logs $POD_NAME  # Print the final logs
    echo "Error found in Kaniko build logs."
    exit 1
  else
    echo "Pod status: $POD_STATUS. Waiting for completion..."
    sleep 5  # Wait for a few seconds before checking again
  fi
done

# Fetch and check the final logs for errors
LOGS=$(kubectl logs $POD_NAME)
echo "$LOGS"
if echo "$LOGS" | grep -i "error"; then
   echo "Error found in Kaniko build logs."
   exit 1
else
   echo "No errors found in Kaniko build logs."
fi
