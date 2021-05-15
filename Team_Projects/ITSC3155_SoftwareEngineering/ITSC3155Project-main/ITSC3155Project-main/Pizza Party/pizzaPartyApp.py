# FLASK Tutorial 1 -- We show the bare bones code to get an app up and running

# imports
import os  # os is used to get environment variables IP & PORT

import bcrypt
from flask import Flask
from flask import json
from flask import redirect, url_for
from flask import render_template
from flask import request
from flask import session
from flask_change_password import ChangePassword, ChangePasswordForm

from database import db
from forms import RegisterForm, LoginForm, CommentForm, EditForm
from models import Event as Event, Comment
# from models import Event as Event, Comment
from models import User as User

app = Flask(__name__)  # create an app

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///pizza_party_app.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# configure the secret key that will be used to by the app to secure session data
app.config['SECRET_KEY'] = 'SE3155'

path = os.getcwd()
# file Upload
UPLOAD_FOLDER = os.path.join(path, 'static/Uploads')
# Make directory if "uploads" folder not exists
if not os.path.isdir(UPLOAD_FOLDER):
    os.mkdir(UPLOAD_FOLDER)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# for password change:
app.secret_key = os.urandom(20)
flask_change_password = ChangePassword(min_password_length=6, rules=dict({}))
flask_change_password.init_app(app)

#  Bind SQLAlchemy db object to this Flask app
db.init_app(app)
# Setup models
with app.app_context():
    db.create_all()  # run under the app context


# @app.route is a decorator. It gives the function "index" special powers.
# In this case it makes it so anyone going to "your-url/" makes this function
# get called. What it returns is what is shown as the web page
@app.route('/')
@app.route('/index')
def index():
    # a_user = db.session.query(User).filter_by(email='hle29@uncc.edu').one()

    # check if a user is saved in session
    if session.get('user'):
        return render_template("index.html", user=session['user'])
    return render_template("index.html")


@app.route('/about')
def about():
    # check if a user is saved in session
    if session.get('user'):
        return render_template("about.html", user=session['user'])
    return render_template("about.html")


@app.route('/contact')
def contact():
    # check if a user is saved in session
    if session.get('user'):
        return render_template("contact.html", user=session['user'])
    return render_template("contact.html")


@app.route('/contact/success')
def contactSuccessful():
    # check if a user is saved in session
    if session.get('user'):
        return render_template("about.html", user=session['user'])
    return render_template("contactSuccess.html")


@app.route('/users/<user_id>')
def get_user(user_id):
    return "The user number is " + str(user_id)


ROWS_PER_PAGE = 5


@app.route('/events/')
def get_events():
    # retrieve user from database
    # check if a user is saved in session
    if session.get('user'):
        # Set the pagination configuration
        page = request.args.get('page', 1, type=int)
        # retrieve notes from database
        my_events = db.session.query(Event).filter_by(user_id=session['user_id']).paginate(page=page,
                                                                                           per_page=ROWS_PER_PAGE)
        print(my_events)
        return render_template('events.html', events=my_events, user=session['user'])
    else:
        return redirect(url_for('login'))


@app.route('/cancel')
def cancel():
    print("cancel function")
    return redirect(url_for('get_events'))


@app.route('/events/<event_id>')
def get_event(event_id):
    # retrieve user from database
    # a_user = db.session.query(User).filter_by(email='hle29@uncc.edu').one()
    # check if a user is saved in session
    if session.get('user'):
        # retrieve event from database
        my_event = db.session.query(Event).filter_by(event_id=event_id).one()
        # create a comment form object
        form = CommentForm()
        return render_template('event.html', event=my_event, user=session['user'], form=form)

    else:
        return redirect(url_for('login'))


@app.route('/events/edit/upload', methods=['GET', 'POST'])
@app.route('/events/upload', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        file = request.files['file']
        # extension = os.path.splitext(file.filename)[1]
        # f_name = str(uuid.uuid4()) + extension
        f_name = file.filename
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], f_name))
        # print("file_name:" + f_name)
    return json.dumps({'filename': f_name})


