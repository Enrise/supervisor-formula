# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.items']('supervisor:processes'), {} %}
{%- if processes %}
{%- for name, data in processes.iteritems() %}
supervisor_job_{{name}}:
  file.managed:
    - source: salt://supervisor/templates/process.conf.jinja
    - template: jinja
    - config: {{ data }}
{%- endfor %}
{%- endif %}
