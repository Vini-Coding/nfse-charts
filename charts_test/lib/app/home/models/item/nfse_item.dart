// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/item/materia_prima_item.dart';

class NfseItem {
  String id;
  String quantidade;
  String valorUnitario;
  String valorTotal;
  dynamic valorDesconto;
  dynamic valorFrete;
  dynamic valorIpi;
  String unidade;
  dynamic quantidadeConversao;
  bool cancelado;
  dynamic fatorConversao;
  MateriaPrimaItem materiaPrimaId;
  dynamic conversaoId;
  dynamic produtoId;

  NfseItem({
    required this.id,
    required this.quantidade,
    required this.valorUnitario,
    required this.valorTotal,
    required this.valorDesconto,
    required this.valorFrete,
    required this.valorIpi,
    required this.unidade,
    required this.quantidadeConversao,
    required this.cancelado,
    required this.fatorConversao,
    required this.materiaPrimaId,
    required this.conversaoId,
    required this.produtoId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantidade': quantidade,
      'valorUnitario': valorUnitario,
      'valorTotal': valorTotal,
      'valorDesconto': valorDesconto,
      'valorFrete': valorFrete,
      'valorIpi': valorIpi,
      'unidade': unidade,
      'quantidadeConversao': quantidadeConversao,
      'cancelado': cancelado,
      'fatorConversao': fatorConversao,
      'materiaPrimaId': materiaPrimaId.toMap(),
      'conversaoId': conversaoId,
      'produtoId': produtoId,
    };
  }

  factory NfseItem.fromMap(Map<String, dynamic> map) {
    return NfseItem(
      id: map['id'] as String,
      quantidade: map['quantidade'] as String,
      valorUnitario: map['valorUnitario'] as String,
      valorTotal: map['valorTotal'] as String,
      valorDesconto: map['valorDesconto'] as dynamic,
      valorFrete: map['valorFrete'] as dynamic,
      valorIpi: map['valorIpi'] as dynamic,
      unidade: map['unidade'] as String,
      quantidadeConversao: map['quantidadeConversao'] as dynamic,
      cancelado: map['cancelado'] as bool,
      fatorConversao: map['fatorConversao'] as dynamic,
      materiaPrimaId: MateriaPrimaItem.fromMap(map['materiaPrimaId'] as Map<String,dynamic>),
      conversaoId: map['conversaoId'] as dynamic,
      produtoId: map['produtoId'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfseItem.fromJson(String source) => NfseItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
