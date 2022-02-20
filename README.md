# Popup Maker Developer Toolkit


## Description

This project includes a ready to go devkit for developing Popup Maker plugins, including a custom docker stack, plugin installer

1. Run `npm install && npm run install:all` to install initial dependencies.
2. Run `composer make-environment` to create a new .env file. Then customize the **Stack Versions** as needed.
3. Run `npm run docker:up -- --debug` with optional `--admin`, `--debug`, or `--caching` flags, see below.
<!-- 4. Run `npm run install:plugins` to install Popup Maker and selected extensions. -->

NOTES: Currently if core plugin or extension requires composer install, it needs to be done manually.

## Docker Up Options

Options must be passed after a `--` flag.

`--admin` - This will install the admin services listed below.
`--caching` - This will install the caching services listed below.
`--debug` - This will install Xdebug & Mailcatcher debug tools.

### Other Commands

- `npm run docker:down` Shut down all project docker containers.
- `npm run docker:purge` Remove all project docker containers.
- `npm run docker:update` Update all project docker containers after an .env version change.
#### Experimental Commands
- `npm run install:packages` Install all npm packages for core & each extension.
- `npm run lerna:start` Run npm start for all core & extensions.

## Docker Troubleshooting

### Up issues

Sometimes the daemon isn't accessible due to your user not being root: https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue

The following commands should resolve it.

- `sudo groupadd docker`
- `sudo usermod -aG docker $USER`
- `newgrp docker`

### Folder Write Permission Fixes

Might have to run some of these to fix permission issues which need to be shared between you and the www-data user for full functionality such as installing plugins from Plugins page or writing error logs.

- `sudo usermod -aG www-data $USER`
- `sudo chown -R :www-data ./data/uploads && sudo chmod -vR g+w ./data/uploads`
- `sudo chown -R :www-data ./logs && sudo chmod -vR g+w ./logs`
- `sudo chown -R :www-data ./public && sudo chmod -vR g+w ./public`

## Stack

The following list outlines the current stack setup via docker-compose.

Versions are mostly controlled in the .env file.

### CMS

- **WordPress Apache**: [Site](http://localhost), [WP Admin][http://localhost/wp-admin/] [docker](https://hub.docker.com/_/wordpress/)
  - PHP Version: 8.0 by default, can be changed in .env
  - WP Version: Currently 5.8 RC2 by default, can be changed in .env
- **Percona MySQL**: [docker](https://hub.docker.com/_/percona/)
  - MySQL Version: 8.0 by default, can be changed in .env

### Admin Tools

- **Adminer**: [docker](https://hub.docker.com/_/adminer) [http://localhost:8090](http://localhost:8090)
- **Memcache Admin**: [docker](https://hub.docker.com/r/jahacdropboxa/memcached) [http://localhost:8091](http://localhost:8091)
- **Redis Commander**: [docker](rediscommander/redis-commander) [http://localhost:8092](http://localhost:8092)

### Caching

- Memcached: [docker](https://hub.docker.com/_/memcached/)
- Redis: [docker](https://hub.docker.com/_/redis/)

### Debug Tools

- XDebug: On port 9000 using host.docker.internal by default.
- Mailcatcher: [http://localhost:1080](http://localhost:1080)

## WSL 2

- Additional docker config changes for Xdebug setup.
- Adds ${IP} environment variable automatically on build via `npm run start`
