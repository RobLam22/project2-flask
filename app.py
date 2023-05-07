from flask import Flask
import os
import psycopg2

my_secret_key=os.getenv("SECRET_KEY")
app.config['SECRET_KEY'] = my_secret_key

app = Flask(__name__)

@app.route('/')
def homepage():
    # connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("pgrender"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    # connection = psycopg2.connect(os.getenv("DATABASE_URL"), password=os.getenv("PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW"))
    connection = psycopg2.connect(dbname="p2", port=5433, user="postgres", password="roblam")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM boardgame_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('home.html', home_items = results)

# @app.route('/about')
#     def about_page():
#         pass

# @app.route('/signup')
#     def signup_page():
#         pass

# @app.route('/explore')
#     def explore_page():
#         pass

if __name__ == '__main__':
    app.run(debug=True, port=os.getenv("PORT", default=5000))