@app.route('/set_dark_mode', methods=['GET', 'POST'])
def set_dark_mode():
    if session.get('user'):
        if request.method == 'POST':
            current_userID = session['user_id']
            print(current_userID)
            current_user = db.session.query(
                User).filter_by(id=current_userID).one()

            # change user dark mode
            # add user to database and commit
            if current_user.dark_mode == "default":
                current_user.dark_mode = "dark_mode"
            else:
                current_user.dark_mode = "default"

            # update event in DB
            db.session.add(current_user)
            db.session.commit()
            # save the user dark mode to the session
            session['user_dark_mode'] = current_user.dark_mode
            print("session['user_dark_mode'] = " + current_user.dark_mode)
            return json.dumps({'dark_mode': current_user.dark_mode})

    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/events/new', methods=['GET', 'POST'])
def new_event():
    # retrieve user from database
    # a_user = db.session.query(User).filter_by(email='hle29@uncc.edu').one()
    # check if a user is saved in session
    if session.get('user'):
        # check method used for request
        # print('request method is', request.method)
        if request.method == 'POST':
            file_path = request.form['filePath']
            if file_path == "default":
                file_path = "default_pizza.jpg"
            print("file_path:" + file_path)
            # get title data
            name = request.form['name']
            eventDate = request.form['eventDate']
            # start time
            startTime = request.form['startTime']
            if startTime == "":
                startTime = "Unspecified"
            # end time
            endTime = request.form['endTime']
            if endTime == "":
                endTime = "Unspecified"
            # get event description
            desc = request.form['eventText']
            desc = desc.lstrip()
            desc = desc.rstrip()
            if desc == "":
                desc = "No description available."
            # create date stamp
            from datetime import date
            today = date.today()
            # format date mm/dd/yyyy
            today = today.strftime('%m-%d-%Y')
            creation = today
            rating = 0
            newEntry = Event(name, eventDate, startTime, endTime,
                             desc, rating, creation, file_path, session['user_id'])
            db.session.add(newEntry)
            db.session.commit()
            return redirect(url_for('get_events'))
        else:
            return render_template('new.html', user=session['user'])
    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/events/edit/<event_id>', methods=['GET', 'POST'])
def update_event(event_id):
    # get request - show new event form to edit event
    # retrieve user from database
    # a_user = db.session.query(User).filter_by(email='hle29@uncc.edu').one()

    # check if a user is saved in session
    if session.get('user'):
        # check method used for request
        # print('request method is', request.method)
        if request.method == 'POST':
            file_path = request.form['filePath']
            if file_path == "":
                file_path = "images/default_pizza.jpg"
            print("file_path" + file_path)
            # get title data
            name = request.form['name']
            # get event data
            desc = request.form['eventText']
            desc = desc.lstrip()
            desc = desc.rstrip()

            # get the event start time
            startTime = request.form['startTime']
            endTime = request.form['endTime']
            eventDate = request.form['eventDate']

            event = db.session.query(Event).filter_by(event_id=event_id).one()
            rating = event.rating
            # update event data
            event.name = name
            event.eventDate = eventDate
            event.startTime = startTime
            event.endTime = endTime
            event.desc = desc
            event.rating = rating
            event.path_image = file_path
            # update event in DB
            db.session.add(event)
            db.session.commit()

            return redirect(url_for('get_events'))
        else:
            # retrieve event from database
            my_event = db.session.query(
                Event).filter_by(event_id=event_id).one()
            print("my_event " + event_id + "" + my_event.path_image)
            return render_template('new.html', event=my_event, user=session['user'])
    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/events/rate/<event_id>', methods=['POST'])
def rate_event(event_id):
    # check if a user is saved in session
    if session.get('user'):
        # retrieve event from database
        my_event = db.session.query(Event).filter_by(event_id=event_id).one()
        print(my_event.rating)
        currentRating = my_event.rating
        my_event.rating = currentRating + 1
        db.session.add(my_event)
        db.session.commit()

        return redirect(url_for('get_events'))
    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/events/delete/<event_id>', methods=['POST'])
