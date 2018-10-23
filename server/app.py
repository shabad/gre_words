from flask import Flask
from flask_socketio import SocketIO, send, emit, join_room, leave_room
import random


app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)
words = ['battery', 'correct', 'horse', 'staple']
rooms = []


@socketio.on('connect')
def on_connect():
    print("Connectd")




@socketio.on('connectHostUser')
def on_connect_host(nickname):
    name = nickname
    # room = data['room']
    room = generateRoomCode()
    join_room(room)
    print(nickname + " has joined")
    emit("roomcode", room)

def generateRoomCode():
    secure_random = random.SystemRandom()
    return (secure_random.choice(words))



    # send(username + ' has entered the room.', room=room)

@socketio.on('leave')
def on_leave(data):
    name = data['name']
    room = data['room']
    leave_room(room)
    send(username + ' has left the room.', room=room)


if __name__ == '__main__':
    socketio.run(app)
