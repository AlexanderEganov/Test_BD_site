from django import forms
from .models import *

class contactForm(forms.ModelForm):# класс форм принемает обьект такой же как модел внешне
    class Meta:
        model = contact#модель принимает вид контакта
        exclude = [""]# пропуск полей
