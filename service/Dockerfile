FROM alpine:3.20
COPY service.sh /usr/local/bin/service.sh
RUN chmod +x /usr/local/bin/service.sh && mkdir -p /opt/demo-data /var/run/demo-service
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD test -f /var/run/demo-service/healthy
CMD ["/usr/local/bin/service.sh"]
