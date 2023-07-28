from django.shortcuts import render
from django.http import JsonResponse
from .models import companyInventory
from django.views.decorators import csrf
from django.views.decorators.csrf import csrf_exempt
from django.core import serializers
from django.core.files.storage import FileSystemStorage

# Create your views here.
@csrf_exempt
def company_inventory_query(request):

    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    company_username = request.POST.get('company_username')


    if company_username is None:
        return JsonResponse({'status': 'no company was given'}, status=400)

    # if company.objects.filter(username=username):
    #     return JsonResponse({'status': 'username already exists'}, status=400)

    q = companyInventory.objects.filter(company_username = company_username)


    company_dicts = list(q.values())  # A list of dictionaries, each index is an entry
    # print(company_dict)

    if len(company_dicts) == 0:
        return JsonResponse({'status': 'No items in company'}, status=404)

    items = []

    

    for comp_dict in company_dicts:
        items.append(list(comp_dict.values()))
    

    return JsonResponse({
            'status': 'success',
            'items': items
        }, 
        status=201)

@csrf_exempt
def inventory_query_all(request):

    if request.method != 'GET':
        return JsonResponse({'status': 'did not receive a GET request'}, status=403)


    # if company.objects.filter(username=username):
    #     return JsonResponse({'status': 'username already exists'}, status=400)

    q = companyInventory.objects.all()


    company_dicts = list(q.values())  # A list of dictionaries, each index is an entry
    # print(company_dict)

    if len(company_dicts) == 0:
        return JsonResponse({'status': 'No items in company'}, status=404)

    items = []

    for comp_dict in company_dicts:
        items.append(list(comp_dict.values()))
    

    return JsonResponse({
            'status': 'success',
            'items': items
        }, 
        status=201)


