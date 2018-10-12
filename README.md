# Vagrant demo

Demo app is a simple app which performs a simple select from DB and display it. It implemented in Vagrant machine, based on Ubuntu 18.04, consists of Nginx, PHP-FPM, Mysql and configured by SaltStack.
Salt formulas are used to install Nginx, PHP-FPM and Mysql server

#### Installation

You must have Vagrant installed. Clone this repo and run `vagrant up`
It will download the needed image, and will configure it with SaltStack. After installation is done, open in your browser this URL: `http://localhost:8080` - you will see the output of application

#### Configuration

You can modify pillars values in `salt/pillar/base` directory.
- `app.sls` - configuration of application (php script)
- `common.sls` - common parameters, like installed basic packages
- `mysql.sls` - configuration of mysql server, based on example from formula
- `nginx.sls` - configuration of nginx, based on example from formula
- `php.sls` - configuration of php, based on example from formula
- `top.sls` - main pillar file

On initial server configuration, new DB is created with root user without password (password is not set for demo purposes) and mysql user created for application with credentials configured in `app.sls`

Nginx config templates are located in `salt/states/base/nginx-config/files` - they are for creating a simple and basic nginx webserver with PHP-FPM upstream, you are free to modify it.
