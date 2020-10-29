webserver:
  file.managed:
    - name: /etc/nginx/conf.d/pterodactyl.conf
    - mode: 644
    - source: salt://pterodactyl/panel/webserver/pterodactyl.conf
    - template: jinja
