from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators import csrf
from .models import company
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate

# Create your views here.
@csrf_exempt
def company_log_in(request):
    if request.method != 'POST':
        return JsonResponse({'status': 'did not recieve a POST request'}, status=403)
    username = request.POST.get('username')
    password = request.POST.get('password')
    
    if company.objects.filter(username=username,password=password):    
        return JsonResponse({'status': 'success'}, status=200)
    else: 
        return JsonResponse({'status': 'username/password incorrect'}, status=400)