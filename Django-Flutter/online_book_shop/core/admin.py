from django.contrib import admin
from .models import *
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
# Register your models here. 6th 01:32

@admin.register(User)
class UserAdmin1(BaseUserAdmin):
    add_fieldsets=(
        (None, {
        'classes':('wide',),
        'fields':('username','email','password1','password2')}))