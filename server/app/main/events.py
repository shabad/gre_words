import random
from flask_socketio import SocketIO, send, emit, join_room, leave_room
from flask_sqlalchemy import SQLAlchemy
from .. import socketio
from app.models import GRE
from app import db
import random




words = ['battery', 'correct', 'horse', 'staple', 'cart', 'dart', 'mart', 'patty', 'lefty', 'golf', 'mall', 'post', 'dote', 'mote', 'fole', 'doge', 'luck', 'gold']
rooms = []

room_members = {}
# room_members = {'bateerty': {'Shabad': 0, 'Saad': 0, 'Roman': 0}, ..........}

room_answers = {}


def generateUniqueRoomCode(roomCodes, usedOnes):
    if(len(roomCodes) == len(usedOnes)):
        return -1
    secure_random = random.SystemRandom()
    code = (secure_random.choice(roomCodes))
    while code in usedOnes:
        secure_random = random.SystemRandom()
        code = (secure_random.choice(roomCodes))
    return code



def getQuestion():
    rand = random.randrange(0, db.session.query(GRE).count())
    question = db.session.query(GRE)[rand]
    # Flipped ans and question
    return {'question': question.Meaning, 'answer': question.Word}


@socketio.on('connect')
def on_connect():
    print("Connectedd bitchs")


@socketio.on('connectHostUser')
def on_connect_host(nickname):
    print("Host has been connected")
    name = nickname
    room = generateUniqueRoomCode(words, room_members.keys())
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

    obj = getQuestion()
    room_answers[roomCode] = {}
    room_answers[roomCode][question_num] = []

    emit("gameQuestion", obj, room = roomCode)




@socketio.on('correct_answer')
def on_correct_answer(data):
    roomCode = data['roomCode']
    question_num = data['question_number']
    playerName = data['name']
    room_answers[roomCode][question_num].append(playerName)
    room_members[roomCode][playerName] = room_members[roomCode][playerName] + 1

    if len(room_answers[roomCode][question_num]) == len(list(room_members[roomCode].keys())):
        print("Everyone has now answered")
        print(room_members[roomCode])
        emit("scoreScreen", {'question_num': question_num, 'roomCode': roomCode}, room = roomCode)
        print("SENDING SEGUE NOW")
        emit("gameScores", room_members[roomCode], room = roomCode)


@socketio.on('wrong_answer')
def on_wrong_answer(data):
    roomCode = data['roomCode']
    question_num = data['question_number']
    playerName = data['name']
    room_answers[roomCode][question_num].append(playerName)


    if len(room_answers[roomCode][question_num]) == len(list(room_members[roomCode].keys())):
        print("Everyone has now answered")
        print(room_members[roomCode])
        emit("scoreScreen", {'question_num': question_num, 'roomCode': roomCode}, room = roomCode)
        print("SENDING SEGUE NOW")
        emit("gameScores", room_members[roomCode], room = roomCode)


@socketio.on('getNextQuestion')
def on_next_question(roomCode):
    emit("nextQuestion", room = roomCode)


@socketio.on('leave')
def on_leave(data):
    name = data['name']
    room = data['room']
    leave_room(room)
    send(username + ' has left the room.', room=room)
