# Terraform Module toolchain/drone

Installs the Drone CI server on the given Kubernetes cluster:

* provisions an AWS RDS for PostgreSQL instance as a database backend
* provisions an AWS S3 bucket as a build logs storage backend
* installs the Drone CI server using the upstream Helm chart
* installs the Drone Kubernetes Runner using the upstream Helm chart

## Manual pre-installation steps

### Register Drone CI as an OAuth2 application on GitHub

* Add an OAuth2 application to your GitHub organization (see: [GitHub section in Drone documentation](https://readme.drone.io/server/provider/github/))

* Store the client ID and the client secret of the GitHub OAuth2 application at a safe place (like KeePass).

* Pass the client ID and the client secret of the GitHub OAuth2 application as parameters to this module.

## Manual post-installation steps

### Store admin user name and password at a safe place

* This module outputs the generated user name and the generated password of the Drone admin user. 
  Don't forget to store this information at a safe place!
  
### Add administration privileges to Drone users

Docker builds executed by Drone require privileged Docker containers and trusted Drone repositories. 
Unfortunately only Drone admin users are allowed to set the `trusted` flag on Drone repositories.
In order to assign administration privileges to Drone users, walk through the following steps:

* Invoke the `update user` operation of the Drone REST API with Postman (or a comparable REST client tool)
using the password of the Drone admin user as a bearer token (see: [User Update](https://docs.drone.io/api/users/users_update/) for details!)

