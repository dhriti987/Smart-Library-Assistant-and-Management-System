from django.db import models

# Create your models here.
class Book(models.Model):
    title = models.CharField(max_length=100)
    isbn = models.CharField(max_length=17)
    author = models.CharField(max_length = 100)
    year = models.IntegerField()
    publisher = models.CharField(max_length = 200)
    img_url = models.URLField()  # images stored in aws s3
    number_of_rating = models.IntegerField()


    def __str__(self):
        return self.title