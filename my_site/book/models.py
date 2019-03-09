from django.db import models

#БД

class Adres_city(models.Model):
    city = models.CharField(max_length=255)

class Adres_street(models.Model):
    street = models.CharField(max_length=255)

class job_place_job(models.Model):
    place_job = models.CharField(max_length=255)

class job_doljnost(models.Model):
    doljnost = models.CharField(max_length=255)

class contact(models.Model):
    id = models.AutoField(primary_key=True)
    FIO = models.CharField(max_length=255) #переменная типа char такой-то длины
    gender = models.CharField(max_length=255)
    phone = models.CharField(max_length=255)
    Email = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    street = models.CharField(max_length=255)
    place_job = models.CharField(max_length=255)
    job = models.CharField(max_length=255)
    def __stl__(self):
        return self.FIO


#b = contact(FIO='Саша не верит мне', sex='но он мужик')
#b.save()
