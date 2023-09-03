from django.urls import path
from rest_framework.authtoken import views

from .views import *

urlpatterns = [
    path('token/',CustomAuthToken.as_view()),
    path('verify-email/',EmailValidation.as_view()),
    path('verify-new_password/',NewPasswordValidation.as_view()), #If otp is correct then save the pwd
    
]
