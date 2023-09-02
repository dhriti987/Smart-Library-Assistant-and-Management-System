from django.contrib import admin
from .models import *
# Register your models here.

admin.site.register(Book)
admin.site.register(Like)
admin.site.register(Borrow)
admin.site.register(Review)
admin.site.register(Category)
admin.site.register(Author)
admin.site.register(BookRead)