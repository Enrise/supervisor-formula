# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.get']('supervisor:processes', {}) %}
{%- if processes %}
{%- for id, process_data in processes.items() %}

{% set process_name = "%(program_name)s" %}
{% if process_data.numprocs is defined and process_data.numprocs > 1 %}
{% set process_name = "%(program_name)s_%(process_num)02d" %}
{% endif %}

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
        process_name: "{{ process_name }}"
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
{%- endfor %}
{%- endif %}
