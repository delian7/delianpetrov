
About
=====
Rails 5 Web App for https://delianpetrov.com.
- Hosted on Compute Enginer on Google Cloud.

Setup Development Environment
======
1. Extract `google_cloud_secrets.zip` to `./config`.
2. start the server and install dependencies by running

```
docker-compose up
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
2. Run `bin/deploy`