#!/bin/bash
set -e

# Build AMD64 image
podman build --platform linux/amd64 --build-arg ARCH=amd64 -t quay.io/adavies2_uk/argocd-sidecar-plugin:amd64-v1.0.0 .

# Build s390x image
podman build --platform linux/s390x --build-arg ARCH=s390x -t quay.io/adavies2_uk/argocd-sidecar-plugin:s390x-v1.0.0 .

# Create manifest and add images
podman manifest create quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0
podman manifest add quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0 localhost/argocd-sidecar-plugin:amd64-v1.0.0
podman manifest add quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0 localhost/argocd-sidecar-plugin:s390x-v1.0.0

# Tag as latest
podman tag quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0 quay.io/adavies2_uk/argocd-sidecar-plugin:latest

# Push both v1.0.0 and latest
podman manifest push quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0 docker://quay.io/adavies2_uk/argocd-sidecar-plugin:v1.0.0
podman manifest push quay.io/adavies2_uk/argocd-sidecar-plugin:latest docker://quay.io/adavies2_uk/argocd-sidecar-plugin:latest