@csrf_exempt
def company_inventory_create_item(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    company_username = request.POST.get('company_username')
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    description = request.POST.get('description')
    price = request.POST.get('price')
    aisle = request.POST.get('aisle')
    shelf = request.POST.get('shelf')
    image_file = 'company_items/default_item.png'

    if company_username is None:
        return JsonResponse({'status': 'no company username was given'}, status=400)

    if product_name is None:
        return JsonResponse({'status': 'no product name was given'}, status=400)

    if product_type is None:
        return JsonResponse({'status': 'no product type was given'}, status=400)

    if description is None:
        return JsonResponse({'status': 'no description was given'}, status=400)

    if price is None:
        return JsonResponse({'status': 'no price was given'}, status=400)

    if aisle is None:
        return JsonResponse({'status': 'no aisle was given'}, status=400)

    if shelf is None:
        return JsonResponse({'status': 'no shelf was given'}, status=400)

    if not price.isdecimal():
        return JsonResponse({'status': 'price must be a decimal number'}, status=400)

    if int(aisle) > 200 or int(aisle) < 1:
        return JsonResponse({'status': 'Aisle out of range, please choose a number between 1 and 200'}, status=406)

    if int(shelf) > 1000 or int(shelf) < 1:
        return JsonResponse({'status': 'Shelf out of range, please choose a number between 1 and 1000'}, status=406)

    company_items = companyInventory.objects.filter(company_username = company_username)

    company_product = company_items.filter(product_name = product_name)

    company_product_dict = list(company_product.values())  # A list of dictionaries, each index is an entry

    if len(company_product_dict) > 0:
        return JsonResponse({'status': 'Item with same name already exists in your company inventory'}, status=400)


    if 'image_source' in request.FILES:
        image = request.FILES['image_source']
        image_file = 'company_items/' + image.name
        fs = FileSystemStorage()
        image_file = fs.save(image_file, image)

    new_item = companyInventory(company_username=company_username, product_name=product_name,
                                    product_type=product_type, description=description, price=price,
                                    aisle=aisle, shelf=shelf, image_source=image_file)
    
    new_item.save()

    return JsonResponse({'status': 'success'}, status=201)

@csrf_exempt
def company_inventory_update_item(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    company_username = request.POST.get('company_username')
    id = request.POST.get('id')
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    description = request.POST.get('description')
    price = request.POST.get('price')
    aisle = request.POST.get('aisle')
    shelf = request.POST.get('shelf')

    

    if company_username is None:
        return JsonResponse({'status': 'no company name was given'}, status=400)

    if id is None:
        return JsonResponse({'status': 'no product id was given'}, status=400)

    if product_name is None:
        return JsonResponse({'status': 'no product name was given'}, status=400)

    if product_type is None:
        return JsonResponse({'status': 'no product type was given'}, status=400)

    if description is None:
        return JsonResponse({'status': 'no description was given'}, status=400)

    if price is None:
        return JsonResponse({'status': 'no price was given'}, status=400)

    if aisle is None:
        return JsonResponse({'status': 'no aisle was given'}, status=400)

    if shelf is None:
        return JsonResponse({'status': 'no shelf was given'}, status=400)

    if int(aisle) > 200 or int(aisle) < 1:
        return JsonResponse({'status': 'Aisle out of range, please choose a number between 1 and 200'}, status=406)

    if int(shelf) > 1000 or int(shelf) < 1:
        return JsonResponse({'status': 'Shelf out of range, please choose a number between 1 and 1000'}, status=406)

    company_items = companyInventory.objects.filter(company_username = company_username)

    company_product = company_items.filter(id = id)

    company_product_dict = list(company_product.values())  # A list of dictionaries, each index is an entry

    if len(company_product_dict) == 0:
        return JsonResponse({'status': 'No matching item in company'}, status=404)

    if 'image_source' in request.FILES:
        image = request.FILES['image_source']
        image_file = 'company_items/' + image.name
        fs = FileSystemStorage()
        image_file = fs.save(image_file, image)

        new_item = companyInventory(company_username=company_username, product_name=product_name,
                                    product_type=product_type, description=description, price=price,
                                    aisle=aisle, shelf=shelf, image_source=image_file)
    else:
        new_item = companyInventory(company_username=company_username, product_name=product_name,
                                    product_type=product_type, description=description, price=price, 
                                    aisle=aisle, shelf=shelf, image_source="NO_IMG")
    
    new_item.save()

    return JsonResponse({'status': 'success'}, status=201)

@csrf_exempt
def company_inventory_delete_item(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)
    
    try:
        product_id = request.POST.get('id')
    except:
        return JsonResponse({'status': 'unable to fetch the item id'}, status=500)
        
    item = companyInventory.objects.filter(id=product_id)
    
    if item:
        if companyInventory.objects.filter(id=product_id).delete():    
            return JsonResponse({'status': 'success'}, status=201)
        else: 
            return JsonResponse({'status': 'unable to remove the item'}, status=400)
    else:
        return JsonResponse({'status': 'item does not exist in the database'}, status=401)
    
    
@csrf_exempt  
def show_item(request):
    
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a GET request'}, status=403)
    try:
        product_id = request.POST.get('id')
    except:
        return JsonResponse({'status': 'unable to fetch the item id'}, status=500)
        
    product = companyInventory.objects.filter(pk=product_id)
        
    if product:
        return JsonResponse({'status': 'success', 'product':list(product.values())}, status=201)
    else: 
        return JsonResponse({'status': 'unable to show the item'}, status=401)
        

@csrf_exempt
def search_item(request):

    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a GET request'}, status=403)


    try:
        product_name = request.POST.get('product_name')
    except:
        return JsonResponse({'status': 'unable to fetch the item id'}, status=500)
    
    products = companyInventory.objects.filter(product_name__icontains = product_name)


    product_dicts = list(products.values())  # A list of dictionaries, each index is an product item
    # print(company_dict)

    if len(product_dicts) == 0:
        return JsonResponse({'status': 'No such items in the inventory'}, status=404)

    items = []

    for product_dict in product_dicts:
        items.append(list(product_dict.values()))
    

    return JsonResponse({
            'status': 'success',
            'items': items
        }, 
        status=201)

@csrf_exempt
def search_item_by_type(request):

    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a GET request'}, status=403)


    try:
        product_type = request.POST.get('product_type')
    except:
        return JsonResponse({'status': 'unable to fetch the item id'}, status=500)
    
    products = companyInventory.objects.filter(product_type__icontains = product_type)


    product_dicts = list(products.values())  # A list of dictionaries, each index is an product item
    # print(company_dict)

    if len(product_dicts) == 0:
        return JsonResponse({'status': 'No such items in the inventory'}, status=404)

    items = []

    for product_dict in product_dicts:
        items.append(list(product_dict.values()))
    

    return JsonResponse({
            'status': 'success',
            'items': items
        }, 
        status=201)


        
        
        
        