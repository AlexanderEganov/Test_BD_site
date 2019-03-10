from django.shortcuts import render
from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.http import HttpResponse
from django.http import HttpResponseRedirect
from . import models
from .models import contact
from .models import Adres_city
from .models import Adres_street
from .models import job_place_job
from .models import job_doljnost
from .forms import contactForm


def loading(request): #загрузка бд в файл homePage.html

    contacts = contact.objects.all()
    return render(request, 'homePage.html', locals())

def add(request):
    contacts = contact.objects.all() # все контакты (объекты класса contact) в данной переменной
    adreses_street = Adres_street.objects.all()
    adreses_city = Adres_city.objects.all()
    jobs_places_jobs = job_place_job.objects.all()
    jobs_doljnosts = job_doljnost.objects.all()
    peremennaya = ''
    peremennaya1 = ''
    peremennaya2 = ''
    peremennaya3 = ''
    if request.method == 'POST':
        #ПРоверка на место работы
        # filter() возвращает все объекты, которые найдет, get() возвращает первый, который нашел
        # функция filter() ищет все объекты, у которых поле place_job соответствует нашему запросу (input)
        #функция exists() возвращает 0/1, при 1 пойдет дальше по if, при 0 перейдет на else
        if (job_place_job.objects.filter(place_job=request.POST['Job_place_job']).exists()):
            print('нашел!!!!')
            j=job_place_job.objects.get(place_job=request.POST['Job_place_job']) #записывается найденный объект
            peremennaya=j.place_job # в переменную записываем поле найденного побъекта
        else:
            print('НЕ нашел!!!! , запишу чтоб не забыть')
            job_object = job_place_job(place_job = request.POST['Job_place_job'])# создает объект класса
            peremennaya=job_object.place_job
            job_object.save()

        # проверка на должность чтоб не повторять
        if (job_doljnost.objects.filter(doljnost=request.POST['Job_doljnost']).exists()):
            print('нашел!!!!')
            j=job_doljnost.objects.get(doljnost=request.POST['Job_doljnost'])
            peremennaya1=j.doljnost
        else:
            print('НЕ нашел!!! , запишу чтоб не забыть')
            job_object = job_doljnost(doljnost = request.POST['Job_doljnost'] )
            peremennaya1=job_object.doljnost
            job_object.save()

        # проверка на город чтоб не повторять
        if (Adres_city.objects.filter(city=request.POST['Adres_city']).exists()):
            print('нашел!!!!')
            j=Adres_city.objects.get(city=request.POST['Adres_city'])
            peremennaya2=j.city
        else:
            print('НЕ нашел!!! , запишу чтоб не забыть')
            job_object = Adres_city(city = request.POST['Adres_city'] )
            peremennaya2=job_object.city
            job_object.save()

        # проверка на улицу чтоб не повторять
        if (Adres_street.objects.filter(street=request.POST['Adres_street']).exists()):
            print('нашел!!!!')
            j=Adres_street.objects.get(street=request.POST['Adres_street'])
            peremennaya3=j.street
        else:
            print('НЕ нашел!!! , запишу чтоб не забыть')
            job_object = Adres_street(street = request.POST['Adres_street'] )
            peremennaya3=job_object.street
            job_object.save()

        object = contact(FIO = request.POST['FIO'], gender = request.POST['Gender'], phone = request.POST['phone'], Email = request.POST['E-mail'], city= peremennaya2, street = peremennaya3, place_job = peremennaya, job = peremennaya1)
        object.save()
    return render(request, 'add.html', locals())

def delete(request): #загрузка бд в файл homePage.html
    contacts = contact.objects.all()
    adreses_street = Adres_street.objects.all()
    adreses_city = Adres_city.objects.all()
    jobs_places_jobs = job_place_job.objects.all()
    jobs_doljnosts = job_doljnost.objects.all()
    if request.method == 'POST':
        print(request.POST['id_delete'])
        object = contact.objects.get(id=request.POST['id_delete'])
        print(request.POST['id_delete'])
        object.delete()

    return render(request, 'delete.html', locals())


def redact(request): #загрузка бд в файл homePage.html
    contacts = contact.objects.all()
    adreses_street = Adres_street.objects.all()
    adreses_city = Adres_city.objects.all()
    jobs_places_jobs = job_place_job.objects.all()
    jobs_doljnosts = job_doljnost.objects.all()
    if (request.method == 'POST' and request.POST['select']=='jast do it'): # с помощью радиокнопки получаем контакт
          object = contact.objects.get(id=request.POST['id_redact']) #сравниваем переданный id  с бд
    if (request.method == 'POST' and request.POST['select']=='jast dont it'):
          object = contact.objects.get(id=request.POST['id'])
          object.FIO = request.POST['FIO'] #заполняем поля тем, что в и загнали в input
          object.gender = request.POST['Gender']
          object.phone = request.POST['phone']
          object.Email = request.POST['E-mail']

          if (Adres_city.objects.filter(city=request.POST['Adres_city']).exists()):
              print('нашел!!!!')
              j=Adres_city.objects.get(city=request.POST['Adres_city'])
              peremennaya2=j.city
              object.city = peremennaya2 #само редактирование
          else:
              print('НЕ нашел!!! , запишу чтоб не забыть')
              job_object = Adres_city(city = request.POST['Adres_city'] )
              peremennaya2=job_object.city
              job_object.save()
              object.city = request.POST['Adres_city']


          if (Adres_street.objects.filter(street=request.POST['Adres_street']).exists()):
              print('нашел!!!!')
              j=Adres_street.objects.get(street=request.POST['Adres_street'])
              peremennaya3=j.street
              object.street = peremennaya3
          else:
              print('НЕ нашел!!! , запишу чтоб не забыть')
              job_object = Adres_street(street = request.POST['Adres_street'] )
              peremennaya3=job_object.street
              job_object.save()
              object.street = request.POST['Adres_street']


          if (job_place_job.objects.filter(place_job=request.POST['Job_place_job']).exists()):
              print('нашел!!!!')
              j=job_place_job.objects.get(place_job=request.POST['Job_place_job'])
              peremennaya=j.place_job
              object.place_job = peremennaya
          else:
              print('НЕ нашел!!!! , запишу чтоб не забыть')
              job_object = job_place_job(place_job = request.POST['Job_place_job'])
              peremennaya=job_object.place_job
              job_object.save()
              object.place_job = request.POST['Job_place_job']

          if (job_doljnost.objects.filter(doljnost=request.POST['Job_doljnost']).exists()):
              print('нашел!!!!')
              j=job_doljnost.objects.get(doljnost=request.POST['Job_doljnost'])
              peremennaya1=j.doljnost
              object.job = peremennaya1
          else:
              print('НЕ нашел!!! , запишу чтоб не забыть')
              job_object = job_doljnost(doljnost = request.POST['Job_doljnost'] )
              peremennaya1=job_object.doljnost
              job_object.save()
              object.job = request.POST['Job_doljnost']
          object.save()



    return render(request, 'redact.html', locals())

