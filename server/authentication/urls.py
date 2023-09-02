from django.urls import path
from rest_framework.authtoken import views

from .views import *

urlpatterns = [
    path('token/',CustomAuthToken.as_view()),

]
