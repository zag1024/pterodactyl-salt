include:
  - epel
  - nginx
  - php
  - php.bcmath
  - php.cli.install
  - php.fpm
  - php.gd
  - php.json
  - php.mbstring
  - php.mysqlnd
  - php.opcache
  - php.pdo
  - php.xml
  - php.zip
  - php.composer
  - redis.server

general:
  pkg.installed:
    - pkgs:
      - curl
      - tar
      - unzip
      - zip

selinux-tools:
  pkg.installed:
    - pkgs:
      - mcstrans
      - policycoreutils
      - selinux-policy
      - selinux-policy-targeted
      - setools
      - setools-console
      - setroubleshoot-server

httpd_can_network_connect:
  selinux.boolean:
    - value: 1
    - persist: True

httpd_execmem:
  selinux.boolean:
    - value: 1
    - persist: True

httpd_unified:
  selinux.boolean:
    - value: 1
    - persist: True

firewall:
  service.running:
    - name: firewalld
    - enable: True
  firewalld.present:
    - name: public
    - default: True
    - services:
      - https
