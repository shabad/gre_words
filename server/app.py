from flask import Flask
from flask_socketio import SocketIO, send, emit, join_room, leave_room
from flask_sqlalchemy import SQLAlchemy
import random



app = Flask(__name__)
from models import db
########## Remember to change this ###############
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Shabad@97@localhost/saad'
# db = SQLAlchemy(app)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)
words = ['battery', 'correct', 'horse', 'staple', 'cart', 'dart', 'mart', 'patty', 'lefty', 'golf', 'mall', 'post', 'dote', 'mote', 'fole', 'doge', 'luck', 'gold']
rooms = []

room_members = {}
# room_members = {'bateerty': {'Shabad': 0, 'Saad': 0, 'Roman': 0}, ..........}

@socketio.on('connect')
def on_connect():
    print("Connectd")




@socketio.on('connectHostUser')
def on_connect_host(nickname):
    name = nickname
    room = generateRoomCode()
    join_room(room)
    room_members[room] = {}
    # room_members[room].append(name)
    room_members[room][name] = 0
    print(room_members)
    print(nickname + " has joined")
    emit("roomcode", room)

    emit("room_members_new", list(room_members[room].keys()), room = room)



def generateRoomCode():
    secure_random = random.SystemRandom()

    return (secure_random.choice(words))


@socketio.on('connectPlayerUser')
def on_connect_player(data):
    name = data['nickname']
    roomCode = data['roomCode']
    join_room(roomCode)
    room_members[roomCode][name] = 0
    print(room_members)
    print(name + " has joined")
    emit("room_members_new", list(room_members[roomCode].keys()), room = roomCode)


@socketio.on('launchGame')
def on_launch(roomCode):
    print(roomCode + " is launching now")
    emit("gameStart", room = roomCode)



@socketio.on('getQuestion')
def on_get_question(data):
    roomCode = data['roomCode']
    question_num = data['question_number']

    emit("gameQuestion", "What is the meaning of Life?", room = roomCode)





@socketio.on('leave')
def on_leave(data):
    name = data['name']
    room = data['room']
    leave_room(room)
    send(username + ' has left the room.', room=room)



db.create_all()


if __name__ == '__main__':
    socketio.run(app)
