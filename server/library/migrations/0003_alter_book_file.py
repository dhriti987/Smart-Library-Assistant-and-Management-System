# Generated by Django 3.2.20 on 2023-09-09 16:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('library', '0002_alter_book_title'),
    ]

    operations = [
        migrations.AlterField(
            model_name='book',
            name='file',
            field=models.FileField(null=True, upload_to=''),
        ),
    ]