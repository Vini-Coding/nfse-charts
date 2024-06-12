// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/item/materia_prima_item.dart';

class NfseItem {
  final String id;
  final String quantidade;
  final String valorUnitario;
  final String valorTotal;
  final dynamic valorDesconto;
  final dynamic valorFrete;
  final dynamic valorIpi;
  final String unidade;
  final dynamic quantidadeConversao;
  final bool cancelado;
  final dynamic fatorConversao;
  final MateriaPrimaId materiaPrimaId;
  final dynamic conversaoId;
  final dynamic produtoId;

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
      'valor_unitario': valorUnitario,
      'valor_total': valorTotal,
      'valor_desconto': valorDesconto,
      'valor_frete': valorFrete,
      'valor_ipi': valorIpi,
      'unidade': unidade,
      'quantidade_conversao': quantidadeConversao,
      'cancelado': cancelado,
      'fator_conversao': fatorConversao,
      'materia_prima_id': materiaPrimaId.toMap(),
      'conversao_id': conversaoId,
      'produto_id': produtoId,
    };
  }

  factory NfseItem.fromMap(Map<String, dynamic> map) {
    return NfseItem(
      id: map['id'] as String,
      quantidade: map['quantidade'] as String,
      valorUnitario: map['valor_unitario'] as String,
      valorTotal: map['valor_total'] as String,
      valorDesconto: map['valor_desconto'] as dynamic,
      valorFrete: map['valor_frete'] as dynamic,
      valorIpi: map['valor_ipi'] as dynamic,
      unidade: map['unidade'] as String,
      quantidadeConversao: map['quantidade_conversao'] as dynamic,
      cancelado: map['cancelado'] as bool,
      fatorConversao: map['fator_conversao'] as dynamic,
      materiaPrimaId: MateriaPrimaId.fromMap(map['materia_prima_id'] as Map<String,dynamic>),
      conversaoId: map['conversao_id'] as dynamic,
      produtoId: map['produto_id'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfseItem.fromJson(String source) => NfseItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
