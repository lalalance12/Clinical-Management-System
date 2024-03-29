from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from flask_mysql_connector import MySQL
from config import DB_USERNAME, DB_PASSWORD, DB_NAME, DB_HOST, SECRET_KEY, MAIL_SERVER, MAIL_PORT, MAIL_USERNAME, MAIL_PASSWORD, MAIL_USE_TLS, MAIL_USE_SSL, cloud_name, api_key, api_secret
from flask_wtf.csrf import CSRFProtect
from flask_login import LoginManager, login_user, current_user
from flask_mail import Mail
from flask_socketio import SocketIO
import cloudinary
import cloudinary.uploader
import cloudinary.api

mysql = MySQL()

login_manager = LoginManager()
mail = Mail()
csrf = CSRFProtect()
socketio = SocketIO()

def create_app():
    app = Flask(__name__)

    app.config['SECRET_KEY'] = SECRET_KEY
    app.config['MYSQL_HOST'] = DB_HOST
    app.config['MYSQL_USER'] = DB_USERNAME
    app.config['MYSQL_PASSWORD'] = DB_PASSWORD
    app.config['MYSQL_DATABASE'] = DB_NAME
    app.config['MAIL_SERVER']= MAIL_SERVER
    app.config['MAIL_PORT'] = MAIL_PORT
    app.config['MAIL_USERNAME'] = MAIL_USERNAME
    app.config['MAIL_PASSWORD'] = MAIL_PASSWORD
    app.config['MAIL_USE_TLS'] = MAIL_USE_TLS
    app.config['MAIL_USE_SSL'] = MAIL_USE_SSL
    
    cloudinary.config (
        cloud_name=cloud_name,
        api_key=api_key,
        api_secret=api_secret,
        secure = True
    )

    mysql.init_app(app)
    csrf.init_app(app)
    mail.init_app(app)
    socketio.init_app(app)
    
    login_manager = LoginManager(app)
 
    @login_manager.user_loader
    def load_user(user_id):
        return User.get(user_id)

    @app.route("/", methods=['GET', 'POST'])
    def login():
        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']

            user = User.authenticate(username, password)
            if user:
                login_user(user)
                User.record_login(user.role.upper(), current_user.username)
                if user.role == 'admin':
                    return redirect(url_for('admin.dashboard'))
                elif user.role == 'doctor':
                    return redirect(url_for('doctor.dashboard'))
                elif user.role == 'medtech':
                    return redirect(url_for('medtech.dashboard'))
                elif user.role == 'receptionist':
                    return redirect(url_for('receptionist.dashboard'))
            else:
                flash("The username or password you've entered is incorrect", 'error')

        return render_template("login.html")
    
    @socketio.on('connect')
    def handle_connect():
        print('Client connected')

    @socketio.on('disconnect')
    def handle_disconnect():
        print('Client disconnected')

    from app.routes.admin_bp import admin_bp
    from app.routes.doctor_bp import doctor_bp
    from app.routes.medtech_bp import medtech_bp
    from app.routes.receptionist_bp import receptionist_bp
    from app.models.login_m import User
    
    app.register_blueprint(admin_bp, url_prefix='/admin/')
    app.register_blueprint(doctor_bp, url_prefix='/doctor/')
    app.register_blueprint(medtech_bp, url_prefix='/medtech/')
    app.register_blueprint(receptionist_bp, url_prefix='/receptionist/')

    return app
