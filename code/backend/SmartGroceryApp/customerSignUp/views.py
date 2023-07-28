from django.shortcuts import render
from django.http import JsonResponse
from .models import customer
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
@csrf_exempt
def customer_sign_up(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)

    username = request.POST.get('username')
    password =request.POST.get('password')
    email = request.POST.get('email')
    firstname = request.POST.get('firstname')
    lastname = request.POST.get('lastname')

    if username is None:
        return JsonResponse({'status': 'no username was given'}, status=400)

    if password is None:
        return JsonResponse({'status': 'no password was given'}, status=400)

    if email is None:
        return JsonResponse({'status': 'no email was given'}, status=400)

    if firstname is None:
        return JsonResponse({'status': 'no firstname was given'}, status=400)

    if lastname is None:
        return JsonResponse({'status': 'no lastname was given'}, status=400)

    if customer.objects.filter(username=username):
        return JsonResponse({'status': 'username already exists'}, status=400)

    new_customer = customer(username=username, password=password, email=email, firstname=firstname, lastname=lastname)
    new_customer.save()

    return JsonResponse({'status': 'success'}, status=201)
