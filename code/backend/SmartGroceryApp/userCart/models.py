from django.db import models

# Create your models here.
class userCart(models.Model):
    #used to get right user
    username=models.CharField(max_length=20)
    # used to query company inventory for the rest
    company_username = models.CharField(max_length=20)
    product_name = models.CharField(max_length=30)
    # amount user has
    quantity=models.IntegerField()

    class Meta:
        db_table = 'user_carts'