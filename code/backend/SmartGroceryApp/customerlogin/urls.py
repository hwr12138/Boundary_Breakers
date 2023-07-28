from django.urls import path
from . import views

urlpatterns = [
    path('login', views.customer_log_in)
]