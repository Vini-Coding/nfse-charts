// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/item/pessoa_materia_prima.dart';

class MateriaPrimaId {
  final String id;
  final String nome;
  final String sku;
  final String ean;
  final String ncm;
  final String preco;
  final String unidade;
  final MateriaPrimaIdPessoaId pessoaId;

  MateriaPrimaId({
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
      'pessoa_id': pessoaId.toMap(),
    };
  }

  factory MateriaPrimaId.fromMap(Map<String, dynamic> map) {
    return MateriaPrimaId(
      id: map['id'] as String,
      nome: map['nome'] as String,
      sku: map['sku'] as String,
      ean: map['ean'] as String,
      ncm: map['ncm'] as String,
      preco: map['preco'] as String,
      unidade: map['unidade'] as String,
      pessoaId: MateriaPrimaIdPessoaId.fromMap(map['pessoa_id'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MateriaPrimaId.fromJson(String source) => MateriaPrimaId.fromMap(json.decode(source) as Map<String, dynamic>);
}

