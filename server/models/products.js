class Produits {
  constructor(
    nom,
    categories,
    prixAchat,
    prixVente,
    stocks,
    dateAchat
  ) {
    this.nom = nom;
    this.categories = categories;
    this.prixAchat = prixAchat;
    this.prixVente = prixVente;
    this.stocks = stocks;
    this.dateAchat = dateAchat;
  }
}

module.exports = Produits;
