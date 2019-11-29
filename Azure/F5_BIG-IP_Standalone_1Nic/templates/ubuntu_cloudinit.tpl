#cloud-config
package_upgrade: true
packages:
  - nginx

runcmd:
  - sed -i '/sites-enabled/aserver { \n listen 127.0.0.1:80;\nserver_name 127.0.0.1;\n\n location /nginx_status {\nstub_status;\n}\n}\n' /etc/nginx/nginx.conf
  - systemctl restart nginx
  - wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.6-1_amd64.deb
  - sudo dpkg -i telegraf_1.12.6-1_amd64.deb
  - echo "[[inputs.nginx]]\n  urls = [\"http://localhost/nginx_status\"]\n  response_timeout = \"5s\"\n" >> /etc/telegraf/telegraf.conf
  - echo "[[outputs.http]]\n  url = \"https://ingestion.ovr.prd.f5aas.com:50443/beacon/v1/ingest-metrics\"\n  timeout = \"120s\"\n  method = \"POST\"\n  insecure_skip_verify = true\n  data_format = \"influx\"\n  content_encoding = \"identity\"\n  [outputs.http.headers]\n    Content-Type = \"text/plain; charset=utf-8\"\n    X-F5-Ingestion-Token = \"${NGINX_BEACON_TOKEN}\"" >> /etc/telegraf/telegraf.conf
  - systemctl restart telegraf 
