
php_mysql_module:
  pkg.installed:
    - name: php-mysql

uninstall_apache2:
  pkg.purged:
    - name: apache2

http_dir:
  file.directory:
    - name: /var/www/html
    - user: www-data
    - group: www-data
    - makedirs: true

php_script:
  file.managed:
    - name: /var/www/html/index.php
    - source: salt://app/templates/index.php
    - template: jinja
    - user: www-data
    - group: www-data

