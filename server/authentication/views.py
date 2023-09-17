from django.conf import settings
from django.shortcuts import render
import random
from django.core.mail import send_mail
from datetime import timedelta
from django.utils import timezone
from django.contrib.auth import authenticate

# Create your views here. "rajvi12345# rajvi12345#"
from django.contrib.auth.password_validation import validate_password
from rest_framework import status

from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import *
import threading
class CustomAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
           
            'token': token.key,
            'user_id': user.pk,
            'email': user.email,
            'username': user.user_name
        })
    
class HandleSendigMail(threading.Thread):
    def __init__(self,message,subject,email_from,recipitent_list):
        self.message = message
        self.subject = subject
        self.email_from = email_from
        self.recipitent_list = recipitent_list
        threading.Thread.__init__(self)

    def run(self):
        send_mail(self.subject,self.message,self.email_from,self.recipitent_list)  


class EmailValidation(APIView):
    permission_classes  = []
    def post(self,request):
        email = request.data.get('email')
        serializer = EmailValidationSerializer(data=request.data)
        print("Data;",serializer)
        if serializer.is_valid():
            print("iNSIDE if")
            email = serializer.validated_data['email']
            user = User.objects.filter(email=email)
            if not user.exists():
                return Response({'status': 400,
                                'message': "No User with this Email",
                                })
            
            else:
                
                subject = "OTP For setting New Password"
                otp = random.randint(1000,9999)
                message = f"Your otp is {otp}"
                # request.session['otp'] = {'otp': otp}
                request.session[email] = {'otp': otp} #saving otp seperately for each diff email
                email_from = settings.EMAIL_HOST
                # send_mail(subject,message,email_from,[email])
                HandleSendigMail(message,subject,email_from,[email]).start()
                return Response({'status':200,'message':f"OTP Sent to the email {email}"})
        else:
            print("Inside ELse")
            if 'email' in serializer.errors:
                error_message = serializer.errors['email'][0]  # Get the first error message
                return Response({'status': status.HTTP_400_BAD_REQUEST,
                                 'message': error_message},
                                status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'status': status.HTTP_400_BAD_REQUEST,
                                 'message': "Invalid Email"},
                                status=status.HTTP_400_BAD_REQUEST)

        

class NewPasswordValidation(APIView):
    permission_classes  = []
    def post(self,request):
        otp = request.data.get('otp')
        new_password = request.data.get('new_password')
        email  = request.data.get('email')
        try:
            session_data = request.session.get(email)
            old_otp = session_data['otp']
        except Exception as e:
            return Response({'status': 400, 'message': "OTP has expired! Request new OTP"})

        user = User.objects.get(email=email)
        if str(otp) != str(old_otp):
            return Response({'status': 400, 'message': "Invalid OTP!"})
        try:
            validate_password(new_password, user=user)  
        except Exception as e:
             return Response({'status': 400, 'message': str(e)})
    
        user.set_password(new_password)
        user.save()
        # Clear OTP from session
        del request.session[email]

        return Response({'status': 200, 'message': "Password updated successfully"})
       
        
