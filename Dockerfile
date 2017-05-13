FROM centos:latest

RUN set -x \
  && yum -y install socat gunzip tar \
  && yum -y groupinstall 'Development Tools' \
  && mkdir /package && cd /package \
  && curl -sSO http://smarden.org/socklog/socklog-2.1.0.tar.gz \
  && tar xfvz socklog-2.1.0.tar.gz \
  && rm socklog-2.1.0.tar.gz \
  && cd admin/socklog-2.1.0 \
  && package/install \
  && yum -y autoremove gunzip tar \
  && yum -y groupremove 'Development Tools' \
  && yum -y clean all

ENV SYSLOG_PORT=8514
COPY run-socklog.sh /
RUN chmod 755 /run-socklog.sh
EXPOSE 8514/udp

#USER default

ENTRYPOINT ["/run-socklog.sh"]
