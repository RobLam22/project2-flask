from flask import Flask, request, render_template, redirect, session
import psycopg2
# from models import food, user
import bcrypt

# my_secret_key=os.getenv("SECRET_KEY")
# app.config['SECRET_KEY'] = my_secret_key

app = Flask(__name__)

@app.route('/')
def homepage(): 
    connection = psycopg2.connect(  host=os.getenv("PGHOST", "dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com"), 
                                    user=os.getenv("pgrender"), 
                                    password=os.getenv("PGPASSWORD", "YsRbSGWctAQTPL8pX5sOear938QrwlLW"), 
                                    port=os.getenv("PGPORT", "5432"), 
                                    dbname=os.getenv("PGDATABASE", "flaskdb_uiod"))
    # connection = psycopg2.connect(os.getenv("DATABASE_URL"))
    # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM homepage_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('home.html', home_list = results)

@app.route('/about')
def about_page():
    # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    connection = psycopg2.connect(  host=os.getenv("PGHOST", "dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com"), 
                                user=os.getenv("pgrender"), 
                                password=os.getenv("PGPASSWORD", "YsRbSGWctAQTPL8pX5sOear938QrwlLW"), 
                                port=os.getenv("PGPORT", "5432"), 
                                dbname=os.getenv("PGDATABASE", "flaskdb_uiod"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM homepage_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('about.html', home_list = results)
        
@app.route('/explore')
def explore_page():
    # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    connection = psycopg2.connect(  host=os.getenv("PGHOST", "dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com"), 
                                user=os.getenv("pgrender"), 
                                password=os.getenv("PGPASSWORD", "YsRbSGWctAQTPL8pX5sOear938QrwlLW"), 
                                port=os.getenv("PGPORT", "5432"), 
                                dbname=os.getenv("PGDATABASE", "flaskdb_uiod"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM board_list;")
    results = cursor.fetchall()
    connection.close()
    return render_template('explore.html', board_list = results)

@app.route('/signup')
def signup_page():
    return render_template('signup.html')

@app.route('/signup', methods=['POST'])
def signup_action():
    name = request.form.get('name')
    email = request.form.get('email')
    password = request.form.get('password')

    hashed_pw = bcrypt.hashpw(password.encode(), salt).decode()
    user.add_user(name, email, hashed_pw)

    return redirect("/login")

@app.route('/login')
def login_page():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_action():
    # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    connection = psycopg2.connect(  host=os.getenv("PGHOST", "dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com"), 
                                user=os.getenv("pgrender"), 
                                password=os.getenv("PGPASSWORD", "YsRbSGWctAQTPL8pX5sOear938QrwlLW"), 
                                port=os.getenv("PGPORT", "5432"), 
                                dbname=os.getenv("PGDATABASE", "flaskdb_uiod"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM users;")
    results = cursor.fetchall()
    connection.close()

    email = request.form.get('email')
    password = request.form.get('password')
    hashed_password = user.get_user("WHERE email=%s", [email])["hashed_password"]
    isValidPassword = bcrypt.checkpw(password.encode(), hashed_password.encode())
    curr_user = user.get_user("WHERE email=%s", [email])
    if curr_user:
        session["user_id"] = curr_user["id"]
        session["user_name"] = curr_user["name"]
        if isValidPassword == True:
            print("WORKS")
        else:
            print("YEAH NAH")
        return redirect('/menu')
    else:
        return render_template("login_error.html")
    return render_template('login.html')




if __name__ == '__main__':
    # app.run(debug=True, port=os.getenv("PORT", default=5000))
    app.run(debug=True)
