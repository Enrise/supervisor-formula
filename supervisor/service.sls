# Install Supervisor service
extend:
  supervisor:
    service.running:
      - enable: True
      - watch:
        - pkg: supervisor
      - require:
        - pkg: supervisor
