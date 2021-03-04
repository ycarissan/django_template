# django_template

```
python -m django --version
django-admin startproject mysite
cd mysite
python manage.py runserver
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
cat <<EOF > monsite/urls.py
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('polls/', include('polls.urls')),
    path('admin/', admin.site.urls),
]
EOF
python manage.py runserver
```
