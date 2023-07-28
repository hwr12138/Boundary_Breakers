# Create your views here.
from django.shortcuts import render
from django.http import JsonResponse
from .models import userCart
from companyInventory.models import companyInventory
from django.views.decorators import csrf
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def user_cart_modify_item(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)

    username=request.POST.get('username')
    company_username = request.POST.get('company_username')
    product_name = request.POST.get('product_name')
    quantity=request.POST.get('quantity')

    if username is None:
        return JsonResponse({'status': 'no user name was given'}, status=400)

    if company_username is None:
        return JsonResponse({'status': 'no company name was given'}, status=400)

    if product_name is None:
        return JsonResponse({'status': 'no product name was given'}, status=400)

    if quantity is None:
        return JsonResponse({'status': 'no quantity was given'}, status=400)

    if not userCart.objects.filter(username=username,company_username=company_username,product_name=product_name):
        #make item if it does not exist
        new_item = userCart(username=username,company_username=company_username,product_name=product_name,quantity=quantity)
        new_item.save()
        return JsonResponse({'status': 'success, item created'}, status=200)

    a=userCart.objects.get(username=username,company_username=company_username,product_name=product_name)
    if(int(quantity)<0):
        a.delete()
        return JsonResponse({'status': 'success, item deleted'}, status=200)
    a.username=username
    a.company_username=company_username
    a.product_name=product_name
    a.quantity=quantity
    a.save()
    return JsonResponse({'status': 'success, item updated'}, status=200)

@csrf_exempt
def user_cart_query_item(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)

    username=request.POST.get('username')
    company_username = request.POST.get('company_username')

    if username is None:
        return JsonResponse({'status': 'no user name was given'}, status=400)

    if company_username is None:
        #no company then check for all
        q = userCart.objects.filter(username=username)
    else:
        #want cart for specific company
        q = userCart.objects.filter(username=username,company_username=company_username)
        
    cart_dicts = list(q.values())

    if len(cart_dicts) == 0:
        return JsonResponse({'status': 'Nothing for user'}, status=404)

    items = []
    for item in cart_dicts:
        items.append(list(item.values()))

    return JsonResponse({
            'status': 'success',
            'items': items
        }, 
        status=201)