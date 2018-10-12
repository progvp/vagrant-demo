
schema_dir:
  git.latest:
    - name: {{ pillar['app']['schema_git_url'] }}
    - target: {{ pillar['app']['schema_dir'] }}

work_db:
  mysql_database.present:
  - name: employees
  - user: root
  - require:
    - service: mysql_service

work_user:
  mysql_user.present:
  - host: 'localhost'
  - name: '{{ pillar['app']['db_user'] }}'
  - password: '{{ pillar['app']['db_password'] }}'
  - require:
    - mysql_database: work_db

work_user_grants:
  mysql_grants.present:
  - grant: all privileges
  - database: employees.*
  - user: {{ pillar['app']['db_user'] }}
  - host: 'localhost'
  - require:
    - mysql_user: work_user
