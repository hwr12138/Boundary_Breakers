from django.urls import path
from . import views

urlpatterns = [
    path('getItemLocations', views.customer_get_item_locations),
    path('getpathLocations', views.customer_get_path_locations),
    path('getPath', views.customer_get_paths),
]
