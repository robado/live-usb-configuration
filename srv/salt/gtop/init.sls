npm:
  pkg.installed

nodejs:
  pkg.installed:
   {% if grains['osrelease'] == '18.04' %}
   - name: nodejs
   {% elif grains['osrelease'] == '16.04' %}
   - name: nodejs-legacy
   {% endif %}

gtop:
  npm.installed:
    - require:
      - pkg: npm
