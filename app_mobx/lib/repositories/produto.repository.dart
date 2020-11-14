import 'package:app_mobx/models/produto.model.dart';

class ProdutoRepository {
  List<Produto> list;

  ProdutoRepository() {
    list = new List<Produto>();
    list.add(Produto(nome: "Dentista", concluido: false));
    list.add(Produto(nome: "Natação", concluido: false));
  }

  Future<List<Produto>> getAll() async {
    try {
      await new Future.delayed(const Duration(seconds: 1));
      list.sort((a, b) {
        if (a.concluido && !b.concluido)
          return 1;
        else if (!a.concluido && b.concluido)
          return -1;
        else
          return 0;
      });
      return list;
    } catch (e) {
      return null;
    }
  }

  Future<bool> create(Produto p) async {
    try {
      await new Future.delayed(const Duration(seconds: 1));
      list.add(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(int id, Produto p) async {
    try {
      await new Future.delayed(const Duration(seconds: 1));
      list[id] = p;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      await new Future.delayed(const Duration(seconds: 1));
      list.removeAt(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
