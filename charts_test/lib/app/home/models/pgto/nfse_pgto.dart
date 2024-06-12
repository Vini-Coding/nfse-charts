// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfsePgto {
  final String id;
  final String formaPgto;
  final String valorPgto;

  NfsePgto({
    required this.id,
    required this.formaPgto,
    required this.valorPgto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'forma_pgto': formaPgto,
      'valor_pgto': valorPgto,
    };
  }

  factory NfsePgto.fromMap(Map<String, dynamic> map) {
    return NfsePgto(
      id: map['id'] as String,
      formaPgto: map['forma_pgto'] as String,
      valorPgto: map['valor_pgto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfsePgto.fromJson(String source) => NfsePgto.fromMap(json.decode(source) as Map<String, dynamic>);
}
