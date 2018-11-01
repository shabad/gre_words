from flask import Flask
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy

import pandas as pd

socketio = SocketIO()



app = Flask(__name__)
app.config['SECRET_KEY'] = 'gjr39dkjn344_!67#'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Shabad@97@localhost/saad'
db = SQLAlchemy(app)

from app import models




from .main import main as main_blueprint
app.register_blueprint(main_blueprint)
db.create_all()

from app.models import GRE

xls = pd.read_excel("wordlist.xls")


if db.session.query(GRE).count() == 0:
    for a, b in zip(xls['WORD'], xls['DEFINITION']):
        info = GRE(a, b)
        db.session.add(info)
        db.session.commit()




socketio.init_app(app)
