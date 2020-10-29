include:
  - .requirements
  - certificates
  - .webserver

pterodactyl-panel:
  archive.extracted:
    - name: /var/www/pterodactyl
    - enforce_toplevel: false
    - source: https://github.com/pterodactyl/panel/releases/download/v1.0.3/panel.tar.gz
    - source_hash: sha256=259a066d6f4248755f7b0f239df45b70ba69f9364ad543917b238078bc356dab

bootstrap-cache:
  file.directory:
    - name: /var/www/pterodactyl/bootstrap/cache
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - mode
    - require:
      - archive: pterodactyl-panel

storage:
  file.directory:
    - name: /var/www/pterodactyl/storage
    - children_only: True
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - mode
    - require:
      - archive: pterodactyl-panel

env_file:
  file.copy:
    - name: /var/www/pterodactyl/.env
    - source: /var/www/pterodactyl/.env.example
    - require:
      - archive: pterodactyl-panel

dependencies:
  composer.installed:
    - name: /var/www/pterodactyl
    - no_dev: True
    - optimize: True
    - require:
      - archive: pterodactyl-panel
      - file: bootstrap-cache
      - file: storage
      - file: env_file

permissions:
  file.directory:
    - name: /var/www/pterodactyl
    - children_only: True
    - user: nginx
    - group: nginx
    - recurse:
      - group
      - user
    - require:
      - composer: dependencies

queue_listener:
  file.append:
    - name: /var/spool/cron/root
    - text: "* * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1"

queue_worker:
  file.managed:
    - name: /etc/systemd/system/pteroq.service
    - source: salt://pterodactyl/panel/pteroq.service
  service.running:
    - name: pteroq
    - enable: True
    - require:
      - file: queue_worker
    - watch:
      - file: queue_worker
