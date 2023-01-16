#!/bin/bash
set -e

JSP_UI_SRC_PATH=/opt/app-root/lib/python3.8/site-packages/jupyterhub_singleuser_profiles/ui

cd ${JSP_UI_SRC_PATH}

npm install
npm run build

cd /opt/app-root/share/jupyterhub/static/
mkdir jsp-ui
cp -a ${JSP_UI_SRC_PATH}/build/. /opt/app-root/share/jupyterhub/static/jsp-ui

cd ${JSP_UI_SRC_PATH}/templates/
yes | cp -rf *.html /opt/app-root/share/jupyterhub/templates/
