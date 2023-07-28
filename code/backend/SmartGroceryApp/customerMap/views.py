from django.shortcuts import render
from django.http import JsonResponse
from companyInventory.models import companyInventory
from userCart.models import userCart
from django.views.decorators.csrf import csrf_exempt

# Create your views here.


@csrf_exempt
def customer_get_item_locations(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    customer_username = request.POST.get('customer_username')

    if customer_username is None:
        return JsonResponse({'status': 'no customer username was given'}, status=400)

    # query userCart to get all the products in the customer's cart
    customer_items = list(userCart.objects.filter(
        username=customer_username).values('company_username', 'product_name'))

    item_data_list = []

    # query companyInventory to get the data (location) of each product
    for customer_item_dict in customer_items:
        item_data = companyInventory.objects.filter(
            company_username=customer_item_dict["company_username"],
            product_name=customer_item_dict["product_name"]).values('product_name', 'aisle', 'shelf').get()

        item_data_list.append(item_data)

    return JsonResponse({'status': 'success', 'customer_items': item_data_list}, status=200)

@csrf_exempt
def customer_get_path_locations(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    items_list = request.POST.getlist('items_list')
    if items_list is None:
        return JsonResponse({'status': 'no items were given'}, status=400)

    # customer_items = list(userCart.objects.filter(
    #     username=customer_username).values('company_username', 'product_name'))

    items_location = []
    
    for item in items_list:
        # item_location = companyInventory.objects.filter(product_name=item).values_list('product_name', 'aisle', 'shelf').get() 
        item_location = list(companyInventory.objects.filter(product_name=item).values_list('product_name', 'aisle', 'shelf'))
        items_location.append(item_location)
        
    return JsonResponse({'status': 'success', 'customer_items': items_location}, status=200)

@csrf_exempt
def customer_get_paths(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    customer_username = request.POST.get('customer_username')

    if customer_username is None:
        return JsonResponse({'status': 'no customer username was given'}, status=400)

    customer_items = list(userCart.objects.filter(
        username=customer_username).values('company_username', 'product_name'))

    item_data_list = []

    for customer_item_dict in customer_items:
        item_data = companyInventory.objects.filter(
            company_username=customer_item_dict["company_username"],
            product_name=customer_item_dict["product_name"]).values('aisle', 'shelf').get()

        aisle_shelf_tup = (item_data['aisle'], item_data['shelf'])

        if aisle_shelf_tup not in item_data_list:
            item_data_list.append(aisle_shelf_tup)

    print(item_data_list)
    sorted_aisles = sorted(item_data_list)

    ret = []

    if (7, 4) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((7,4)))
        ret.append((7,4))
    if (7, 3) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((7,3)))
        ret.append((7,3))
    if (7, 2) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((7,2)))
        ret.append((7,2))
    if (7, 1) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((7,1)))
        ret.append((7,1))
    if (1, 1) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((1,1)))
        ret.append((1,1))
    if (1, 2) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((1,2)))
        ret.append((1,2))
    if (1, 3) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((1,3)))
        ret.append((1,3))
    if (1, 4) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((1,4)))
        ret.append((1,4))
    if (2, 1) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((2,1)))
        ret.append((2,1))
    if (2, 2) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((2,2)))
        ret.append((2,2))
    if (2, 3) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((2,3)))
        ret.append((2,3))
    if (2, 4) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((2,4)))
        ret.append((2,4))
    if (8, 1) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((8,1)))
        ret.append((8,1))
    if (8, 2) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((8,2)))
        ret.append((8,2))
    if (8, 3) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((8,3)))
        ret.append((8,3))
    if (8, 4) in sorted_aisles:
        sorted_aisles.pop(sorted_aisles.index((8,4)))
        ret.append((8,4))

    ret.extend(sorted_aisles)

    return JsonResponse({'status': 'success', 'customer_items': ret}, status=200)
    
