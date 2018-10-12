
# Nginx is installed from formula

nginx:
  ng:
    # Use the official's nginx repo binaries
    install_from_repo: True

    source:
      opts: {}

    package:
      opts: {} # this partially exposes parameters of pkg.installed

    service:
      enable: True # Whether or not the service will be enabled/running or dead
      opts: {} # this partially exposes parameters of service.running / service.dead

    server:
      opts: {} # this partially exposes file.managed parameters as they relate to the main nginx.conf file

      # nginx.conf (main server) declarations
      # dictionaries map to blocks {} and lists cause the same declaration to repeat with different values
      config:
        source_path: salt://nginx-config/files/nginx.conf # IMPORTANT: This option is mutually exclusive with the rest of the
                                                          # options; if it is found other options (worker_processes: 4 and so
                                                          # on) are not processed and just upload the file from source
    servers:
      disabled_postfix: .disabled # a postfix appended to files when doing non-symlink disabling
      symlink_opts: {} # partially exposes file.symlink params when symlinking enabled sites
      rename_opts: {} # partially exposes file.rename params when not symlinking disabled/enabled sites
      managed_opts: {} # partially exposes file.managed params for managed server files
      dir_opts: {} # partially exposes file.directory params for site available/enabled dirs

      # server declarations
      # servers will default to being placed in server_available
      managed:
        mysite: # relative pathname of the server file
          # may be True, False, or None where True is enabled, False, disabled, and None indicates no action
          enabled: False
          # Remove the site config file. Nice to clean up the conf.d (or sites-available).
          # It also remove the symlink (if it is exists).
          # The site MUST be disabled before delete it (if not the nginx is not reloaded).
          deleted: True
          ###########
          ## Modify  'available_dir' AND 'enabled_dir' '/etc/nginx' location to alternative value.
          ###########
          available_dir: /etc/nginx/sites-available # an alternate directory (not sites-available) where this server may be found
          enabled_dir: /etc/nginx/sites-enabled # an alternate directory (not sites-enabled) where this server may be found
          disabled_name: mysite.aint_on # an alternative disabled name to be use when not symlinking
          overwrite: True # overwrite an existing server file or not

          # May be a list of config options or None, if None, no server file will be managed/templated
          # Take server directives as lists of dictionaries. If the dictionary value is another list of
          # dictionaries a block {} will be started with the dictionary key name
          config:
            - server:
              #- server_name: localhost
              - listen:
                - 80
                - default_server
              - index:
                - index.html
                - index.htm
              - location ~ .htm:
                - try_files:
                  - $uri
                  - $uri/ =404
                - test: something else

        default: # Using source_path options to upload the file instead of templating all the file
          enabled: True
          available_dir: /etc/nginx/sites-available
          enabled_dir: /etc/nginx/sites-enabled
          config:
            source_path: salt://nginx-config/files/default

