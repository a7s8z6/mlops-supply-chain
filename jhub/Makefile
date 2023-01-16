# Image URL to use all building/pushing image targets
REGISTRY ?= default-route-openshift-image-registry.apps-crc.testing
REPOSITORY ?= $(REGISTRY)/mlops

PYTHON_TAG ?= 1-117
PYTHON_IMG ?= registry.access.redhat.com/ubi8/python-38:$(PYTHON_TAG)
JHUB_VERSION ?= 1.5.1
JHUB_IMG := $(REPOSITORY)/jupyterhub:$(JHUB_VERSION)

podman-login:
	podman login --tls-verify=false -u $(oc whoami) -p $(oc whoami -t) default-route-openshift-image-registry.apps-crc.testing

podman-build-jhub:
	podman build --from $(PYTHON_IMG) . -t ${JHUB_IMG} -f Dockerfile

podman-push-jhub: podman-build-jhub
	podman push --tls-verify=false ${JHUB_IMG}

build: podman-build-jhub

push: podman-push-jhub
