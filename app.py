from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
    def home():
    # connection = psycopg2.connect(host=os.getenv("PGHOST"), user=os.getenv("pgrender"), password=os.getenv("PGPASSWORD"), port=os.getenv("PGPORT"), dbname=os.getenv("PGDATABASE"))
    connection = psycopg2.connect(os.getenv("DATABASE_URL"))
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM boardgame_board;")
    results = cursor.fetchall()
    connection.close()
    return render_template('home.html', home_items = results)

@app.route('/about')
    def about_page():

@app.route('/signup')
    def signup_page():

@app.route('/explore')
    def explore_page():

if __name__ == '__main__':
    app.run(debug=True, port=os.getenv("PORT", default=5000))
