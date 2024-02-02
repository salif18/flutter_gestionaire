class Products{
    int id ;
    String nom ;
    String categories ;
    int prixAchat ;
    int prixVente ;
    int stocks ;
    String dateAchat ;

 Products({
    required this.id,
    required this.nom,
    required this.categories,
    required this.prixAchat,
    required this.prixVente,
    required this.stocks,
    required this.dateAchat
  });

// Ajoutez une méthode fromJson ici
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      nom: json['nom'],
      categories: json['categories'],
      prixAchat: json['prixAchat'],
      prixVente: json['prixVente'],
      stocks: json['stocks'],
      dateAchat: json['dateAchat']
    );
  }
}