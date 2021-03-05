sitename=$1
appname=$2
Appname=$(python << EOF
print("$appname".title())
EOF
)

echo $Appname

exit

python -m django --version
django-admin startproject ${sitename}
cd ${sitename}
python manage.py startapp ${appname}
cat <<EOF > ${appname}/views.py
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the ${appname} index.")
EOF
cat <<EOF > ${appname}/urls.py
from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
EOF
cat <<EOF > ${sitename}/urls.py
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('${appname}/', include('${appname}.urls')),
    path('admin/', admin.site.urls),
]
EOF
cat <<EOF > ${appname}/models.py
from django.db import models


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
EOF

sed -i "/^INSTALLED_APPS/a '"${appname}".apps."${Appname}"Config'," ${sitename}/settings.py
python manage.py migrate

python manage.py makemigrations ${appname}
python manage.py migrate
cat <<EOF > ${appname}/admin.py
from django.contrib import admin

from .models import Question

admin.site.register(Question)
EOF
python manage.py createsuperuser
