
About
=====
Rails 5 Web App for https://delianpetrov.com.
- Hosted on Compute Enginer on Google Cloud.

Setup Development Environment
======
1. Extract password protected `./config/secrets.zip` to `./config`.
2. Drag `./google_cloud/master.key` back to `./config`
3. start the server and install dependencies by running

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

```
docker-compose exec delianpetrov bin/deploy
```
