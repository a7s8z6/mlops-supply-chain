FROM registry.access.redhat.com/ubi8/python-38:override-me-as-buid-arg

LABEL io.k8s.display-name="JupyterHub" \
      io.k8s.description="JupyterHub." \
      io.openshift.tags="builder,python,jupyterhub"

ENV NPM_CONFIG_PREFIX=/opt/app-root \
    PYTHONPATH=/opt/app-root/src

USER root
# Install PostgreSQL client
RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    dnf install -y unixODBC-devel postgresql14 && dnf clean all -y

# Copy global JupyterHub config file into place.
COPY jupyterhub_config.py jupyterhub_config.sh /opt/app-root/etc/
COPY .jupyter/jupyterhub_config.py .jupyter/jupyterhub_config.py

# Copy singleuser profile customization
COPY jupyterhub-singleuser-profiles /opt/app-root/lib/python3.8/site-packages

# Copy helper scripts.
COPY scripts/* /opt/app-root/bin/

# Copy python requirements
COPY requirements.txt .

RUN chown -R 1001:0 ${APP_ROOT} && \
    chmod -R g+w ${APP_ROOT}

USER 1001
# Install the dependencies
RUN pip install -U pip setuptools wheel && \
    pip install -r requirements.txt && \
    pip install --no-index --find-links=jupyterhub-singleuser-profiles -r requirements.txt

# COPY hack/oauthenticator/generic.py /opt/app-root/lib/python3.8/site-packages/oauthenticator/generic.py
# COPY hack/singleuser_profiles/api.py /opt/app-root/lib/python3.8/site-packages/jupyterhub_singleuser_profiles/api.py

# Copy and Install npm packages"
RUN npm install -g configurable-http-proxy@4.5.4 node-sass@4.14.1

# Run script to setup singleuser profile UI
RUN [ "sh", "-x", "/opt/app-root/bin/setup-jsp-ui.sh" ]

# Ensure passwd/group file intercept happens for any shell environment.
RUN echo "source /opt/app-root/etc/generate_container_user" >> /opt/app-root/etc/scl_enable

# Create additional directories.
RUN mkdir -p /opt/app-root/data

# Fixup permissions on directories and files.
RUN fix-permissions ${APP_ROOT} -P

CMD [ "/opt/app-root/bin/run.sh" ]

