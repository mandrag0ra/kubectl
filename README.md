# Kubectl

Set build KUBE_VERS with kubectl version to install.
E.g : "v1.29.0"

Build :
`docker build --build-arg KUBE_VERS="v1.29.0" -t local/kubectl:1.29.0 .`