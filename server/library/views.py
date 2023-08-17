from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
from .serializers import *
from .models import *

# rdz123

@api_view(['GET'])
def index(request):
    return Response(data={'msg':"Hello Wolrd"},status=status.HTTP_200_OK)

@api_view(['GET'])
def getBook(request):
    books = Book.objects.all()
    serializer = BookSerializer(books,many=True)
    return Response(serializer.data)
