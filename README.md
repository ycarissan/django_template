# django_template

```
python -m django --version
django-admin startproject mysite
cd mysite
# python manage.py runserver
python manage.py startapp polls
cat <<EOF > polls/views.py
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")
EOF
cat <<EOF > polls/urls.py
from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
EOF
cat <<EOF > mysite/urls.py
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
]
EOF
#  python manage.py runserver
cat <<EOF > polls/models.py
from django.db import models


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
EOF

cat <<EOF > mysite/settings.py
INSTALLED_APPS = [
    'polls.apps.PollsConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
EOF
python manage.py makemigrations polls
python manage.py migrate
```
```
cat <<EOF > polls/admin.py
from django.contrib import admin

from .models import Question

admin.site.register(Question)
EOF
python manage.py createsuperuser
python manage.py runserver
```
