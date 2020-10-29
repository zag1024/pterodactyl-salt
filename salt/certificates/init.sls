include:
  - letsencrypt.install
dns_api:
  file.managed:
    - name: /root/dns_api.ini
    - mode: 600
    - contents_pillar: dns:api_credentials
  pkg.installed:
    - pkgs:
      - python3-certbot-dns-cloudflare
certificate:
  acme.cert:
    - name: {{ pillar['dns']['hostname'] }}.{{ pillar['dns']['domain'] }}
    - email: {{ pillar['user']['email'] }}
    - dns_plugin: cloudflare
    - dns_plugin_credentials: /root/dns_api.ini
    - mode: 600
    - server: {{ pillar['dns']['acme_server'] }}
    - require:
      - file: dns_api
      - pkg: dns_api
