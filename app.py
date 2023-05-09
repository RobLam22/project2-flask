from flask import Flask, request, render_template, redirect, session
import psycopg2
# from models import food, user
import bcrypt

# my_secret_key=os.getenv("SECRET_KEY")
# app.config['SECRET_KEY'] = my_secret_key

app = Flask(__name__)
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

@app.route('/')
def homepage(): 
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    # connection = psycopg2.connect(os.getenv("DATABASE_URL"))
    # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM homepage_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('home.html', home_list = results)

# @app.route('/about')
# def about_page():
#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("SELECT * FROM homepage_board;")
#     results = cursor.fetchall()
#     connection.close()
#     return render_template('about.html', home_list = results)
        
# @app.route('/explore')
# def explore_page():
#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("SELECT * FROM board_list;")
#     results = cursor.fetchall()
#     connection.close()
#     return render_template('explore.html', board_list = results)

# @app.route('/signup')
# def signup_page():
#     return render_template('signup.html')

# @app.route('/signup', methods=['POST'])
# def signup_action():
#     name = request.form.get('name')
#     email = request.form.get('email')
#     password = request.form.get('password')
#     hashed_pw = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("INSERT INTO users (name, email, password_hash, signed_in) VALUES (%s, %s, %s, %s);", [name, email, hashed_pw, False])
#     connection.commit()
#     connection.close()

#     return redirect("/login")

# @app.route('/login')
# def login_page():
#     return render_template('login.html')

# @app.route('/login', methods=['POST'])
# def login_action():
#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("SELECT * FROM users;")
#     results = cursor.fetchall()

#     email = request.form.get('email')
#     password = request.form.get('password')
#     cursor.execute("SELECT * FROM users WHERE email=%s", [email])
#     user_info = cursor.fetchall()
#     stored_password = user_info[0][3]
#     isValidPassword = bcrypt.checkpw(password.encode(), stored_password.encode())
#     # look into sessions, might not need signed_in column
#     curr_user = user_info[0][2]
#     cursor.execute(f"UPDATE users SET signed_in=true WHERE id={user_info[0][0]};")
#     connection.commit()
#     cursor.execute("SELECT * FROM users WHERE email=%s", [email])
#     results2 = cursor.fetchall()
#     # print(results2[0])
#     session['email'] = email
#     print(session['email'])
#     connection.close()
#     if isValidPassword == True:
#         print("WORKS")
#         return redirect('/')
#     else:
#         return render_template('/login_error.html')

# @app.route('/new_board')
# def new_board():
#     return render_template('/new_board.html')

# @app.route('/new_board', methods=['POST'])
# def new_board_action():
#     board_name = request.form.get('board_name')
#     description = request.form.get('description')
#     is_private = request.form.get('access') #returns on if checked

#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("SELECT * FROM users WHERE signed_in = True;")
#     user_id = cursor.fetchall()[0][0]
#     if is_private == 'on':
#         cursor.execute("INSERT INTO board_list (board_name, description, is_private, user_id_access, created_by) VALUES (%s, %s, %s, %s, %s);", [board_name, description, True, user_id, user_id])
#     else:
#         cursor.execute("INSERT INTO board_list (board_name, description, is_private, created_by) VALUES (%s, %s, %s, %s);", [board_name, description, False, user_id])
#     cursor.execute(f"SELECT id FROM board_list WHERE board_name = '{board_name}';")
#     board_id = cursor.fetchall()[0][0]
#     cursor.execute(f"CREATE TABLE {board_name} (id SERIAL PRIMARY KEY, description TEXT, hashtag TEXT, image TEXT, user_id BIGINT, board_list_id BIGINT);")
#     connection.commit()
#     connection.close()

#     # return redirect('/board_<name>')
#     return redirect('/board_<{board_name}>')

# @app.route('/board_<name>')
# def view_board(name):
#     # connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
#     connection = psycopg2.connect(os.getenv("DATABASE_URL"))
#     cursor = connection.cursor()
#     cursor.execute("SELECT * FROM {name};")
#     connection.close()

#     return render_template('/view_board.html')

# if __name__ == '__main__':
#     # app.run(debug=True, port=os.getenv("PORT", default=5000))
#     app.run(debug=True)
