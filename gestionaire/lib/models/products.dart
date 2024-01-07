class Products{
  String name; 
  String categorie; 
  int stocks ;
  int prixAchat;
  int  prixVente;

  Products(
     this.name, 
     this.categorie, 
     this.stocks, 
     this.prixAchat, 
     this.prixVente
   );


 static List<Products> getProducts(){
  return [
      Products("nivea","pommade",10, 1200 , 2000),
      Products("clairmen","lait",10, 1000 , 2000),
      Products("dove","deodorant",10, 1200 , 2000),
      Products("nivea","parfum",10, 1200 , 2000),
      Products("axer","deodorant",10, 1200 , 2000),
      Products("day by day","pommade",10, 1200 , 2000),
      Products("caro white","lotion",10, 1200 , 2000),
      Products("relax","insect",10, 1200 , 2000),
      Products("nivea","pommade",10, 1200 , 2000),
      Products("nivea","pommade",10, 1200 , 2000),
      
       Products("nivea","pommade",10, 1200 , 2000),
      Products("clairmen","lait",10, 1000 , 2000),
      Products("dove","deodorant",10, 1200 , 2000),
      Products("nivea","parfum",10, 1200 , 2000),
      Products("axer","deodorant",10, 1200 , 2000),
      Products("day by day","pommade",10, 1200 , 2000),
      Products("caro white","lotion",10, 1200 , 2000),
      Products("relax","insect",10, 1200 , 2000),
      Products("nivea","pommade",10, 1200 , 2000),
      Products("nivea","pommade",10, 1200 , 2000),
 
  ];
 }
}