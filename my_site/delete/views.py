from django.shortcuts import render

from django.http import HttpResponse

def index(request):
    recuest = None
    if recuest == None:
        print(1)
    return render(request, 'delete.html')
