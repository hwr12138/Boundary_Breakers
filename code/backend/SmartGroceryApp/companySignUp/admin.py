from django.contrib import admin
from .models import company
from .models import companyProfile

# Register your models here.
admin.site.register(company)
admin.site.register(companyProfile)
