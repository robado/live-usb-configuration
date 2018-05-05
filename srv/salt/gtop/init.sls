npm:
  pkg.installed

nodejs-legacy:
  pkg.installed

gtop:
  npm.installed:
    - require:
      - pkg: npm
