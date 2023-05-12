from flask import Flask, request, render_template, redirect, session
import os
import psycopg2
import bcrypt

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
    cursor.execute("SELECT * FROM macbook_board;")
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
    email = request.form.get('email').lower()
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

    email = request.form.get('email').lower()
    password = request.form.get('password')
    cursor.execute("SELECT * FROM users WHERE email=%s", [email])
    user_info = cursor.fetchall()
    if user_info == []:
        return render_template('/login_error.html')
    stored_password = user_info[0][3]
    isValidPassword = bcrypt.checkpw(password.encode(), stored_password.encode())
    curr_user = user_info[0][1]
    connection.close()
    if isValidPassword == True:
        session['id'] = user_info[0][0]
        session['name'] = user_info[0][1]
        session['email'] = email
        return redirect(f'/account')
    else:
        return render_template('/login_error.html')

@app.route('/account')
def account_page():
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM users WHERE id={session['id']};")
    user_info = cursor.fetchall()[0]
    cursor.execute(f"SELECT * FROM board_list WHERE created_by={session['id']};")
    user_created_tables = cursor.fetchall()
    cursor.execute(f"SELECT * FROM board_list WHERE user_id_access LIKE '%{session['id']}' AND created_by != {session['id']};")
    shared_tables = cursor.fetchall()
    cursor.execute(f"SELECT * FROM board_list WHERE created_by!={session['id']};")
    non_user_tables = cursor.fetchall()
    return render_template('/account.html', boards_shared=shared_tables, boards_owned = user_created_tables, boards_not_owned=non_user_tables)

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

    return redirect(f'/board/{board_name}')

@app.route('/board/<table_name>')
def view_board(table_name):
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM board_list WHERE board_name = '{table_name}';")
    str_session_id = str(session['id'])
    board_data = cursor.fetchall() # [(2, 'boardgame_board', 'Roberts Game Collection!', False, None, 1)]
    board_id = board_data[0][0]
    board_name = board_data[0][1]
    board_description = board_data[0][2]
    private_check = board_data[0][3]
    print(private_check)
    user_access = board_data[0][4]
    if user_access == None:
        user_access = str_session_id
    created_by_id = board_data[0][5]
    cursor.execute(f"SELECT * FROM {board_name};")
    results = cursor.fetchall()
    cursor.execute(f"SELECT user_id_access FROM board_list WHERE board_name = '{board_name}';")
    user_list= cursor.fetchall()[0][0] #1,2,3
    if user_list != None:
        users_id = [int(id) for id in user_list.split(',')]
    else:
        users_id = list(range(1,1000))
    cursor.execute(f"SELECT id, email FROM users;")
    user_emails = cursor.fetchall() #[(1, 'admin@admin.com'), (2, 'user2@user2.com')]
    connection.close()

    return render_template('/view_board.html', private_check=private_check, user_emails=user_emails, users_id=users_id, user_list=user_list, str_session_id=str_session_id, user_access=user_access, board_list = results, board_name = board_name, board_desc = board_description, creator_id = created_by_id, board_id = board_id)

@app.route('/board/<table_name>', methods=["POST"])
def add_to_table_action(table_name):
    form = request.form
    table_name = form.get("table_name")
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
    return redirect(f'/board/{table_name}')

@app.route('/board/<table_name>/user_access', methods=["POST"])
def add_user_action(table_name):
    form = request.form
    email = form.get("email").lower()
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM users WHERE email='{email}';")
    results = cursor.fetchall()
    if results != []:
        cursor.execute(f"SELECT * FROM board_list WHERE board_name='{table_name}';")
        already_granted_access = cursor.fetchall()[0][4]
        new_access = already_granted_access + ',' + str(results[0][0])
        cursor.execute(f"UPDATE board_list SET user_id_access='{new_access}';")
        print("User granted Access")
    else:
        print("No user found")
        return redirect(f'/board/{table_name}')
    # connection.commit()
    connection.close()
    return redirect(f'/board/{table_name}')

@app.route('/edit/<table_name>/<id>')
def edit_post_page(table_name, id):
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM {table_name} WHERE id={id};")
    post_result = cursor.fetchall()[0] #(1, 'Catan', '#boardgame', 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__imagepage/img/M_3Vg1j2HlNgkv7PL2xl2BJE2bw=/fit-in/900x600/filters:no_upscale():strip_icc()/pic2419375.jpg', 1, 2)
    connection.close()
    return render_template('edit.html', post_data=post_result, table_name=table_name, id=id)

@app.route('/edit/<table_name>/<id>', methods=["PATCH"])
def edit_post_action(table_name, id):
    new_data = request.form
    post_id = new_data.get("post_id")
    description = new_data.get("description")
    hashtags = new_data.get("hashtags")
    image = new_data.get("image")
    user_id = new_data.get("user_id")
    board_list_id = new_data.get("board_list_id")
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM board_list WHERE id = {board_list_id};")
    table_name = cursor.fetchall()[0][1]
    cursor.execute(f"UPDATE {table_name} SET description='{description}', hashtag='{hashtags}', image='{image}', user_id={user_id}, board_list_id={board_list_id} WHERE id={post_id} ;")
    connection.commit()
    connection.close()
    return {}, 200

@app.route('/delete/<table_name>/<id>', methods=["DELETE"])
def delete_post_action(table_name, id):
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"DELETE FROM {table_name} WHERE id={id};")
    connection.commit()
    connection.close()
    return {}, 200

@app.route('/search')
def search_page():
    return render_template('/search.html')

@app.route('/search/results', methods=["POST"])
def search_action():
    form = request.form
    query = form.get('hashtag').lower()
    search_results = []
    final_results = []
    connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("user"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    cursor = connection.cursor()
    cursor.execute(f"SELECT board_name FROM board_list WHERE is_private = FALSE;")
    table_results = cursor.fetchall() #[('homepage_board',), ('macbook_board',), ('cityscape_board',)]
    for table in table_results:
        cursor.execute(f"SELECT {table[0]}.description, {table[0]}.hashtag, {table[0]}.image, board_list.board_name FROM {table[0]} JOIN board_list ON board_list.id = {table[0]}.board_list_id;")
        results = cursor.fetchall()
        search_results += results #list of tuples eg. ('Landscape #1', '#landscapes#nature#photography', 'https://picsum.photos/id/11/200/300', 'homepage_board')
    for results in search_results:
        if results[1].__contains__(query):
            final_results.append(results)
    connection.close()
    return render_template('/results.html', final_results=final_results)


if __name__ == '__main__':
    # app.run(debug=True, port=os.getenv("PORT", default=5000))
    app.run(debug=True)
