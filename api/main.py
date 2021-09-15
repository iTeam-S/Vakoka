import os
import jwt
import time
import mysql.connector
from datetime import datetime, timedelta
from werkzeug.utils import secure_filename

from flask import Flask , request, jsonify, render_template, send_from_directory
from flask_cors import CORS

from conf import *

# Instance du serveur flask
app = Flask(__name__)
CORS(app)

# Initialisation du connecteur à la base
db = mysql.connector.connect(**database())
cursor = db.cursor()

# Paramêtrage du dossier pour enregistrer les fichiers des contenus
path = os.getcwd()
if not os.path.isdir('data'):
    os.makedirs('data\contents')

UPLOAD_FOLDER = os.path.join(path, 'data\contents')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


# Utils function
def encode_auth_token(user_id):
    """
        DESC: Fonction pour générer un token à partir de l'user_id et TOKEN_KEY
    """
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
    """
        DESC: Fonction pour vérifier la validité d'un token
    """
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

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    email = data.get("mail")
    mdp = data.get("password")

    cursor.execute(""" 
        SELECT id, compte, nom, prenom FROM Users WHERE email = %s AND mdp = %s
    """, (email, mdp,)
    )

    user_data = cursor.fetchone()
    db.close()

    if user_data is not None:
        token = encode_auth_token(user_data[0])

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
    data = request.get_json()
    # data = request.form

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
        'region' : data.get("region")
    }

    category_ids =  data.get("category_ids")
    
    # Upload files if exists
    uploaded_files = request.files.getlist("files")
    file_list = ''

    if uploaded_files:
        for file in uploaded_files:
            filename = str(time.time()) + '_' + secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            file_list = filename + ';' if ';' not in file_list else  file_list + filename + ';'

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO Contenu(title, description, text, user_id, files, region) VALUES(%s, %s, %s, %s, %s, %s)
        """,
        (content['title'], content['description'], content['text'], user_id, file_list[:-1], content['description'])
    )

    # Lancement des requetes
    for category_id in category_ids:
        cursor.execute("""
            INSERT INTO Categorie_contenu(categorie_id, contenu_id) VALUES(%s, %s)
            """,
            (category_id, cursor.lastrowid,)
        )

    # Sauvegarde des Transactions et Fermeture.
    db.commit()
    db.close()

    return jsonify({'status': 'content_created'}), 201

@app.route('/api/v1/vote/', methods=['POST'])
def vote():
    # Recuperation des données envoyés
    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    plus_moins = data.get("plus_moins")
    contenu_id = data.get("contenu_id")

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()
	
    # Lancement des requetes
    cursor.execute("""
        INSERT INTO Vote(user_id, contenu_id, plus_moins) VALUES (%s, %s, %s)
        """,
        (user_id, contenu_id, plus_moins,)
    )

    # Sauvegarde des Transactions et Fermeture.
    db.commit()
    db.close()

    return {"status" : "vote_created"}, 201


@app.route('/api/v1/add_category/', methods=['POST'])
def add_category():
    """
        DESC : Fonction permettant d'ajouter un nouveau category
    """
    # Recuperation des données envoyés
    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()
    
    cat_name = data.get("cat_name")
    
    # Lancement des requetes
    cursor.execute(
        'INSERT INTO Category(name) VALUES(%s)',
        (cat_name,)	
    )

    # Sauvegarde des Transactions et Fermeture.
    db.commit()
    db.close()

    return jsonify({
            'cat_id': cursor.lastrowid,
            'cat_name': cat_name
        }), 200

@app.route("/api/v1/get_content_region/", methods=['POST'])
def get_content_region():
    """
        DESC : Fonction permettant de lister les contenus 
    """
    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    region = data.get("region")

    cursor.execute(""" 
        SELECT title, description, text, files FROM Contenu WHERE region = %s
        """,
        (region,)
    )
    
    contenus = cursor.fetchone()

    if contenus is not None:
        return jsonify({
            'title' : contenus[0],
            'description': contenus[1],
            'text': contenus[2],
            'files': contenus[3]
        }), 200
    else:
        return jsonify({'status': 'incorrect_pass',}), 403

@app.route("/api/v1/get_content_category/", methods=['POST'])
def get_content_category():
    """
        DESC : Fonction permettant l'authentification d'un utilisateur
    """
    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    category_id = data.get("category_id")

    cursor.execute(""" 
        SELECT ct.name, cn.title, cn.description, cn.text, cn.files FROM Contenu cn LEFT JOIN Category_contenu cc ON cn.id = cc.contenu_id 
        LEFT JOIN Category ct ON ct.id = cc.category_id WHERE cc.category_id = %s;
        """,
        (category_id,)
    )

    contenus = cursor.fetchall()

    print(contenus)

    return jsonify({
        'cat_id' : category_id,
        'cat_name' : contenus[0][0],
        'contents':[{
            'title' : contenu[1],
            'description': contenu[2],
            'text': contenu[3],
            'files': contenu[4]} for contenu in contenus]
    }), 200

@app.route("/api/v1/get_content/", methods=['POST'])
def get_content():
    """
        DESC : Fonction permettant l'authentification d'un utilisateur
    """
    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    cursor.execute(""" 
        SELECT cn.id, ct.id, ct.name, cn.title, cn.description, cn.text, cn.files FROM Contenu cn LEFT JOIN Category_contenu cc ON cn.id = cc.contenu_id 
        LEFT JOIN Category ct ON ct.id = cc.category_id;
        """
    )

    contenus = cursor.fetchall()

    print(contenus)

    return jsonify({
        contenu[0]:{
            'cat_id' : contenu[1],
            'cat_name' : contenu[2],
            'title' : contenu[3],
            'description': contenu[4],
            'text': contenu[5],
            'files': contenu[6]
        } for contenu in contenus
    }), 200


if __name__=="__main__":
    app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT', 4444)), debug=True)
