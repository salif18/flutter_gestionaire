class CartItem {
  int id;
  String nom;
  String categories;
  int quantity;
  int prixAchat;
  int prixVente;
  int stocks;
  int somme;

  CartItem(this.id, this.nom, this.categories, this.quantity, this.prixAchat,
      this.prixVente, this.stocks, this.somme);
}