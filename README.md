# Docker Configuration Files for DocPath XF Repository

This is a complete example that shows how to deploy DocPath ® XF Repository in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- ´xfrepositorypackallplatforms-6.xx.y.z-java.jar`: DocPath ® XF Repository Installer.
- `DocPath License File.olc`: License file.
 
## Steps 
To successfully perform the example, follow the steps as indicated below:
- Use the `openjdk:8` image. This is a Linux Debian image with OpenJDK 8 pre-installed.
- Install DocPath ® XF Repository.
- Copy the license file into the image.
- Use port 1818 to receive generation requests.
- Run the `run.sh` file on the container entrypoint. `run.sh` is performed as follows:
  - Starts the license server to allow DocPath ® XF Repository execution.
  - Deploys DocPath ® XF Repository.

## Necessary Changes
In the `dockerfile` file:
- Change the `xfrepositorypackallplatforms-6.xx.y.z-java.jar` with the corresponding version of DocPath ® XF Repository.
- Change the `DocPath_License_File.olc` file with the corresponding license filename.

## How to Build and Deploy
Now we are going to build the container by executing the following sentence in the same directory where the dockerfile file is located:

`docker build -t docpath/xfrepository .`

**IMPORTANT!** the full stop at the end indicates the directory where the container is located. This is mandatory.

In the installation, the following values has been taken by default:
- -adminusername**admin**
- -adminpassword**admin**
- -licserverpath **/usr/local/docpath/licenseserver**
- -licserverport**1765**
- -databaseserver**MySQL** 
- -databasename**xfrepository** 
- -databasehost**localhost** 
- -databaseport**3306** 
- -databaseuser**root**
- -databasepassword**root**
- -databasecheckconnection**false**

Run the container once it has been built, using the following sentence:

`docker run --name xfrepository --hostname <container_hostname> --detach -p 1818:1818 -e DB_TYPE=<db_type> -e DB_HOST=<db_ip> -e DB_PORT=<db_port> -e DB_USER=<db_user> -e DB_PASS=<db_pass> -e DB_NAME=<db_name> -e AIM_URL=<aim_url> -e AIM_TOKEN=<aim_token> -e LOCAL_USER=<local_user> -e LOCAL_USER_PASS=<local_user_pass> docpath/xfrepository`

Deployment of the service applying the default database connection data:

`docker run --name xfrepository --hostname <container_hostname> --detach -p 1818:1818 -e AIM_URL=<aim_url> -e AIM_TOKEN=<aim_token> docpath/xfrepository`

In case you want to deploy the service in session mode, use the following command:

`docker run --name xfrepository --hostname <container_hostname> --detach -p 1818:1818 -e DB_TYPE=<db_type> -e DB_HOST=<db_ip> -e DB_PORT=<db_port> -e DB_USER=<db_user> -e DB_PASS=<db_pass> -e DB_NAME=<db_name> -e AIM_URL=<aim_url> -e AIM_TOKEN=<aim_token> -e TRANSACTION_ID=<session_transaction_id> -e LICENSE_ADDRESS=<license_address> -e LICENSE_PORT=<license_port> -e SHUTDOWN_SESSION=<session_shutdown_session> -e LOCAL_USER=<local_user> -e LOCAL_USER_PASS=<local_user_pass> docpath/xfrepository`

The parameters used are:
- `--name`: this parameter indicates the name of the container, in this case xfrepository.
- `--hostname`: this parameter indicates the hostname of the machine with the license.
- `--detach`: this parameter indicates that no messages are displayed in the execution console, silent mode.
- `-p 1818:1818`: this parameter indicates the port of both host machine and xfrepository.
- `db_type`: Type of the database (MySQL, SQLServer or Oracle).
- `db_ip`: IP of the database.
- `db_port`: Port of the database.
- `db_user`: User with privileges to connect to the database.
- `db_pass`: Password of the user with privileges.
- `db_name`: Name of the database or schema where xfrepository is installed.
- `aim_url`: AIM application URL.
- `aim_token`: Application token in AIM.
- `docpath/xfrepository`: Name assigned previously while building the container.
- `session_transaction_id`: Identifier of the license in session mode. Mandatory field in case you want to apply a session license.
- `license_address`: Address of the license server. Mandatory field in case you want to apply a session license.
- `license_port`: License server port. Mandatory field in case you want to apply a session license.
- `session_shutdown_session`: Indicates whether the associated session within the license server should be shutdown after closing the application. Available values are TRUE or FALSE. Mandatory field in case you want to apply a session license.
- `local_user`: Provide the name of the local user. By default, admin.
- `local_user_pass`: Provide the password for the local user. By default, admin.


**IMPORTANT!** The command `sleep 5` is added from `run.sh`. This is a delay necessary for the license server to launch before DocPath® XF Repository is deployed. If it is removed or if it indicates an insufficient time (in seconds), an error may occur with the product license.
