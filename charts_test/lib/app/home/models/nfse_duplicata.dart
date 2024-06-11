// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfseDuplicata {
  String id;
  String numero;
  DateTime vencimento;
  String valor;

  NfseDuplicata({
    required this.id,
    required this.numero,
    required this.vencimento,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero': numero,
      'vencimento': vencimento.millisecondsSinceEpoch,
      'valor': valor,
    };
  }

  factory NfseDuplicata.fromMap(Map<String, dynamic> map) {
    return NfseDuplicata(
      id: map['id'] as String,
      numero: map['numero'] as String,
      vencimento: DateTime.fromMillisecondsSinceEpoch(map['vencimento'] as int),
      valor: map['valor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfseDuplicata.fromJson(String source) => NfseDuplicata.fromMap(json.decode(source) as Map<String, dynamic>);
}
