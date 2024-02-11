class Depenses{
  int id;
  String motifs;
  DateTime timestamp;

  Depenses({
    required this.id,
    required this.motifs,
    required this.timestamp
  });

  factory Depenses.formJson(Map<String,dynamic> json){
    return Depenses(
      id: json["id"], 
      motifs: json["motifs"], 
      timestamp: json["timestamp"]
      );
  }
}