from django.urls import path
from . import views

urlpatterns = [
    path('signup', views.company_sign_up),
    path('profile', views.company_change_profile)
]