def delete_event(event_id):
    # check if a user is saved in session
    if session.get('user'):
        # retrieve event from database
        my_event = db.session.query(Event).filter_by(event_id=event_id).one()
        print(my_event)
        db.session.delete(my_event)
        db.session.commit()

        return redirect(url_for('get_events'))
    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/register', methods=['POST', 'GET'])
def register():
    form = RegisterForm()

    if request.method == 'POST' and form.validate_on_submit():
        # salt and hash password
        h_password = bcrypt.hashpw(
            request.form['password'].encode('utf-8'), bcrypt.gensalt())
        # get entered user data
        first_name = request.form['firstname']
        last_name = request.form['lastname']
        dark_mode = "default"
        # create user model
        new_user = User(first_name, last_name,
                        request.form['email'], h_password, dark_mode)
        # add user to database and commit
        db.session.add(new_user)
        db.session.commit()
        # save the user's name to the session
        session['user'] = first_name
        # access id value from user model of this newly added user
        session['user_id'] = new_user.id
        # show user dashboard view
        return redirect(url_for('get_events'))

    # something went wrong - display register view
    return render_template('register.html', form=form)


@app.route('/edit', methods=['POST', 'GET'])
def edit():
    print("edit feature")
    # check if a user is saved in session
    if session.get('user'):

        user = db.session.query(User).filter(
            User.id == session['user_id']).first()
        print("user name:" + user.first_name + "." + user.last_name)

        if user:
            form = EditForm(formdata=request.form, obj=user)
            if request.method == 'POST' and form.validate():
                # save edits
                save_changes(user, form)
                # flask('Profile updated successfully')
                # save the user's name to the session
                session['user'] = user.first_name
                # access id value from user model of this newly added user
                session['user_id'] = user.id
                # show user dashboard view
                return redirect(url_for('index'))
            else:
                return render_template('edit_profile.html', form=form, user=session['user'])

    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


def save_changes(user, form):
    """
    Save the changes to the database
    """
    # Get data from form and assign it to the correct attributes
    # of the SQLAlchemy table object
    user.first_name = form.first_name.data
    user.last_name = form.last_name.data
    user.email = form.email.data

    # Add the new user to the database
    db.session.add(user)
    # commit the data to the database
    db.session.commit()


def save_pw(user, newpass):

    if session.get('user'):

        user = db.session.query(User).filter(
            User.id == session['user_id']).first()
        # encrypt password
        h_password = bcrypt.hashpw(newpass.encode('utf-8'), bcrypt.gensalt())
        user.password = h_password

        # Add the new user to the database
        db.session.add(user)
        # commit the data to the database
        db.session.commit()
    else:
        # user is not in session redirect to login
        return redirect(url_for('login'))


@app.route('/login', methods=['POST', 'GET'])
def login():
    login_form = LoginForm()
    # validate_on_submit only validates using POST
    if login_form.validate_on_submit():
        # we know user exists. We can use one()
        the_user = db.session.query(User).filter_by(
            email=request.form['email']).one()
        # user exists! check that password entered matches stored password
        if bcrypt.checkpw(request.form['password'].encode('utf-8'), the_user.password.encode('utf-8')):
            # password matches; add user info to session
            session['user'] = the_user.first_name
            session['user_id'] = the_user.id
            session['user_dark_mode'] = the_user.dark_mode

            # render view
            return redirect(url_for('get_events'))

        # password check failed
        # set error message to alert user
        login_form.password.errors = ["Incorrect username or password."]
        return render_template("login.html", form=login_form)
    else:
        # form did not validate or GET request
        return render_template("login.html", form=login_form)


