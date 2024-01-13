FROM debian:stable

ARG KUBE_VERS

ARG USERNAME=kube
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    apt update && \
    apt install -y curl gettext-base && \
    cd /tmp && \
    curl -SsfLO "https://dl.k8s.io/release/$KUBE_VERS/bin/linux/amd64/kubectl" && \
    curl -SsfLO "https://dl.k8s.io/release/$KUBE_VERS/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
    mv kubectl /usr/local/bin/ && \
    chmod +x /usr/local/bin/kubectl && \
    mkdir /home/$USERNAME/.kube && \
    chown $USERNAME:$USERNAME /home/$USERNAME/.kube && \
    apt-get autoremove --purge -y curl && \
    apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives

USER $USERNAME
WORKDIR /home/$USERNAME

ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]