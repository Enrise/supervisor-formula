# Install Supervisor service
extend:
  supervisor:
    service.running:
      - enable: True
      - watch:
        - file: /etc/supervisor/conf.d/*.conf
        - pkg: supervisor
      - require:
        - pkg: supervisor
