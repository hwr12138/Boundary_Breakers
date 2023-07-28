from django.urls import path
from . import views

urlpatterns = [
    path('getprofile', views.customer_get_profile),
    path('editprofile', views.customer_profile)
]
