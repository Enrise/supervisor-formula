# Deal with the config

# Deal with the processes
{%- set processes = salt['pillar.get']('supervisor:processes', {}) %}
{%- if processes %}
{%- for id, process_data in processes.iteritems() %}
supervisor_job_{{ id }}:
  file.managed:
    - name: /etc/supervisor/conf.d/{{ id }}.conf
    - source: salt://supervisor/templates/process.conf.jinja
    - template: jinja
    - id: {{ id }}
    - config: {{ process_data }}
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor
{%- endfor %}
{%- endif %}
