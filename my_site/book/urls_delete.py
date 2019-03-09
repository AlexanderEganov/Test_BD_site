from django.conf.urls import url

from . import views

app_name = 'book'
print('delete')
urlpatterns = [
    url(r'', views.delete, name='delete'),
]
