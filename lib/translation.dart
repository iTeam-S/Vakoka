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
    'mg': 'Mailaka na Laharan\'ny finday',
  },
  'se_connecter': {
    'fr': 'connecter',
    'en': 'connect',
    'mg': 'Hiditra',
  },
  'erreur_produite': {'fr': 'Une erreur s\'est produite.'},
  'erreur': {'fr': 'Erreur'},
  'deconnexion': {'fr': 'Déconnexion'},
  'carte': {'fr': 'Carte'}
};

String translate(String cle, String lang) {
  String? tmp = data[cle]![lang];
  if (tmp == null)
    return cle;
  else
    return tmp;
}
