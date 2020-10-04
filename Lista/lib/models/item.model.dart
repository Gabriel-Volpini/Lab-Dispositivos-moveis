class Item {
  String titulo;
  String pagina;

  Item({this.titulo, this.pagina});

  Item.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    pagina = json['pagina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['pagina'] = this.pagina;
    return data;
  }
}
