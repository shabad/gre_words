import unittest
from app import app
from app import main
from app import db
from app.main import getQuestion, generateUniqueRoomCode, isUniqueNickName, isRoomEmpty, getLeaderboard
from app.models import GRE
from sqlalchemy import *

class getQuestionTest(unittest.TestCase):
    def test(self):
        row = getQuestion()
        exists = db.session.query(GRE.id).filter_by(Word = row['question']).filter_by(Meaning = row['answer']).scalar() is not None
        self.assertEqual(True, exists)

class generateRoomCodeTest(unittest.TestCase):
    def test(self):
        codes = ["horse"]
        used = []
        self.assertEqual(generateUniqueRoomCode(codes, used), "horse")

    def test2(self):
        codes = ["cat", "horse"]
        used = ["horse", "cat"]
        self.assertFalse(generateUniqueRoomCode(codes, used) in used)


class isUniqueNickNameTest(unittest.TestCase):
    def test(self):
        nickname = "Shabad"
        nicknames_used = ["Shabad", "Saad", "Ayush", "Shlok"]
        self.assertEqual(False, isUniqueNickName(nickname, nicknames_used))


class isRoomEmptyTest(unittest.TestCase):
    def test(self):
        room = {}
        self.assertEqual(True, isRoomEmpty(room))

    def test1(self):
        room = {"Shabad": 0}
        self.assertEqual(False, isRoomEmpty(room))


class getLeaderboardTest(unittest.TestCase):
    def test(self):
        players = {"Shabad": 0, "Shlok": 1}
        self.assertEqual([('Shlok', 1), ('Shabad', 0)], getLeaderboard(players))