def find(request):
    find=[]
    find0=[]
    contacts = contact.objects.all()
    adreses_street = Adres_street.objects.all()
    adreses_city = Adres_city.objects.all()
    jobs_places_jobs = job_place_job.objects.all()
    jobs_doljnosts = job_doljnost.objects.all()
    for key in contacts: #key - объект класса контакт (все объекты по итерациям)
        find.append(key.id)
    find0=find
    print(find)
    find1 = 0
    find2 = 0
    find3 = 0
    find4 = 0
    find5 = 0
    find6 = 0
    find7 = 0
    find8 = 0
    chet = 0 #для подсчета заполненных форм
    listkey1=[]
    listkey2=[]
    listkey3=[]
    listkey4=[]
    listkey5=[]
    listkey6=[]
    listkey7=[]
    listkey8=[]
    if (request.method == 'POST'):

        if (request.POST['FIO']!=''):
            find1 = contact.objects.filter(FIO=request.POST['FIO'])
            chet = chet + 1
            for key in find1:
                listkey1.append(key.id)
            find=list(set(find) & set(listkey1)) #сравнивает ключи из этих спиской и сохраняет в find только те, которые совпали
        if (request.POST['Gender']!=''):
            find2=contact.objects.filter(gender=request.POST['Gender'])
            chet = chet + 1
            for key in find2:
                listkey2.append(key.id)
            find=list(set(find) & set(listkey2))
        if (request.POST['phone']!=''):
            find3=contact.objects.filter(phone=request.POST['phone'])
            chet = chet + 1
            for key in find3:
                listkey3.append(key.id)
            find=list(set(find) & set(listkey3))
        if (request.POST['E-mail']!=''):
            find4=contact.objects.filter(Email=request.POST['E-mail'])
            chet = chet + 1
            for key in find4:
                listkey4.append(key.id)
            find=list(set(find) & set(listkey4))
        if (request.POST['Adres_city']!=''):
            find5=contact.objects.filter(city=request.POST['Adres_city'])
            chet = chet + 1
            for key in find5:
                listkey5.append(key.id)
            find=list(set(find) & set(listkey5))
        if (request.POST['Adres_street']!=''):
            find6=contact.objects.filter(street=request.POST['Adres_street'])
            chet = chet + 1
            for key in find6:
                listkey6.append(key.id)
            find=list(set(find) & set(listkey6))
        if (request.POST['Job_place_job']!=''):
            find7=contact.objects.filter(place_job=request.POST['Job_place_job'])
            chet = chet + 1
            for key in find7:
                listkey7.append(key.id)
            find=list(set(find) & set(listkey7))
        if (request.POST['Job_doljnost']!=''):
            find8=contact.objects.filter(job=request.POST['Job_doljnost'])
            chet = chet + 1
            for key in find8:
                listkey8.append(key.id)
            find=list(set(find) & set(listkey8))
        print(find0)
        print(find1)
        result=list(set(find0) - set(find)) # ненужные объекты
        print(result)
        a=len(result)
        if (a==0):
            print('Ниче не нашел')
        if (a==1):
            contacts = contact.objects.exclude(id=result[0])#запришутя все эл-ты класса контакт кроме тех, у которых id совпаадет с id первого элемента в result
        if (a==2):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1])
        if (a==3):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2])
        if (a==4):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3])
        if (a==5):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4])
        if (a==6):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5])
        if (a==7):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6])
        if (a==8):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7])
        if (a==9):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8])
        if (a==10):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9])
        if (a==11):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10])
        if (a==12):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11])
        if (a==13):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11]).exclude(id=result[12])
        if (a==14):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11]).exclude(id=result[12]).exclude(id=result[13])
        if (a==15):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11]).exclude(id=result[12]).exclude(id=result[13]).exclude(id=result[14])
        if (a==16):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11]).exclude(id=result[12]).exclude(id=result[13]).exclude(id=result[14]).exclude(id=result[15])
        if (a==17):
            contacts = contact.objects.exclude(id=result[0]).exclude(id=result[1]).exclude(id=result[2]).exclude(id=result[3]).exclude(id=result[4]).exclude(id=result[5]).exclude(id=result[6]).exclude(id=result[7]).exclude(id=result[8]).exclude(id=result[9]).exclude(id=result[10]).exclude(id=result[11]).exclude(id=result[12]).exclude(id=result[13]).exclude(id=result[14]).exclude(id=result[15]).exclude(id=result[16])


    return render(request, 'find.html', locals())
