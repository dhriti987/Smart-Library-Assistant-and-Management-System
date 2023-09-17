from django.db import models
from django.conf import settings

from server.settings import AUTH_USER_MODEL
# Create your models here.
"""from django.contrib.auth import get_user_model

User = get_user_model()
"""
#
class Author(models.Model):
    name = models.CharField(max_length=100)  
    bio = models.TextField(max_length=1000,blank=True)
    date_of_birth = models.DateField(blank=True)
    wiki_link = models.URLField(blank=True)
    img_url = models.URLField(blank=True)
    
    def __str__(self) -> str:
        return self.name
    
class Category(models.Model):
    category = models.CharField(max_length=200)

    def __str__(self) -> str:
        return self.category

class Book(models.Model):
    title = models.CharField(max_length=255)
    isbn = models.CharField(max_length=17)
    description = models.TextField()
    number_of_ratings = models.IntegerField()
    category  = models.ManyToManyField(Category, related_name="books")
    author = models.ManyToManyField(Author,related_name="books")
    publisher = models.CharField(max_length = 200)
    year = models.CharField(max_length=4) 
    copies = models.IntegerField()
    location = models.CharField(max_length=20)
    img_url = models.URLField()  # images stored in aws s3
    file = models.FileField(null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    

    def __str__(self):
        return self.title
  

class Review(models.Model):
    comment  = models.CharField(max_length=250)
    date = models.DateField(auto_now_add = True)
    rating = models.IntegerField()
    book = models.ForeignKey(Book,on_delete=models.CASCADE,related_name="reviews")
    user = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)
    #user = models.ForeignKey(User,on_delete=models.CASCADE)

class BookRead(models.Model):
    books= models.ManyToManyField(Book) 
    
    user = models.OneToOneField(settings.AUTH_USER_MODEL,related_name="books_readed", on_delete= models.CASCADE) #one to one books_readed
    #users = models.ForeignKey(User,on_delete=models.CASCADE)
    date = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        books_titles = ", ".join([book.title for book in self.books.all()])
        return f"{self.user} has read {books_titles}"
    
class Like(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,related_name="liked_books")
    #user = models.ForeignKey(User,on_delete=models.CASCADE)
    book = models.ForeignKey(Book,on_delete=models.CASCADE,related_name="likes")
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user} likes {self.book}"

class Borrow(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE,related_name="borrowed")
    #user = models.ForeignKey(User,on_delete=models.CASCADE)
    book = models.ForeignKey(Book,on_delete=models.CASCADE,related_name="borrowed")
    borrow_date = models.DateField(auto_now_add=True)
    due_date = models.DateField()
    return_date = models.DateField(null=True) 

    def __str__(self):
        return f"{self.user} borrowed {self.book}"

   