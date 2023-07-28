from django.urls import path
from . import views

urlpatterns = [
    path('usercart/modify', views.user_cart_modify_item),
    path('usercart/query', views.user_cart_query_item),
]