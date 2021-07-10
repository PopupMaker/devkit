# Popup Maker Developer Toolkit

1. Run `npm install && composer update` to install initial dependencies. 
2. Run `composer make-environment` to create a new .env file. Then customize the **Stack Versions** as needed.
3. Run `npm run docker:up`
4. Run `npm run install:plugins` to install Popup Maker and selected extensions.

## Stack

The following list outlines the current stack setup via docker-compose.

### CMS

- Percona MySQL
- WordPress Apache (PHP 8.0)

### Caching

- Memcached
- Redis

## WSL 2

- Additional docker config changes for Xdebug setup.
- Adds ${IP} environment variable automatically on build via `npm run start`

## Container Resources

- WordPress: [http://localhost/](http://localhost/)
- WP Admin: [http://localhost/wp-admin/](http://localhost/wp-admin/)

### Admin Tools

- Adminer: [http://localhost:8090](http://localhost:8090)
- PHP Memcache Admin: [http://localhost:8091](http://localhost:8091)
- Redis Commander: [http://localhost:8092](http://localhost:8092)

### Debug Tools

- Mailcatcher: [http://localhost:1080](http://localhost:1080)