FROM nginx:1.27-alpine

ENV PORT=10000

COPY nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY scripts/generate-indexes.sh /usr/local/bin/generate-library-indexes

RUN rm -rf /usr/share/nginx/html/*

COPY Libraries/ /usr/share/nginx/html/
COPY Devices/ /usr/share/nginx/html/Devices/

RUN chmod +x /usr/local/bin/generate-library-indexes \
    && generate-library-indexes /usr/share/nginx/html

EXPOSE 10000
