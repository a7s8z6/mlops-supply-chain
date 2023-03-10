#!/bin/bash

set -x

# Start the JupyterHub instance.

trap 'kill -TERM $PID' TERM INT

start-jupyterhub.sh &

PID=$!
wait $PID
trap - TERM INT
wait $PID
STATUS=$?
exit $STATUS