import unittest
from app import app
from app import main
from app import db
from app.main import getQuestion, generateUniqueRoomCode, isUniqueNickName, isRoomEmpty, getLeaderboard
from app.models import GRE
from sqlalchemy import *

class getQuestionTest(unittest.TestCase):
    def test1(self):
        row = getQuestion()
        exists = db.session.query(GRE.id).filter_by(Word = row['question']).filter_by(Meaning = row['answer']).scalar() is not None
        self.assertEqual(True, exists)

    def test2(self):
        row = {'question': "byzantine", 'answer': "easy"}
        exists = db.session.query(GRE.id).filter_by(Word = row['question']).filter_by(Meaning = row['answer']).scalar() is not None
        if not exists:
            exists = -1
        self.assertEqual(-1, exists)

    def test3(self):
        row = {'question': "doesnt_exist", 'answer': "easy"}
        exists = db.session.query(GRE.id).filter_by(Word = row['question']).filter_by(Meaning = row['answer']).scalar() is not None
        if not exists:
            exists = -1
        self.assertEqual(-1, exists)


class generateRoomCodeTest(unittest.TestCase):
    def test1(self):
        codes = ["horse"]
        used = []
        self.assertEqual(generateUniqueRoomCode(codes, used), "horse")

    def test2(self):
        codes = ["cat", "horse"]
        used = ["horse", "cat"]
        self.assertEqual(generateUniqueRoomCode(codes, used), -1)

    def test3(self):
        codes = ["cat", "horse"]
        used = ["horse"]
        self.assertEqual(generateUniqueRoomCode(codes, used), "cat")


class isUniqueNickNameTest(unittest.TestCase):
    def test1(self):
        nickname = "Shabad"
        nicknames_used = ["Saad"]
        self.assertEqual(True, isUniqueNickName(nickname, nicknames_used))

    def test2(self):
        nickname = "Shabad"
        nicknames_used = ["Shabad"]
        self.assertEqual(False, isUniqueNickName(nickname, nicknames_used))

    def test3(self):
        nickname = ""
        nicknames_used = []
        self.assertEqual(-1, isUniqueNickName(nickname, nicknames_used))


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


if __name__ == '__main__':
    unittest.main()
