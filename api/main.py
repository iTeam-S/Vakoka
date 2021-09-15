import os
import jwt
import mysql.connector
from datetime import datetime, timedelta

from flask import Flask , request, jsonify, render_template, send_from_directory
from flask_cors import CORS

from conf import *


app = Flask(__name__)
CORS(app)

db = mysql.connector.connect(**database())
cursor = db.cursor()


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
        return jwt.decode(token, os.environ.get('TOKEN_KEY'), algorithms='HS256', options={"verify_signature": True})
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
        SELECT id, compte FROM Users WHERE email = %s AND mdp = %s
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
            'admin': str(user_data[1])
        }), 200
    else:
        return jsonify({'status': 'Adresse email ou mot de passe incorrect',}), 403

if __name__=="__main__":
	app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT', 4444)), debug=True)
