from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators import csrf
from .models import customer
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate

# Create your views here.


@csrf_exempt
def customer_get_profile(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not receive a POST request'}, status=403)

    customer_username = request.POST.get('customer_username')

    if customer_username is None:
        return JsonResponse({'status': 'no customer username was given'}, status=400)

    customer_profile = customer.objects.filter(username=customer_username)

    return JsonResponse({'status': 'success', 'profile': customer_profile.values('username', 'email', 'firstname', 'lastname').get()}, status=200)


@csrf_exempt
def customer_profile(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)
    oldusername = request.POST.get('username')
    if customer.objects.filter(username=oldusername):
        # username and password is verified so changes can be made now
        c = customer.objects.get(username=oldusername)
        newusername = request.POST.get('newusername')
        newpassword = request.POST.get('newpassword')
        email = request.POST.get('email')
        firstname = request.POST.get('firstname')
        lastname = request.POST.get('lastname')

        if newusername is None:
            return JsonResponse({'status': 'no username was given'}, status=400)

        if email is None:
            return JsonResponse({'status': 'no email was given'}, status=400)

        if firstname is None:
            return JsonResponse({'status': 'no firstname was given'}, status=400)

        if lastname is None:
            return JsonResponse({'status': 'no lastname was given'}, status=400)

        new_username = customer.objects.filter(username=newusername)

        if new_username and new_username.values('username').get()['username'] != oldusername:
            return JsonResponse({'status': 'new username already exists'}, status=400)

        c.username = newusername

        if not newpassword is None:
            c.password = newpassword

        c.email = email
        c.firstname = firstname
        c.lastname = lastname
        c.save()
        return JsonResponse({'status': 'success'}, status=200)
    else:
        return JsonResponse({'status': 'username/password incorrect'}, status=400)
