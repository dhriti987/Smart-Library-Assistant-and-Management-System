from . views import *
from django.urls import path

urlpatterns = [
    path('', index),
    path('getBooks/',getBook),
    path('best-books/',TopRatedBookAPIView.as_view()),
   
    path('recommendations/', RecommendationAPIView.as_view(), name='recommendation'),
    path('genre/<str:category>/', GenreBooksAPIView.as_view()),

]