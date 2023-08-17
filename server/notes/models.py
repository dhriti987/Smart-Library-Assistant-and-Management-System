from django.db import models
from django.contrib.auth.models import User
# Create your models here.
"""class Notes(models.Model):
    title = models.CharField(max_length=200)
    content = models.CharField(max_length=500)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    date_created = models.DateField(auto_now_add=True)
    date_updated = models.DateField(auto_now=True)
    page_number  = models.PositiveBigIntegerField()
    
    def __str__(self):
        return f"Note {self.id} by {self.user.username}"
"""