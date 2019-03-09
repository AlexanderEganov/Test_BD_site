from django.contrib import admin

from .models import contact
admin.site.register(contact)

from .models import Adres_city
admin.site.register(Adres_city)

from .models import job_place_job
admin.site.register(job_place_job)

from .models import Adres_street
admin.site.register(Adres_street)

from .models import job_doljnost
admin.site.register(job_doljnost)
