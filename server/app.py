
from flask import Flask, jsonify
from flask_socketio import SocketIO, send, emit, join_room, leave_room
from flask_sqlalchemy import SQLAlchemy
import json
import pandas as pd

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Shabad@97@localhost/saad'
from models import db
from models import GRE, Users

app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, logger=True, engineio_logger=True,  async_mode="eventlet")
from events import *


@socketio.on('testingbaby')
def test_message(message):
    print("yolo")
    emit('my response', {'data': message['data']})

db.create_all()

xls = pd.read_excel("wordlist.xls")


if db.session.query(GRE).count() == 0:
    for a, b in zip(xls['WORD'], xls['DEFINITION']):
        info = GRE(a, b)
        db.session.add(info)
        db.session.commit()

if __name__ == '__main__':
    socketio.run(app)
