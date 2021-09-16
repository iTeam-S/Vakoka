class Categorie {
  final int id;
  final String nom;
  List<Contenue> contenues;

  Categorie(this.id, this.nom, this.contenues);
}

class Contenue {
  final int id;
  final String titre;
  final String description;
  final String texte;
  final Profile user;
  final bool officiel;
  final String files;
  final String region;

  Contenue(this.id, this.titre, this.description, this.texte, this.user,
      this.officiel, this.files, this.region);
}

class Profile {
  final String nom;
  final bool officiel;

  Profile(this.nom, this.officiel);
}
