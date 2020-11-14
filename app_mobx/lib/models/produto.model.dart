class Produto {
  String nome;
  String quantidade;
  bool concluido;

  Produto({this.nome, this.quantidade, this.concluido});

  Produto.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    quantidade = json['quantidade'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['quantidade'] = this.quantidade;
    data['concluido'] = this.concluido;
    return data;
  }
}