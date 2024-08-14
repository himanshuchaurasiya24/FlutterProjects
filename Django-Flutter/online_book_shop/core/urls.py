from django.contrib import admin
from django.urls import path
from django.http.response import HttpResponse
from .views import *
urlpatterns = [
    path('a', aPage),
]
