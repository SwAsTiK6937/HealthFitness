from flask import Flask, send_file
from config import DB_CONFIG
from flask import Flask, render_template
from routes import create_app
from flask import Flask, render_template, request, redirect, url_for
from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt
import MySQLdb.cursors
from flask import Flask, render_template, request, redirect, url_for, session, flash


app = Flask(__name__, template_folder="C:\\Users\\swast\\OneDrive\\Desktop\\ProjVS\\HealthFitness\\backend\\templates")
app.secret_key = 'supersecretkey'  # Change this for security

# MySQL Configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'  # Change if needed
app.config['MYSQL_PASSWORD'] = '3370'  # Change this
app.config['MYSQL_DB'] = 'health_fitness'

mysql = MySQL(app)
bcrypt = Bcrypt(app)

# Home Page
@app.route('/')
def home():
    if 'user' in session:
        return f"Welcome, {session['user']}! <br><a href='/logout'>Logout</a>"
    return render_template('index.html')

# Register Route
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        age = request.form['age']
        height = request.form['height']
        weight = request.form['weight']
        sex = request.form['sex']

        # Hash the password for security
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        # Insert user into database
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO users (username, password, age, height, weight, sex) VALUES (%s, %s, %s, %s, %s, %s)",
                    (username, hashed_password, age, height, weight, sex))
        mysql.connection.commit()
        cur.close()

        flash("Registration successful! Please log in.", "success")
        return redirect(url_for('login'))

    return render_template('register.html')

# Login Route
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cur.fetchone()
        cur.close()

        if user:
            # `user[2]` is the password column (adjust index if needed)
            if bcrypt.check_password_hash(user[2], password):
                session['user'] = username
                flash("Login successful!", "success")
                return redirect(url_for('home'))
            else:
                flash("Incorrect password!", "danger")
        else:
            flash("No user found. Please register first.", "warning")
            return redirect(url_for('register'))

    return render_template("login.html")


# Logout Route
@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(debug=True)

