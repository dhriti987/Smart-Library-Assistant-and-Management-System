from . views import *
from django.urls import path

urlpatterns = [
    path('', getBook),
    path('getBooks/',getBook),
    path('getAuthors/',AllAuthorList.as_view()),
    path('searchBooks/',SearchBooks.as_view()),
    path('best-books/',TopRatedBookAPIView.as_view()),
    path('recent-books/',MostRecentBooks.as_view()),
    path('liked-books/<user_id>',MostLikedBooks.as_view()),
    path('books-read/<user_id>',BooksReadByUser.as_view()),
    path('all-categories/',AllGenreBooks.as_view()),
    path('recommendations/', RecommendationAPIView.as_view(), name='recommendation'),
    path('genre/<str:category>/', GenreBooksAPIView.as_view()),
    path('author-books/<str:author>/',AuthorBook.as_view()),
]