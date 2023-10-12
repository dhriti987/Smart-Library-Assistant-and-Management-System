from django.shortcuts import render
from django.http import JsonResponse

from server.settings import AUTH_USER_MODEL
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
from .serializers import *
from .models import *
from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import get_user_model
from django.contrib.postgres.search import SearchVector, SearchQuery, SearchRank

# rdz123


@api_view(['GET'])
def getBook(request):
    books = Book.objects.all()
    serializer = BookSerializer(books,many=True)
    return Response(serializer.data)
#paginatuion 20 books per page

class TopRatedBookAPIView(generics.ListCreateAPIView):
    serializer_class = BookSerializer
    permission_classes = []
    def get_queryset(self):
        queryset = Book.objects.all()
        top_rated = self.request.query_params.get('top_rated')
        # Check if the 'top_rated' parameter is provided
        if top_rated == 'true':
            queryset = queryset.order_by('-number_of_ratings')[:5]

        return queryset
    
class RecommendationAPIView(generics.ListCreateAPIView):
    serializer_class = BookSerializer
    permission_classes = []
    def get_queryset(self):
        queryset = Book.objects.order_by('?')
        return queryset
    

class GenreBooksAPIView(generics.ListAPIView):
    serializer_class = BookSerializer
   
    permission_classes = []
    def get_queryset(self):
        category = self.kwargs['category']
        top_rated = self.request.query_params.get('top_rated')
        queryset = Book.objects.filter(category__category=category)
        if top_rated == 'true':
            queryset = queryset.order_by('-number_of_ratings')[:10]
        return queryset
    
class MostLikedBooks(generics.ListAPIView): #The books liked by user request.usser
    serializer_class = BookSerializer
    permission_classes = []
    
    def get_queryset(self):
        user_id = self.kwargs['user_id']  # Assuming 'user_id' is passed as a URL parameter
        User = get_user_model() 
        user = User.objects.get(id=user_id) 
        # Retrieve the books liked by the user
        liked_books = Like.objects.filter(user=user).values_list('book', flat=True)
      
        return Book.objects.filter(id__in=liked_books)
    


class BooksReadByUser(generics.ListAPIView):
    serializer_class = BookSerializer
    permission_classes = []
    
    def get_queryset(self):
        user_id = self.kwargs['user_id']  # Assuming 'user_id' is passed as a URL parameter
        User = get_user_model() 
        user = User.objects.get(id=user_id) 
        books_read = BookRead.objects.filter(user=user).values_list('books', flat=True)

        
        return Book.objects.filter(id__in=books_read)

class MostRecentBooks(generics.ListAPIView):
    permission_classes = []
    serializer_class = BookSerializer
    def get_queryset(self):
        queryset = Book.objects.order_by('-created_at')[:10]
        return queryset
    
class AllGenreBooks(generics.ListAPIView):
    permission_classes =[]
    def get_queryset(self):
        
        queryset = Category.objects.values_list('category', flat=True).distinct()
        categories = list(queryset)

        # Return the list of categories in the response
        return queryset

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()

        
        return Response(queryset, status=status.HTTP_200_OK)
    
    
    
class SearchBooks(generics.ListAPIView):
    # Fuzzy in Full Text , where if a spelling is wrong , it will still display
    permission_classes = []
    serializer_class  = BookSerializer
    def get_queryset(self):
        query = self.request.GET.get("q")
        return Book.objects.filter(title__search=query)


    """search_vector = SearchVector("title")
        search_query = SearchQuery(query)
        return (
                Book.objects.annotate(
                    search=search_vector, rank=SearchRank(search_vector, search_query)
                )
                .filter(search=search_query)
                .order_by("-rank")
            )"""
    
class AllAuthorList(generics.ListAPIView):
    permission_classes = []
    serializer_class = AuthorSerializer
    def get_queryset(self):
        queryset = Author.objects.all()
        return queryset
    
class AuthorBook(generics.ListAPIView):
    permission_classes = []
    serializer_class = BookSerializer
    def get_queryset(self):
        author_name = self.kwargs['author'] #First get the author from URL
        author = Author.objects.get(name = author_name) # Get the record of the author from author_name
        queryset = author.books.all() # By using related_name(books), get the record of all books of the author 
        return queryset