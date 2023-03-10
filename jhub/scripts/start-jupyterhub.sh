#!/bin/bash

set -x

set -eo pipefail

# Read any custom environment variables.

. /opt/app-root/etc/jupyterhub_config.sh

# Upgrade DB if needed

jupyterhub upgrade-db -f /opt/app-root/etc/jupyterhub_config.py

# Start the JupyterHub instance.

exec jupyterhub -f /opt/app-root/etc/jupyterhub_config.py
