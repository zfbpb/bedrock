# Dockerized Bedrock/Sage10 & LAMP Stack

This project utilizes Docker to set up a development environment which includes MySQL, Apache, PHP, Bedrock, and several utility tools. It is defined using a docker compose file and accompanying Dockerfiles.

## Quickstart

After git clone, select versions of PHP, MySQL, Apache in .env and configure the WP_HOME and WP_SITEURL variables as needed in /build/.env, or leave the default values.

``` 
docker compose up bedrock
``` 
This command starts four containers:

## LAMP & Bedrock
* MySQL
* Apache
* PHP
* Bedrock

The Bedrock container performs setup tasks (if they have not been performed previously), and then it exits. Other containers (MySQL, Apache, and PHP) will continue to run, providing the necessary environment for WordPress to operate.

After the installation is complete, run:

```
cd web/app/themes/your-theme-name (default bedrock-sage)
composer install
yarn install && yarn build
```

This provides the user with commands to navigate into the theme directory and install necessary dependencies after the installation process has concluded.

Note: yarn build will generate a manifest; the theme will not work without it.

Next, you need to edit bud.config.js in themes folder
```
    .setUrl('http://localhost:3000')
    .setProxyUrl('http://localhost:8000') // <= your WP_HOME
```
Next run
``` 
yarn bud
```
◉ bud build development Compile source assets in `development` mode.

install WordPress, and switch the theme...

## Utility

Developers have the flexibility to utilize local development tools such as Composer, Yarn, wp-cli, Node, and others, provided they are installed with the appropriate versions. 
Alternatively, the tools available in the Utility container, which does not start automatically and must be manually initiated when needed, offer access to the same development tools with its specified versions

``` 
docker compose up utility -d
``` 

### Example Commands for Using the Utility Container:

Here are some examples to guide you on how to use various tools inside the utility container.

```bash
# Execute a WP-CLI command within the Utility container to view the WordPress installation information
docker-compose exec utility wp core version --path=/var/www/html/web/

# Using Composer to install additional packages within a specific theme
docker-compose exec utility composer require vendor/package-name -w /var/www/html/web/app/themes/your-theme-name

# Running an interactive shell session within the Utility container using a specific user
docker-compose exec -u username utility bash

# Using Node.js to run a script within your theme
docker-compose exec utility node /var/www/html/web/app/themes/your-theme-name/script.js

# Running Yarn to build assets in a specified theme
docker-compose exec utility yarn build -w /var/www/html/web/app/themes/your-theme-name
``` 
Note: Ensure the Utility container is running before executing these commands.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](LICENSE.md) file for details.
