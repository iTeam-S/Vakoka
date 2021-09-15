import os
import jwt
import time
import mysql.connector
from datetime import datetime, timedelta
from werkzeug.utils import secure_filename

from flask import Flask , request, jsonify, render_template, send_from_directory
from flask_cors import CORS

from conf import *


app = Flask(__name__)
CORS(app)

db = mysql.connector.connect(**database())
cursor = db.cursor()

path = os.getcwd()
if not os.path.isdir('data'):
    os.makedirs('data\contents')

UPLOAD_FOLDER = os.path.join(path, 'data\contents')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Utils function
def encode_auth_token(user_id):
    payload = {
        'exp': datetime.utcnow() + timedelta(days=7),
        'sub': user_id
    }
    return jwt.encode(
        payload,
        'TOKEN_KEY',
        algorithm='HS256'
    )

def verifToken(token):
    try:
        return jwt.decode(token, 'TOKEN_KEY', 
            algorithms='HS256', options={"verify_signature": True})
    except Exception as err:
        print(err)
        return {"sub":0}

# API route
@app.route("/api/v1/login/", methods=['POST'])
def login():
    """
        DESC : Fonction permettant l'authentification d'un utilisateur
    """
    data = request.get_json()

    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    email = data.get("mail")
    mdp = data.get("password")

    cursor.execute(""" 
        SELECT id, compte, nom, prenom FROM Users WHERE email = %s AND mdp = %s
    """, (email, mdp)
    )

    user_data = cursor.fetchone()
    db.close()

    if user_data is not None:
        token = encode_auth_token(user_data[0])
        print(token, user_data)
        return jsonify({
            'token' : token,
            'id': user_data[0],
            'admin': str(user_data[1]),
            'nom': user_data[2]+" "+user_data[3]
        }), 200
    else:
        return jsonify({'status': 'incorrect_pass',}), 403


@app.route("/api/v1/insert_content/", methods=['POST'])
def insert_content():
    """
        DESC : Fonction permettant enregistrer un nouveau contenu'
    """
    # data = request.get_json()
    data = request.form

    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != int(user_id):
        return {"status" : "Erreur Token"}, 403

    content = {
        'title' : data.get("title"),
        'description' : data.get("description"),
        'text' : data.get("text"),
        'category' : data.get("category")
    }

    # Upload files if exists
    uploaded_files = request.files.getlist("file[]")
    file_list = ''

    if uploaded_files:
        for file in uploaded_files:
            filename = str(time.time()) + '_' + secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            file_list = filename + ';' if ';' not in file_list else  file_list + filename + ';'
            print(file_list)


    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    cursor.execute("""
            INSERT INTO Contenu(title, description, text, user_id, files, category) VALUES(%s, %s, %s, %s, %s, %s)
        """,(content['title'], content['description'], content['text'], user_id, file_list[:-1], content['category'])
    )

    db.commit()
    db.close()

    return jsonify({'status': 'content_created'}), 201


if __name__=="__main__":
    app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT', 4444)), debug=True)
