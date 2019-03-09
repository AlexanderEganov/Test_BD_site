from django.conf.urls import url

from . import views

app_name = 'book'
print(5)
urlpatterns = [
    url(r'', views.index, name='index'),
]
