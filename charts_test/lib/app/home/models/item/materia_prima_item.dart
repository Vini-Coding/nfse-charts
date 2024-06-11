// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/item/pessoa_materia_prima.dart';

class MateriaPrimaItem {
    String id;
    String nome;
    String sku;
    String ean;
    String ncm;
    String preco;
    String unidade;
    PessoaMateriaPrima pessoaId;

    MateriaPrimaItem({
        required this.id,
        required this.nome,
        required this.sku,
        required this.ean,
        required this.ncm,
        required this.preco,
        required this.unidade,
        required this.pessoaId,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'sku': sku,
      'ean': ean,
      'ncm': ncm,
      'preco': preco,
      'unidade': unidade,
      'pessoaId': pessoaId.toMap(),
    };
  }

  factory MateriaPrimaItem.fromMap(Map<String, dynamic> map) {
    return MateriaPrimaItem(
      id: map['id'] as String,
      nome: map['nome'] as String,
      sku: map['sku'] as String,
      ean: map['ean'] as String,
      ncm: map['ncm'] as String,
      preco: map['preco'] as String,
      unidade: map['unidade'] as String,
      pessoaId: PessoaMateriaPrima.fromMap(map['pessoaId'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MateriaPrimaItem.fromJson(String source) => MateriaPrimaItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
