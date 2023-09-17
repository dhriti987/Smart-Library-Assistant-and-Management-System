from rest_framework import serializers
from .models import *


class CategorySerializer(serializers.ModelSerializer):
    category = serializers.CharField()
    class Meta:
        model = Category
        fields = "__all__"



class AuthorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Author
        fields = '__all__'



class BookSerializer(serializers.ModelSerializer):
    category = serializers.SerializerMethodField('get_category')
    def get_category(self,obj):
       
        data = [cat.category for cat in obj.category.all()]
        return data
    author = serializers.SerializerMethodField('get_author')
    def get_author(self,obj):
        return [author.name for author in obj.author.all()]
    class Meta:
        model = Book
        fields = '__all__'
    
class ReviewSerializer(serializers.ModelSerializer):
    book = BookSerializer(many=True)
    # user = AuthorSerializer(many=True)
    class Meta:
        model = Review
        fields = '__all__'

class BookReadSerializer(serializers.ModelSerializer):
    book = BookSerializer(many=True)
    class Meta:
        model = BookRead
        fields = '__all__'


class BorrowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Borrow
        fields = '__all__'

