import os
from re import S
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
    os.makedirs('data/contents')

UPLOAD_FOLDER = os.path.join(path, 'data/contents')
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
    # data = request.get_json()
    data = request.form

    print(data)

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

    category_ids =  data.get("categorie_ids")
    
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
        (content['title'], content['description'], content['text'], user_id, file_list[:-1], content['region'])
    )
 
    # Lancement des requetes
    cursor.execute("""
        INSERT INTO Category_contenu(category_id, contenu_id) VALUES(%s, %s)
        """,
        (category_ids, cursor.lastrowid,)
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
        SELECT ct.id, IFNULL(ct.name, ""), IFNULL(cn.title,""), IFNULL(cn.description,""), IFNULL(cn.text,""), IFNULL(cn.files,""), CONCAT(u.nom," ", u.prenom), cn.badge, IFNULL(cn.region,""), cn.id, u.badge, cn.license FROM Contenu cn 
        JOIN Category_contenu cc ON cn.id = cc.contenu_id 
        JOIN Category ct ON ct.id = cc.category_id 
        JOIN Users u ON u.id = cn.user_id;
        """
    )

    contenus = cursor.fetchall()

    categs = list(set([(contenu[0], contenu[1]) for contenu in contenus]))

    last = []

    for categ in categs:
        categ_content = []
        for contenu in contenus:
            if contenu[0] == categ[0]:
                categ_content = categ_content + [{
                        'title' : contenu[2],
                        'description': contenu[3],
                        'text': contenu[4],
                        'files': contenu[5],
                        'nom': contenu[6],
                        'badge': contenu[7],
                        'region': contenu[8],
                        'id': contenu[9],
                        'user_badge': contenu[10],
                        'license': contenu[11]
                    }]

        last = last + [{
                'cat_id' : categ[0],
                'cat_name' : categ[1],
                'contents' : categ_content
            }
        ]

    return jsonify(last), 200


@app.route('/api/v1/comment/', methods=['POST'])
def comment():

    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    text = data.get("text")
    contenu_id = data.get("contenu_id")

    # Lancement des requetes
    cursor.execute(
        'INSERT INTO Comment(text, user_id, contenu_id) VALUES (%s, %s, %s)',
        (text, user_id, contenu_id)	
    )

    # Sauvegarde des Transactions et Fermeture.
    db.commit()
    db.close()

    return {"status" : "comment_added"}, 201

@app.route('/api/v1/get_comments/', methods=['POST'])
def get_comments():

    data = request.get_json()

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    contenu_id = data.get("contenu_id")

    # Lancement des requetes
    cursor.execute("""
        SELECT cm.id, cm.text, CONCAT(us.nom, " ", us.prenom), cm.date_comment FROM Comment cm
        JOIN Users us ON cm.user_id = us.id
        WHERE contenu_id = %s""",
        (contenu_id, )
    )

    # Sauvegarde des Transactions et Fermeture.
    comments = cursor.fetchall()

    db.close()

    return jsonify({
            comment[0] : {
                'text': comment[1],
                'nom': comment[2],
                'date_comment': comment[3]
            } for comment in comments
        }
    )

@app.route('/api/v1/add_gallery/', methods=['POST'])
def add_gallery():

    data = request.form

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    title = data.get("title")
    description = data.get("contenu_id")

    image = request.files['file']

    filename = str(time.time()) + secure_filename(image.filename)
    image.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

    # Lancement des requetes
    cursor.execute(
        'INSERT INTO Gallery(title, description, image) VALUES (%s, %s, %s)',
        (title, description, filename)	
    )

    db.commit()
    db.close()

    return {"status" : "gallery_added"}, 201

@app.route('/api/v1/list_gallery/', methods=['POST'])
def list_gallery():

    data = request.form

    token = data.get("token")
    user_id = data.get("user_id")

    if verifToken(token).get('sub') != user_id :
        return {"status" : "Erreur Token"}, 403

    # Initialisation du connecteur
    db = mysql.connector.connect(**database())
    cursor = db.cursor()

    # Lancement des requetes
    cursor.execute("""
        SELECT id, title, description, image FROM Gallery
        """
    )

    gallery = cursor.fetchall()

    db.commit()
    db.close()

    return jsonify({
        gallery[1] : {
            'title' : gallery[1],
            'description' : gallery[2],
            'image' : gallery[3]
        }
    }), 201

if __name__=="__main__":
    app.run(host=os.getenv('IP', '0.0.0.0'), port=int(os.getenv('PORT', 4445)))
