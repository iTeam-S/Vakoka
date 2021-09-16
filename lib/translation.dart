var data = {
  'bienvenue': {'fr': 'Bienvenue', 'en': 'Welcome', 'mg': 'Tongasoa'},
  'incorrect_pass': {
    'fr': 'Mot de passe ou Nom d\'utilisateur incorrecte',
    'en': 'Password or Username invalid',
    'mg': 'Misy diso ny anarana na soratra miafina nampidirinao',
  },
  'email_ou_numero_telephone': {
    'fr': 'Email ou Numero de téléphone',
    'en': 'Mail or Phone Number',
    'mg': 'Mailaka na Laharan-tariby',
  },
  'se_connecter': {
    'fr': 'connecter',
    'en': 'connect',
    'mg': 'Hiditra',
  },
  'erreur_produite': {
    'fr': 'Une erreur s\'est produite.',
    'en': 'an error occured',
    'mg': 'Mandalo olana ara-teknika',
  },
  'erreur': {
    'fr': 'Erreur',
    'en': 'Error',
    'mg': 'Hadisoana',
  },
  'deconnexion': {
    'fr': 'Déconnexion'
    'en': 'LogOut',
    'mg': 'Hivoaka',
  },
  'carte': {
    'fr': 'Carte'
    'en': 'Maps',
    'mg': 'Sarin-tany',
  }
  'Ajout_d_un_document': {
    'fr': 'Ajouter un document'
    'en': 'Add a document',
    'mg': 'Fampidirana tahirin-kevitra',
  }
  'Titre': {
    'fr': 'Titre'
    'en': 'Title',
    'mg': 'Lohateny',
  }
  'Description': {
    'fr': 'Déscription'
    'en': 'About',
    'mg': 'Mombamomba',
  }
  'Texte': {
    'fr': 'Texte'
    'en': 'Text',
    'mg': 'Lahatsoratra',
  }
  'Titre': {
    'fr': 'Titre'
    'en': 'Title',
    'mg': 'Lohateny',
  }
  'Categorie': {
    'fr': 'Catégorie'
    'en': 'Category',
    'mg': 'Sokajy',
  }
  'Biby': {
    'fr': 'Animaux'
    'en': 'Animals',
    'mg': 'Biby',
  }
  'Fichier': {
    'fr': 'Fichier'
    'en': 'File',
    'mg': 'Rakitra',
  }
  'Recherche': {
    'fr': 'Recherche'
    'en': 'Search',
    'mg': 'Tadiavina',
  }
  'AJOUTER': {
    'fr': 'Ajouter'
    'en': 'Add',
    'mg': 'Ampidirina',
  }
  'mot_de_passe': {
    'fr': 'Mot de passe'
    'en': 'Password',
    'mg': 'Teny miafina',
  }
  'mot_de_passe_oublie_?': {
    'fr': 'Mot de passe oublié ?'
    'en': 'Forgot your password ?',
    'mg': 'Hadinonao ve ny teny miafinao ?',
  }
};

String translate(String cle, String lang) {
  String? tmp = data[cle]![lang];
  if (tmp == null)
    return cle;
  else
    return tmp;
}
