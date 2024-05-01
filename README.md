
# Laravel Docker Environment Template

This repository is intended for developers working on Laravel projects who utilize Laravel Sail for local development and maintain a server used as a preproduction testing environment. It provides a Docker-based setup leveraging Laravel Sail to orchestrate containers and Supervisor to manage daemons, designed to streamline development and deployment processes.

## Prerequisites

This setup assumes:
- **Laravel Sail** is installed within your Laravel project, as this Docker environment depends on it for container management.
- **Composer** is installed on your local testing environment to fetch the Sail dependency required for bootstrapping image building and container deployment.

## Directory Structure

```
.
├── docker-compose.local.yaml
├── docker-compose.override.yaml
├── docker-compose.yaml
└── local
    ├── app
    │   ├── Dockerfile
    │   ├── php.ini
    │   ├── start-container
    │   └── supervisord.conf
    └── nginx
        └── site.conf
```

## Configuration Files Explained

- **`docker-compose.yaml`**: Primary Docker Compose file utilizing Laravel Sail.
- **`docker-compose.override.yaml`**: Development-specific overrides extending the main configuration.
- **`docker-compose.local.yaml`**: Configurations specific for local testing, managed via Sail.

### `local/app`
- **`Dockerfile`**: Defines the PHP environment managed by Sail.
- **`php.ini`**: Custom PHP configurations.
- **`start-container`**: Script integrating Supervisor for process management.
- **`supervisord.conf`**: Ensures services remain running.

### `local/nginx`
- **`site.conf`**: Nginx configuration for HTTP request handling.

## Usage

### Add Docker Setup as a Submodule

To integrate this Docker setup as a submodule in any Laravel project, follow these steps:

```bash
git submodule add https://github.com/deZbrown/laravel-sail-environment-extension.git docker
git submodule update --init --recursive
```

### Copy YAML files

To start the docker-compose setup, copy docker-compose yaml files to the root of your project
Update any volume or service information, particular to that project

### For Development

To start your services for development, navigate to your project directory and run:

```bash
./vendor/bin/sail -f docker-compose.yaml -f docker-compose.override.yaml up --build -d
```

### For Local Testing

Before running the following command, ensure Composer is installed to fetch necessary dependencies, including Sail:

```bash
./vendor/bin/sail -f docker-compose.yaml -f docker-compose.local.yaml up --build -d
```

### Visit your application at `http://localhost` or another configured port.

## Customization

Modify Docker files and configurations to meet specific requirements or accommodate additional services as needed.

## Contributing

Contributions to enhance this setup are encouraged. Fork the repository, make your changes, and submit a pull request.

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.
