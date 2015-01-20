# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.get']('supervisor:processes', {}) %}
{%- if processes %}
{%- for id, data in processes.iteritems() %}
supervisor_job_{{ id }}:
  file.managed:
    - source: salt://supervisor/templates/process.conf.jinja
    - template: jinja
    - id: {{ id }}
    - config: {{ data }}
    - watch_in:
      - service: supervisor
{%- endfor %}
{%- endif %}
