# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2018-11-23 15:23
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('book', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='option',
            name='riddle',
        ),
        migrations.RenameField(
            model_name='riddle',
            old_name='riddle_text',
            new_name='Email',
        ),
        migrations.RemoveField(
            model_name='riddle',
            name='pub_date',
        ),
        migrations.AddField(
            model_name='riddle',
            name='FIO',
            field=models.CharField(default=1, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='riddle',
            name='adres',
            field=models.CharField(default=1, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='riddle',
            name='job',
            field=models.CharField(default=1, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='riddle',
            name='phone',
            field=models.CharField(default=1, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='riddle',
            name='sex',
            field=models.CharField(default=1, max_length=255),
            preserve_default=False,
        ),
        migrations.DeleteModel(
            name='Option',
        ),
    ]
