
from flask import Flask, jsonify
from flask_socketio import SocketIO, send, emit, join_room, leave_room
from flask_sqlalchemy import SQLAlchemy


import json



app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Shabad@97@localhost/saad'
from models import db


app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, logger=True, engineio_logger=True,  async_mode="eventlet")
from events import *

@socketio.on('testingbaby')
def test_message(message):
    print("yolo")
    emit('my response', {'data': message['data']})


db.create_all()


if __name__ == '__main__':
    socketio.run(app)
