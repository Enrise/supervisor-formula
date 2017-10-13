# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.get']('supervisor:processes', {}) %}
{%- if processes %}
{%- for id, process_data in processes.items() %}
supervisor_job_{{ id }}:
  file.managed:
    - name: /etc/supervisor/conf.d/{{ id }}.conf
    - source: salt://supervisor/templates/process.conf.jinja
    - template: jinja
    - id: {{ id }}
    - context: {{ process_data }}
    - defaults:
        autostart: "true"
        autorestart: "unexpected"
        startsecs: 1
        startretries: 3
        exitcodes: "0,2"
        stopsignal: "TERM"
        stopwaitsecs: 10
        redirect_stderr: "false"
        numprocs: 1
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
{%- endfor %}
{%- endif %}
