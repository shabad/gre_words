from __main__ import app
from flask_sqlalchemy import SQLAlchemy
import pandas as pd


db = SQLAlchemy(app)


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


# def generateQuestion():
#     answer = random(GRE(word, meaning))
#     for row in xls['WORD']:
#         b = random(xls['WORD'])
#         c = random(xls['WORD'])
#         d = random(xls['WORD'])
#     return (answer, b, c, d)
