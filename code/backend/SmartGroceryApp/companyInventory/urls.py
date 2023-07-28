from django.urls import path
from . import views

urlpatterns = [
    path('inventory/query', views.company_inventory_query), 
    path('inventory/create', views.company_inventory_create_item),
    path('inventory/delete', views.company_inventory_delete_item),
    path('inventory/update', views.company_inventory_update_item),
    path('inventory/query_all', views.inventory_query_all),
    path('inventory/search_item', views.search_item),
    path('inventory/show_item', views.show_item),
    path('inventory/search_item_by_type', views.search_item_by_type),
]