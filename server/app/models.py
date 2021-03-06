from flask_sqlalchemy import SQLAlchemy
from app import db

class GRE(db.Model):
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    Word = db.Column(db.String(20), nullable = False)
    Meaning = db.Column(db.String(120), nullable = False)

    def __init__(self, word, meaning):
        self.Word = word
        self.Meaning = meaning



class Users(db.Model):
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    Username = db.Column(db.String(20), primary_key = True)
    Name = db.Column(db.String(10), nullable = False)
    Email = db.Column(db.String(30), nullable = False)
    Password = db.Column(db.String(25), nullable = False)
    Avatar = db.Column(db.String(130), nullable = True)

    def __init__(self, username, name, email):
        self.Username = username
        self.Name = name
        self.Email = email

    def displayName(self):
        return '{}'.format(self.Username)
