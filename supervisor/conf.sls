# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.items']('supervisor:processes', {}) %}
{%- if processes %}
{%- for id, data in processes.iteritems() %}
supervisor_job_{{ id }}:
  file.managed:
    - source: salt://supervisor/templates/process.conf.jinja
    - template: jinja
    - id: {{ id }}
    - config: {{ data }}
{%- endfor %}
{%- endif %}
