Inception Docker Environment
This repository contains a Docker-based environment orchestrated via Docker Compose (managed by a Makefile) to run multiple services. All Docker images are built using Debian Bullseye as the base operating system.

Table of Contents
Overview
Services
Nginx
MariaDB
WordPress
Redis
FTP
Static Site
Adminer
File Manager
Project Structure
Environment Variables
Secrets
Volumes
Makefile Commands
Usage
License
Overview
This project sets up a multi-service Docker environment for:

A WordPress website (connected to MariaDB)
A Redis server for caching or session management
Nginx as a reverse proxy/SSL termination for WordPress (and other services)
An FTP server to manage files
A Static Site container for serving additional content
An Adminer service for easy database administration
A File Manager for handling server files through a web-based interface
All containers are built from debian:bullseye Docker images, ensuring a consistent underlying operating system across the environment.

Services
Below is a brief description of each service defined in the docker-compose.yml:

Nginx
Role: Reverse proxy and SSL termination for WordPress (and possibly other services).
Ports: Exposes port 443.
MariaDB
Role: Relational database used by WordPress.
Data: Stored on a persistent volume to prevent data loss.
WordPress
Role: Content management system, depends on MariaDB for the database.
Data: Stored on a persistent volume.
Redis
Role: In-memory data store for caching, session storage, or other use cases.
FTP
Role: FTP server allowing file management, connected to the WordPress data volume.
Ports: Exposes ports 21 (control), 20 (data), and 30000-30009 (passive ports).
Static Site
Role: Serves a simple static HTML/CSS/JS site, also depends on WordPress to ensure the main environment is up.
Data: Located on the same volume as WordPress (for demonstration or integration).
Adminer
Role: Web-based interface to manage MariaDB databases.
Depends on: MariaDB and WordPress.
File Manager
Role: A web-based file manager interface.
Ports: Exposes port 8082 for access.
Depends on: WordPress.
Data: Linked to the WordPress volume.
Project Structure
arduino
Copy
Edit
.
├── docker-compose.yml
├── Makefile
├── requirements
│   ├── mariadb
│   │   └── Dockerfile
│   ├── nginx
│   │   └── Dockerfile
│   ├── wordpress
│   │   └── Dockerfile
│   ├── bonus
│   │   ├── redis
│   │   │   └── Dockerfile
│   │   ├── ftp
│   │   │   └── Dockerfile
│   │   ├── static-site
│   │   │   └── Dockerfile
│   │   ├── adminer
│   │   │   └── Dockerfile
│   │   └── file-manager
│   │       └── Dockerfile
├── secrets
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── wp_admin_password.txt
│   ├── wp_user_password.txt
│   ├── ftp_password.txt
│   └── file_manager_password.txt
├── .env
└── README.md
Environment Variables
The .env file (referenced by docker-compose.yml) contains environment variables needed for various services. Common variables might include:

ini
Copy
Edit
DB_USER=someuser
DB_NAME=wordpress
FTP_USER=ftpuser
# ...
Make sure to update these values to match your desired configuration. Some containers also rely on Docker secrets (see Secrets).

Secrets
Docker secrets are used for sensitive data like passwords. Each secret is stored in a text file within the secrets directory. The docker-compose.yml references them as follows:

db_password → ../secrets/db_password.txt
db_root_password → ../secrets/db_root_password.txt
wp_admin_password → ../secrets/wp_admin_password.txt
wp_user_password → ../secrets/wp_user_password.txt
ftp_password → ../secrets/ftp_password.txt
file_manager_password → ../secrets/file_manager_password.txt
Important:

Ensure you do not commit real passwords to a public repository.
Consider ignoring the secrets directory in your .gitignore.
Volumes
Three main volumes are defined to persist data beyond container restarts:

mariadb_data: Binds to /home/bassem/data/db on the host.
wordpress_data: Binds to /home/bassem/data/wp on the host.
redis_data: Binds to /home/bassem/data/redis on the host.
These paths and mounting options can be modified in docker-compose.yml if needed.

Makefile Commands
A Makefile is provided to simplify Docker Compose operations. Common targets might include:

make up
Builds images (if not already built) and starts all containers in the background.

make down
Stops and removes containers, networks, and (optionally) volumes.

make build
Forces a rebuild of all images.

make restart
Restarts all services (an alternative to make down followed by make up).

Customize these targets in the Makefile to fit your workflow.

Usage
Clone the repository:

bash
Copy
Edit
git clone https://github.com/your-username/inception-docker-environment.git
cd inception-docker-environment
Set up .env file:

Copy the example .env (if provided) or create one.
Update the environment variables (DB credentials, FTP user, etc.) to your preference.
Add secrets:

Place your secret passwords in secrets/*.txt files.
Make sure each file contains only the sensitive value (no extra spaces or newlines).
Build and start services with Make:

bash
Copy
Edit
make up
This command uses Docker Compose internally to build images from debian:bullseye and start services.
Verify services:

Nginx: Access via https://localhost/ (or the configured domain).
WordPress: Finish setup at https://localhost/wp-admin.
Adminer: Access at http://localhost:<adminer_port> (if mapped).
File Manager: Access at http://localhost:8082.
Shut down:

bash
Copy
Edit
make down
Stops and removes containers, but persistent data remains in the mapped volumes.
License
This project is licensed under the MIT License - feel free to modify it as needed.

Contributing
Fork the repository
Create your feature branch (git checkout -b feature/awesome-feature)
Commit your changes (git commit -am 'Add awesome feature')
Push to the branch (git push origin feature/awesome-feature)
Create a new Pull Request
Thank you for using this Docker Compose environment! If you have any questions or suggestions, feel free to open an issue or submit a pull request.