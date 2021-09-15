from os import environ as env
from dotenv import load_dotenv

load_dotenv()

def database(**kwargs):
     return {
          'host' : 'iteam-s.mg',
          'user' : env.get('ITEAMS_DB_USER'),
          'password': env.get('ITEAMS_DB_PASSWORD'),
          'database': 'BIBLIO',
	     'charset': 'utf8mb4'
     }