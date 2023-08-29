from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
from .serializers import *
from .models import *
from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

# rdz123

@api_view(['GET'])
def index(request):
    return Response(data={'msg':"Hello Wolrd"},status=status.HTTP_200_OK)

@api_view(['GET'])
def getBook(request):
    books = Book.objects.all()
    serializer = BookSerializer(books,many=True)
    return Response(serializer.data)


class TopRatedBookAPIView(generics.ListCreateAPIView):
    queryset = Book.objects.order_by('-number_of_ratings')[:5]
    serializer_class = BookSerializer
    permission_classes = []

    def list(self, request):
        # Note the use of `get_queryset()` instead of `self.queryset`
        queryset = self.get_queryset()
        serializer = BookSerializer(queryset, many=True)
        return Response(serializer.data)

class RecommendationAPIView(generics.ListCreateAPIView):
  
   #recommended_books = get_recommendations_from_ml_model(book_id)
    queryset =  Book.objects.all()# Serialize the recommended books
    serializer_class = BookSerializer
    authentication_classes = [] 
    permission_classes = []  
    def list(self, request):
        queryset = self.get_queryset()
        serializer = BookSerializer(queryset, many=True)
        return Response(serializer.data)

class GenreBooksAPIView(generics.ListAPIView):
    serializer_class = BookSerializer
    permission_classes = []
    def get_queryset(self):
        category = self.kwargs['category']
        print("Before:",category)  # Get the genre from URL parameters
        queryset = Book.objects.filter(category__category=category)
        
        return queryset