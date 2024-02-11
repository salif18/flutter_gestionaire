class ProductVenduModel {
  int id;
  String nom;
  String categories;
  int prixAchat;
  int prixVente;
  int stocks;
  int qty;
  DateTime timestamps;

  ProductVenduModel(
      {required this.id,
      required this.nom,
      required this.categories,
      required this.prixAchat,
      required this.prixVente,
      required this.stocks,
      required this.qty,
      required this.timestamps});

  factory ProductVenduModel.fromJson(Map<String, dynamic> json) {
    return ProductVenduModel(
        id: json["id"],
        nom: json["nom"],
        categories: json["categories"],
        prixAchat: json["prixAchat"],
        prixVente: json["prixVente"],
        stocks: json["stocks"],
        qty: json["qty"],
        timestamps: json["timestamp"]);
  }
}
