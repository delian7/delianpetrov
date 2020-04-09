
About
=====
Rails 5 Web App for https://delianpetrov.com.
- Hosted on Compute Enginer on Google Cloud.

Setup Development Environment
======
1. Put `master.key` in `./config`.
2. Put the `google_cloud_secrets.json` in `./config`.
2. start the server and install dependencies

```
docker-compose up to start the server.
```

Set up gcloud-sdk
----

1. Run the login command and login
```
docker-compose exec delianpetrov gcloud auth login
```

Deploying
====

1. Open bash on container
```
docker-compose exec delianpetrov /bin/bash
```
2. Run this script

```
gcloud compute instances stop delianpetrov0 && \
gcloud compute instances set-machine-type delianpetrov0 --machine-type n1-standard-1 && \
gcloud compute instances start delianpetrov0 && \
sleep 30s && \
cap production deploy && \
gcloud compute instances stop delianpetrov0 && \
gcloud compute instances set-machine-type delianpetrov0 --machine-type f1-micro && \
gcloud compute instances start delianpetrov0
```