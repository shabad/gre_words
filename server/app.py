from flask import Flask
from flask_socketio import SocketIO, send, emit, join_room, leave_room
import random



app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)
words = ['battery', 'correct', 'horse', 'staple', 'cart', 'dart', 'mart', 'patty', 'lefty', 'golf', 'mall', 'post', 'dote', 'mote', 'fole', 'doge', 'luck', 'gold']
rooms = []

room_members = {}


@socketio.on('connect')
def on_connect():
    print("Connectd")




@socketio.on('connectHostUser')
def on_connect_host(nickname):
    name = nickname
    room = generateRoomCode()
    join_room(room)
    room_members[room] = []
    room_members[room].append(name)
    print(room_members)
    print(nickname + " has joined")
    emit("roomcode", room)
    emit("room_members_new", room_members[room], room = room)



def generateRoomCode():
    secure_random = random.SystemRandom()

    return (secure_random.choice(words))


@socketio.on('connectPlayerUser')
def on_connect_player(data):
    name = data['nickname']
    roomCode = data['roomCode']
    join_room(roomCode)
    room_members[roomCode].append(name)
    print(room_members)
    print(name + " has joined")
    emit("room_members_new", room_members[roomCode], room = roomCode)


@socketio.on('launchGame')
def on_launch(roomCode):
    print(roomCode + " is launching now")
    # send game start to everyone connected, take them to new screen


    # send(username + ' has entered the room.', room=room)

@socketio.on('leave')
def on_leave(data):
    name = data['name']
    room = data['room']
    leave_room(room)
    send(username + ' has left the room.', room=room)


if __name__ == '__main__':
    socketio.run(app)
