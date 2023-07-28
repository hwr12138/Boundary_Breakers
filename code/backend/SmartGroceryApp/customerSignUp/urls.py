from django.urls import path
from . import views

urlpatterns = [
    path('signup', views.customer_sign_up)
]