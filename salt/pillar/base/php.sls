## PHP fpm is installed from formula

php:
  # Use external repository instead the default (only Ubuntu family)
  use_external_repo: False
  # Set the external repository name (valid only if use_external_repo is not none)
  #external_repo_name: 'ondrej/php'
  # Set the MongoDB driver version. You can specify (optionally) the driver version
  # when you add the php.mongo formula to your execution list
  #mongo_version: "1.5.5"
  ng:
    # this section contains mostly grain filtered data, while overrides
    # are possible in the pillar for unique cases, if your OS is not
    # represented, please consider adding it to the map.jinja for
    # upstream inclusion
    version: 7.2
    lookup:

      # package definitions, these can be strings, lists of strings, or
      # lists of dictionaries
      pkgs:
        mysql: mysql
        # ensures both will be installed
        curl:
          - php-common
          - curl

      # php-fpm os-specific settings
      fpm:
        #conf: /location/of/php-fpm/config.conf
        #ini: /location/of/php-fpm/php.ini
        #pools: /location/of/php-fpm/pool.d
        #service: www

        # the default content of the php5-fpm main config file
        defaults:
          global:
            pid: /var/run/php/php7.2-fpm.pid

      # php-cli os-specific settings
      #cli:
      #  ini: /location/of/php-cli/php.ini

    # php-fpm settings
    fpm:

      # settings for the php-fpm service
      service:
        # if True, enables the php-fpm service, if False disables it
        enabled: True
        # additional arguments passed forward to
        # service.enabled/disabled
        opts:
          reload: True

    # php-cli settings
    cli:
      # settings to manage the cli's php.ini
      ini:
        # opts passed forward directly to file.managed
        opts:
          replace: False
        # contents of the php.ini file that are merged with defaults
        # from php.ng.ini.defaults. See php.ng.ini.defaults for ini-style
        # syntax guidelines
        settings:
          PHP:
            engine: 'Off'

    # php-xcache settings
    xcache:
      ini:
        opts: {}
        # contents of the xcache.ini file that are merged with defaults
        # from php.xcache.ini.defaults. See php.ng.ini.defaults for ini-style
        settings:
          xcache:
            xcache.size: 90M

    # global php.ini settings
    ini:
      # Default php.ini contents. These follow a strict format. The top-
      # level dict keys form ini group headings. Nested key/value
      # pairs represent setting=value statements. If a value is a list,
      # its contents will be joined by commas in final rendering.
      defaults:
        PHP:
          engine: on
          output_buffering: 4096
          disable_functions:
            - pcntl_alarm
            - pcntl_fork
            - pcntl_wait
        'CLI Server':
          cli_server_color: 'On'

    # When using php.ng.apache2 on FreeBSD:
    # Set this to False if you're not using apache-formula
    use_apache_formula: False
