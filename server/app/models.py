from flask_sqlalchemy import SQLAlchemy
from app import db

class GRE(db.Model):
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    Word = db.Column(db.String(20), nullable = False)
    Meaning = db.Column(db.String(120), nullable = False)

    def __init__(self, word, meaning):
        self.Word = word
        self.Meaning = meaning

    def getQuestion():
        rand = random.randrange(0, db.session.query(GRE).count())
        questionAnswer = db.session.query(GRE)[rand]
        db.session.close()
        return questionAnswer
