
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

If you want to incorporate the submodule's files directly into your main project and sever the link to the submodule's original Git repository, you can effectively "absorb" the submodule into the main repository. This process involves removing the submodule system and then adding the files directly into your main repository as if they were part of the original project.

Here's how you can do it step-by-step:

### 1\. Remove the Submodule Entry

First, you need to remove the submodule entry from the `.gitmodules` file and the main project's Git configuration:

-   Delete the submodule entry from `.gitmodules`:

    Open the `.gitmodules` file and remove the section related to the `docker` submodule.

-   Remove the submodule entry from Git's configuration:

    bash

    `git config -f .git/config --remove-section submodule.docker`

### 2\. Unstage the Submodule and Sync

After modifying the configuration, unstage the submodule and synchronize the changes:

bash

`git rm --cached docker
git commit -m "Remove submodule entry for docker"`

### 3\. Delete Submodule Files and Folders

Remove the submodule's metadata from the repository:

bash

`rm -rf .git/modules/docker`

### 4\. Convert Submodule to Regular Files

You can now convert the submodule to a regular directory within your main repository:

-   If you still need the contents from the submodule, make sure they are copied out before deleting the submodule folder:

    bash

    `cp -r docker docker_backup
    rm -rf docker
    mv docker_backup docker`

-   Add the previously submodule directory to your repository as normal files:

    bash

    `git add docker
    git commit -m "Add former submodule files as regular project files"`

### 5\. Push Changes

Finally, push your changes to the remote repository to ensure all changes are synced:

bash

`git push origin master`

By following these steps, you transform the contents of the `docker` submodule into a regular part of your main Git repository. This eliminates the submodule relationship and treats the former submodule's files like any other part of your project, with no links back to the original submodule repository.

This approach simplifies your repository's structure and might be easier to manage if you do not need to keep the submodule as a separate entity.

## Contributing

Contributions to enhance this setup are encouraged. Fork the repository, make your changes, and submit a pull request.

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.
