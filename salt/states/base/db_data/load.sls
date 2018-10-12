
load_data:
  cmd.run:
    - name: cd {{ pillar['app']['schema_dir'] }}; mysql -uroot <employees.sql
