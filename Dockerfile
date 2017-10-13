FROM golang:alpine
RUN apk add --no-cache \
  git \
  curl \
  supervisor \
  nginx \
  python2 \
  py2-pip \
  py2-cairo \
  gcc \
  make \
  libffi-dev \
  python2-dev \
  musl-dev
RUN git clone https://github.com/lomik/go-carbon.git /opt/go-carbon && \
  cd /opt/go-carbon/ && \
  make submodules && \
  make && \
  mv go-carbon /usr/bin/go-carbon
RUN export PYTHONPATH="/opt/graphite/lib/:/opt/graphite/webapp/"  && \
  pip install https://github.com/graphite-project/whisper/tarball/master && \
  pip install https://github.com/graphite-project/graphite-web/tarball/master && \
  pip install gunicorn && \
  cp /opt/graphite/webapp/graphite/local_settings.py.example /opt/graphite/webapp/graphite/local_settings.py && \
  cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/webapp/graphite/graphite_wsgi.py
COPY sys/ /
RUN PYTHONPATH=/opt/graphite/webapp /usr/bin/django-admin migrate --settings=graphite.settings --run-syncdb && \
  PYTHONPATH=/opt/graphite/webapp /usr/bin/django-admin collectstatic --noinput --settings=graphite.settings
CMD ["/usr/bin/supervisord"]
