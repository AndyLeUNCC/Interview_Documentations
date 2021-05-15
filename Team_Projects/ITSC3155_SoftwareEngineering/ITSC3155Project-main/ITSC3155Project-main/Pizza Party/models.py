from datetime import datetime

from database import db


class Event(db.Model):
    event_id = db.Column("event_id", db.Integer, primary_key=True)
    name = db.Column("name", db.String(100))
    eventDate = db.Column("eventDate", db.String(50))
    startTime = db.Column("startTime", db.String(20))
    endTime = db.Column("endTime", db.String(20))
    desc = db.Column("desc", db.String(100))
    rating = db.Column("rating", db.Integer)
    path_image = db.Column("path_image", db.String(200))

    creation = db.Column("creation", db.String(50))
    # can create a foreign key; referencing the id variable in the User class, so that is why it is lowercase u
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    comments = db.relationship("Comment", backref="event", cascade="all, delete-orphan", lazy=True)
    # setup relationship between user and event

    def __init__(self, name, eventDate, startTime, endTime, desc, rating, creation, path_image, user_id):
        self.name = name
        self.eventDate = eventDate
        self.startTime = startTime
        self.endTime = endTime
        self.desc = desc
        self.rating = rating
        self.creation = creation
        self.path_image = path_image
        self.user_id = user_id

    def __repr__(self):
        return "Event name:% s description:% s rating:% s date:% s user_id:% s" % (self.name, self.desc, self.rating, self.eventDate, self.user_id)


class User(db.Model):
    id = db.Column("id", db.Integer, primary_key=True)
    first_name = db.Column("first_name", db.String(100))
    last_name = db.Column("last_name", db.String(100))
    email = db.Column("email", db.String(100))
    password = db.Column(db.String(255), nullable=False)
    registered_on = db.Column(db.DateTime, nullable=False)
    # 1: dark mode, 0: default theme
    dark_mode = db.Column("dark_mode", db.String(10), nullable=False)
    events = db.relationship("Event", backref="user", lazy=True)
    comments = db.relationship("Comment", backref="user", lazy=True)

    def __init__(self, first_name, last_name, email, password, dark_mode):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.dark_mode = dark_mode
        self.registered_on = datetime.today()


class Comment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    date_posted = db.Column(db.DateTime, nullable=False)
    content = db.Column(db.VARCHAR, nullable=False)
    event_id = db.Column(db.Integer, db.ForeignKey("event.event_id"), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)

    def __init__(self, content, event_id, user_id):
        self.date_posted = datetime.today()
        self.content = content
        self.event_id = event_id
        self.user_id = user_id
