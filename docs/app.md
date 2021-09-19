# Application

## Build Application

Build application with docker.

```bash
docker build -t asis.gcr.io/<project_id>/devops-test:dev .
```

Login GCR with gcloud cli.

```bash
gcloud auth configure-docker
```

Then push image to GCR.

```bash
docker push asia.gcr.io/<project_id>/devops-test:dev
```

## Deploy Graphite Statd

Install Graphite for collect stats.

```bash
helm repo add kiwigrid https://kiwigrid.github.io
helm install graphite --set ingress.enabled=false kiwigrid/graphite \
  --set ingress.enabled=false --set-string image.tag=1.1.8-1 \
  --version 1.1.7-6
```

## Deploy Application

```bash
kubectl apply -f deploys/app.yml
```

## View Metrics

```bash
kubectl port-forward svc/graphite 8080:8080
```

Open your browser to http://localhost:8080.
