base:
  '*':
    {% if salt['environ.has_value']('firstboot') %}
    - updates
    {% endif %}
    - pterodactyl.panel
