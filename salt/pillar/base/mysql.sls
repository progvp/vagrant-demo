
# Mysql is installed from formula. For demonstration purposes mysql is installed without root password

mysql:
  server:
    enabled: true
    version: '5.7'
    bind:
      address: '127.0.0.1'
      port: 3306

