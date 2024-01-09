class Products{
  String id;
  String name; 
  String categorie; 
  int stocks ;
  int prixAchat;
  int  prixVente;

  Products(
    this.id,
     this.name, 
     this.categorie, 
     this.stocks, 
     this.prixAchat, 
     this.prixVente
   );


 static List<Products> getProducts(){
  return [
      Products("1","nivea","pommade",10, 1200 , 2000),
      Products("2","clairmen","lait",10, 1000 , 2000),
      Products("3","dove","deodorant",10, 1200 , 2000),
      Products("4","nivea","parfum",10, 1200 , 2000),
      Products("5","axer","deodorant",10, 1200 , 2000),
      Products("6","day by day","pommade",10, 1200 , 2000),
      Products("7","caro white","lotion",10, 1200 , 2000),
      Products("8","relax","insect",10, 1200 , 2000),
      Products("9","nivea","pommade",10, 1200 , 2000),
      Products("10","nivea","pommade",10, 1200 , 2000),
      
      Products("11","nivea","pommade",10, 1200 , 2000),
      Products("12","clairmen","lait",10, 1000 , 2000),
      Products("13","dove","deodorant",10, 1200 , 2000),
      Products("14","nivea","parfum",10, 1200 , 2000),
      Products("15","axer","deodorant",10, 1200 , 2000),
      Products("16","day by day","pommade",10, 1200 , 2000),
      Products("17","caro white","lotion",10, 1200 , 2000),
      Products("18","relax","insect",10, 1200 , 2000),
      Products("19","nivea","pommade",10, 1200 , 2000),
      Products("20","nivea","pommade",10, 1200 , 2000),
 
  ];
 }
}