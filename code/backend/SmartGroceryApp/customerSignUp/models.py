from django.db import models

# Create your models here.
class customer(models.Model):
    username = models.CharField(max_length=20)
    password = models.CharField(max_length=80)
    email = models.CharField(max_length=80)
    firstname = models.CharField(max_length=80)
    lastname = models.CharField(max_length=80)

    class Meta:
        db_table = 'customer_info'