@app.route('/change_password', methods=['GET', 'POST'])
def page_change_password():
    title = 'Change Password'
    currentUser = session['user']
    currentUserID = session['user_id']

    print(currentUser, currentUserID)
    currentPassword = db.session.query(
        User.password).filter_by(id=currentUserID).one()

    print(currentPassword)
    # print(bcrypt.checkpw(request.form['password'].encode('utf-8'), currentPassword))

    form = ChangePasswordForm(username=currentUser, changing=True, title=title)
    # make sure old password is correct
    # if bcrypt.checkpw(request.form['old_password'].encode('utf-8'), the_user.password):
    if form.validate_on_submit():
        valid = flask_change_password.verify_password_change_form(form)
        if valid:
            newpass = form.password.data
            save_pw(session['user'], newpass)
            return redirect(url_for('page_changed', title='changed', new_password=newpass))

        return redirect(url_for('page_change_password'))
    password_template = flask_change_password.change_password_template(
        form, submit_text='Change')
    return render_template('change_password.html', password_template=password_template, title=title, form=form,
                           user=dict(username=currentUser),
                           )

    # else:
    #     # form did not validate or GET request
    #     return render_template("change_password.html", form=ChangePasswordForm)


@app.route('/changed/<title>/<new_password>')
def page_changed(title, new_password=''):
    return render_template('changed.html', title=title, new_password=new_password)


@app.route('/logout')
def logout():
    # check if a user is saved in session
    if session.get('user'):
        session.clear()

    return redirect(url_for('index'))


@app.route('/events/<event_id>/comment', methods=['POST'])
def new_comment(event_id):
    if session.get('user'):
        comment_form = CommentForm()
        # validate_on_submit only validates using POST
        if comment_form.validate_on_submit():
            # get comment data
            comment_text = request.form['comment']
            new_record = Comment(comment_text, int(
                event_id), session['user_id'])
            db.session.add(new_record)
            db.session.commit()

        return redirect(url_for('get_event', event_id=event_id))

    else:
        return redirect(url_for('login'))


@app.route('/sort', methods=['GET', 'POST'])
def sort_events():
    # retrieve user from database
    # check if a user is saved in session
    if session.get('user'):
        # Set the pagination configuration
        page = request.args.get('page', 1, type=int)
        # retrieve notes from database based on sort selection
        # search_term = request.form['searchbox']
        # print("search_term is:" + search_term)
        select = request.form['sort']
        print(select)
        if select == "Date":
            my_events = db.session.query(Event).filter_by(user_id=session['user_id']).order_by(
                Event.eventDate).paginate(
                page=page,
                per_page=ROWS_PER_PAGE)
            return render_template('events.html', events=my_events, user=session['user'])
        elif select == "Name":
            my_events = db.session.query(Event).filter_by(user_id=session['user_id']).order_by(
                Event.name).paginate(
                page=page,
                per_page=ROWS_PER_PAGE)
            return render_template('events.html', events=my_events, user=session['user'])
        elif select == "Start_Time":
            my_events = db.session.query(Event).filter_by(user_id=session['user_id']).order_by(
                Event.startTime).paginate(
                page=page,
                per_page=ROWS_PER_PAGE)
            return render_template('events.html', events=my_events, user=session['user'])
        elif select == "End_Time":
            my_events = db.session.query(Event).filter_by(user_id=session['user_id']).order_by(
                Event.endTime).paginate(
                page=page,
                per_page=ROWS_PER_PAGE)

            return render_template('events.html', events=my_events, user=session['user'])
    else:
        return redirect(url_for('login'))


@app.route('/search', methods=['GET', 'POST'])
def search_events():
    # retrieve user from database
    # check if a user is saved in session
    if session.get('user'):
        # Set the pagination configuration
        page = request.args.get('page', 1, type=int)
        # retrieve notes from database
        search_term = request.form['searchbox']
        print("search_term is:" + search_term)
        my_events = db.session.query(Event).filter_by(user_id=session['user_id']).filter(
            Event.name.like('%' + search_term + '%')).paginate(page=page, per_page=ROWS_PER_PAGE)
        print(my_events)
        return render_template('events.html', events=my_events, user=session['user'])
    else:
        return redirect(url_for('login'))


app.run(host=os.getenv('IP', '127.0.0.1'), port=int(
    os.getenv('PORT', 5000)), debug=True)

# To see the web page in your web browser, go to the url,
#   http://127.0.0.1:5000

# Note that we are running with "debug=True", so if you make changes and save it
# the server will automatically update. This is great for development but is a
# security risk for production.
