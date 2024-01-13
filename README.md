# Kubectl

Set build KUBE_VERS with kubectl version to install.

E.g : "v1.29.0"

Build :
```
docker build --build-arg KUBE_VERS="v1.29.0" -t local/kubectl:1.29.0 .
```

Or in CI/CD :
```
build_image:
  stage: build
  image: 
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    - echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json
    - /kaniko/executor
      --context "${CI_PROJECT_DIR}"
      --build-arg KUBE_VERS=${CI_COMMIT_TAG}
      --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
      --destination "${CI_REGISTRY_IMAGE}:${CI_COMMIT_TAG}"
      --destination "${CI_REGISTRY_IMAGE}:latest"
  rules:
    - if: $CI_COMMIT_TAG
```

