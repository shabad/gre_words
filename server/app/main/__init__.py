from flask import Blueprint
from flask_sqlalchemy import SQLAlchemy
from app import models
from app import db
from app.models import GRE
import pandas as pd
import random


main = Blueprint('main', __name__)

from . import events


def isUniqueNickName(nickname, nicknames_used):
    if nickname in nicknames_used:
        return False
    else:
        return True


def isRoomEmpty(roomDictionary):
    if len(roomDictionary) == 0:
        return True
    else:
        return False



def getLeaderboard(player_scores):
    return sorted(player_scores.items(), key=lambda x: x[1], reverse = True)


# [horse, dog, cat, mat, sheet, bat] - RoomCodes
# [horse, cat]
