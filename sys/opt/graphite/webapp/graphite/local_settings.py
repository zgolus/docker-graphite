TIME_ZONE = 'Europe/Berlin'

DATABASES = {
   'default': {
       'NAME': '/opt/graphite/graphite.db',
       'ENGINE': 'django.db.backends.sqlite3',
       'USER': '',
       'PASSWORD': '',
       'HOST': '',
       'PORT': ''
   }
}
REMOTE_PREFETCH_DATA = True
REMOTE_FIND_TIMEOUT = 60
REMOTE_FETCH_TIMEOUT = 60
