class Ventes{
    constructor(id,nom,categories,prixAchat,prixVente,stocks,qty,timestamps){
        this.id =id;
        this.nom = nom;
        this.categories = categories;
        this.prixAchat = prixAchat;
        this.prixVente = prixVente;
        this.stocks = stocks;
        this.qty = qty ;
        this.timestamps=timestamps
      
    }
}    

module.exports = Ventes 