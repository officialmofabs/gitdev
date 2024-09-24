# Docker Fullstack App

This project provides a complete development environment with Apache, MariaDB, and MailHog, set up using Docker. It serves as a lightweight alternative to traditional development environments like XAMPP, offering advantages in terms of speed, simplicity, and space-saving.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Configuration Explanation](#configuration-explanation)
- [Advantages over XAMPP](#advantages-over-xampp)
- [Symfony](#symfony)
- [Why Use Batch Files?](#why-use-batch-files)

## Requirements

- Docker must be installed on your system.
- Basic knowledge of the command line is helpful.

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/1manfactory/Docker-Fullstack-App new-project
    ```
2. Navigate to the project directory:
    ```bash
    cd new-project
    ```
3. Run the `build-container.bat` script to build the Docker container:
    ```bash
    .\build-container.bat
    ```

## Usage

1. Start the container with:
    ```bash
    .\start-container.bat
    ```
2. Access the local server in your browser:
    - Apache: [http://localhost:8080](http://localhost:8080)
    - MailHog: [http://localhost:8025](http://localhost:8025)
	
3. Run bash
    ```bash
	docker ps
	docker exec -it <container_id> /bin/bash
	```

## Directory Structure

- `dockerfile`: Defines the Docker image with all necessary installations and configurations.
- `init.sh`: A script for initializing and configuring the container.
- `supervisord.conf`: Configures Supervisor to manage multiple services within the container.
- `build-container.bat`: Batch script for building the Docker image.
- `start-container.bat`: Batch script for starting the container.

## Configuration Explanation

### Dockerfile

The Dockerfile creates an image based on Debian and installs Apache2, MariaDB, MailHog, and Supervisor. It copies the necessary configuration files and sets the appropriate permissions.

### init.sh

The `init.sh` script configures the Apache web server and MariaDB during the container startup. It ensures that the `DirectoryIndex` settings are adjusted so that `index.php` is used as the default start page.

### supervisord.conf

The `supervisord.conf` file configures Supervisor to manage multiple services (Apache, MariaDB, MailHog) within the container, ensuring they all start correctly.

## Advantages over XAMPP

- **Space Saving:** Using Docker containers reduces disk space usage compared to installing a full XAMPP stack.
- **Speed:** Faster startup and running speeds due to the lightweight nature of containers.
- **Ease of Use:** Simplified setup and deployment process, with everything configured via the Dockerfile and initialization scripts.
- **Consistent Environment:** Provides a consistent development environment, avoiding the "it works on my machine" problem.
- **Dynamic Mounting:** Changes made in the local `./src` directory are immediately reflected in the container's `/var/www/html` directory.

## Symfony

1. Run bash
    ```bash
	docker ps
	docker exec -it <container_id> /bin/bash
    ```
2. Install Symfony with Profiler
    ```bash
	cd /var/www/html
	composer create-project symfony/skeleton my_project_name
	cd my_project_name
	composer require --dev symfony/web-profiler-bundle
    ```	
3. Edit Apache configuration to work smoothly with Symfony
    ```bash
    nano /etc/apache2/sites-available/000-default.conf
    ```
4. Enter this:
    ```bash
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/my_project_name/public

        <Directory /var/www/html/my_project_name/public>
            AllowOverride All
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
	</VirtualHost>
	```
5. Restart Apache
    ```bash
    service apache2 restart
    ```
6. Edit/Create .htaccess
	```bash
	nano /var/www/html/my_project_name/public/.htaccess
	```
7. Enter this:
	```bash
	<IfModule mod_rewrite.c>
		RewriteEngine On
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteRule ^(.*)$ index.php [QSA,L]
	</IfModule>
	```
8. Open in browser\
	[http://127.0.0.1:8080/](http://127.0.0.1:8080/)

## Why Use Batch Files?

The `docker run` command is encapsulated in a batch file (`start-container.bat`) for simplicity and convenience. This allows you to start the container with a single command, avoiding the need to remember and type out the full `docker run` command each time.
