from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
@csrf_exempt
def aPage(request):
    user:User = User.objects.get(pk=1)
    username =request.POST.get('username')
    email =request.POST.get('email')
    password =request.POST.get('password')
    print(username)
    print(email)
    print(password)
    # return JsonResponse({'name':'himanshu chaurasiya', 'address':'ghazipur'})
    return JsonResponse({'username':user.username, 'password':user.password,'email':user.email})
