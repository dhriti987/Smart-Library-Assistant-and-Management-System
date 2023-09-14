from .models import User

from rest_framework import serializers

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        max_length=50,min_length=8,write_only=True
    )

    class Meta:
        model = User
        fields = ['id','user_name','email','password']

    def validate(self,attrs):
        email = attrs.get('email',None)
        print("Se emaj",email)
        if email is None:
            raise serializers.ValidationError(
                'User Should Have email address'
            )
        
        return attrs
    
class EmailValidationSerializer(serializers.Serializer):
    email = serializers.EmailField()
