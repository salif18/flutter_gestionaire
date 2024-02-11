class CartItem {
  int id;
  String nom;
  String categories;
  int quantity;
  int prixAchat;
  int prixVente;
  int stocks;


  CartItem({
    required this.id, 
    required this.nom, 
    required this.categories, 
    required this.quantity,
    required this.prixAchat,
    required this.prixVente, 
    required this.stocks, 
  });

    factory CartItem.fromJson(Map<String,dynamic> json){
        return CartItem(
          id:json["id"], 
          nom:json["nom"], 
          categories:json["categories"], 
          quantity:json["quantity"], 
          prixAchat:json["prixAchat"], 
          prixVente:json["prixVente"], 
          stocks:json["stocks"], 
          );
    }
}