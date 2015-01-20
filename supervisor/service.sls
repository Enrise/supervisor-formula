# Install Supervisor service
extend:
  supervisor:
    service.running:
      - enable: True
      - reload: True
      - watch:
        - file: /etc/supervisor.d/*
        - pkg: supervisor
      - require:
        - pkg: supervisor
