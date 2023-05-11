import os
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
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM homepage_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('home.html', home_list = results)

@app.route('/about')
def about_page():
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM homepage_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('about.html', home_list = results)
        
@app.route('/explore')
def explore_page():
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
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
    hashed_pw = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute("INSERT INTO users (name, email, password_hash) VALUES (%s, %s, %s);", [name, email, hashed_pw])
    connection.commit()
    connection.close()

    return redirect("/login")

@app.route('/login')
def login_page():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login_action():
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM users;")
    results = cursor.fetchall()

    email = request.form.get('email')
    password = request.form.get('password')
    cursor.execute("SELECT * FROM users WHERE email=%s", [email])
    user_info = cursor.fetchall()
    print(user_info)
    stored_password = user_info[0][3]
    isValidPassword = bcrypt.checkpw(password.encode(), stored_password.encode())
    curr_user = user_info[0][1]
    print(curr_user)
    connection.close()
    if isValidPassword == True:
        session['id'] = user_info[0][0]
        session['name'] = user_info[0][1]
        session['email'] = email
        return redirect('/')
    else:
        return render_template('/login_error.html')

@app.route("/logout")
def logout_page():
    return render_template("/logout.html")

@app.route("/logged_out", methods=['POST'])
def logout_action():
    session['id'] = None
    session['name'] = None
    session['email'] = None
    return redirect("/")
        
@app.route('/new_board')
def new_board():
    return render_template('/new_board.html')

@app.route('/new_board', methods=['POST'])
def new_board_action():
    board_name = request.form.get('board_name')
    description = request.form.get('description')
    is_private = request.form.get('access') #returns on if checked

    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    user_id = session['id']
    if is_private == 'on':
        cursor.execute("INSERT INTO board_list (board_name, description, is_private, user_id_access, created_by) VALUES (%s, %s, %s, %s, %s);", [board_name, description, True, user_id, user_id])
    else:
        cursor.execute("INSERT INTO board_list (board_name, description, is_private, created_by) VALUES (%s, %s, %s, %s);", [board_name, description, False, user_id])
    cursor.execute(f"SELECT id FROM board_list WHERE board_name = '{board_name}';")
    board_id = cursor.fetchall()[0][0]
    cursor.execute(f"CREATE TABLE {board_name} (id SERIAL PRIMARY KEY, description TEXT, hashtag TEXT, image TEXT, user_id BIGINT, board_list_id BIGINT);")
    connection.commit()
    connection.close()

    return redirect('/board_<{board_name}>')

@app.route('/board_<name>')
def view_board(name):
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM board_list WHERE board_name = '{name}';")
    board_data = cursor.fetchall()
    # print(board_data) # [(2, 'boardgame_board', 'Roberts Game Collection!', False, None, 1)]
    board_id = board_data[0][0]
    # print(board_id) # 2
    board_name = board_data[0][1]
    # print(board_name) # boardgame_board
    board_description = board_data[0][2]
    # print(board_description) # Roberts Game Collection!
    created_by_id = board_data[0][5]
    # print(created_by_id) # 1
    cursor.execute(f"SELECT * FROM {board_name};")
    results = cursor.fetchall()
    connection.close()

    return render_template('/view_board.html', board_list = results, board_name = board_name, board_desc = board_description, creator_id = created_by_id, board_id = board_id)

@app.route('/api/board_data/add', methods=["POST"])
def add_to_table_action():
    form = request.form
    table_name = form.get("table_name")
    print(table_name) #boardgame_board
    description = form.get("description")
    hashtags = form.get("hashtags")
    image = form.get("image")
    user_id = form.get("user_id")
    board_list_id = form.get("board_list_id")
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"INSERT INTO {table_name} (description, hashtag, image, user_id, board_list_id) VALUES (%s, %s, %s, %s, %s);", [description, hashtags, image, user_id, board_list_id])
    connection.commit()
    connection.close()
    # throws error? needs to redirect then redirect?
    return redirect('/board_{table_name}')

@app.route('/form/board_data/edit/<id>', methods=["POST"])
def edit_post_page(id):
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM boardgame_board WHERE id={id};")
    post_result = cursor.fetchall()[0] #(1, 'Catan', '#boardgame', 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__imagepage/img/M_3Vg1j2HlNgkv7PL2xl2BJE2bw=/fit-in/900x600/filters:no_upscale():strip_icc()/pic2419375.jpg', 1, 2)
    connection.close()
    # throws error? needs to redirect then redirect?
    return render_template('edit.html', post_data=post_result)

@app.route('/api/board_data/edit/<id>', methods=["POST"])
def edit_post_action(id):
    new_data = request.form
    post_id = new_data.get("post_id")
    description = new_data.get("description")
    hashtags = new_data.get("hashtags")
    image = new_data.get("image")
    user_id = new_data.get("user_id")
    board_list_id = new_data.get("board_list_id")
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"UPDATE boardgame_board SET description='{description}', hashtag='{hashtags}', image='{image}', user_id={user_id}, board_list_id={board_list_id} WHERE id={post_id} ;")
    connection.commit()
    connection.close()
    return redirect('/board_boardgame_board')

@app.route('/api/board_data/delete/<id>', methods=["POST"])
def delete_post_action(id):
    new_data = request.form
    post_id = new_data.get("post_id")
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"DELETE FROM boardgame_board WHERE id={post_id};")
    connection.commit()
    connection.close()
    return redirect('/board_boardgame_board')

if __name__ == '__main__':
    # app.run(debug=True, port=os.getenv("PORT", default=5000))
    app.run(debug=True)
