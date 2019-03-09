from django.shortcuts import render
from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.http import HttpResponse

def index(request):
    return render(request, 'add.html')

def loading_add(request):
    contacts = contact.objects.all()
    return render(request, 'add.html', locals())
