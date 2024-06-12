// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfseDuplicata {
  final String id;
  final String numero;
  final DateTime vencimento;
  final String valor;

  NfseDuplicata({
    required this.id,
    required this.numero,
    required this.vencimento,
    required this.valor,
  });

  NfseDuplicata copyWith({
    String? id,
    String? numero,
    DateTime? vencimento,
    String? valor,
  }) {
    return NfseDuplicata(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      vencimento: vencimento ?? this.vencimento,
      valor: valor ?? this.valor,
    );
  }

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
      vencimento: DateTime.tryParse(map['vencimento']) ?? DateTime(0000, 00, 00),
      valor: map['valor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfseDuplicata.fromJson(String source) => NfseDuplicata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NfseDuplicata(id: $id, numero: $numero, vencimento: $vencimento, valor: $valor)';
  }

  @override
  bool operator ==(covariant NfseDuplicata other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.numero == numero &&
      other.vencimento == vencimento &&
      other.valor == valor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      numero.hashCode ^
      vencimento.hashCode ^
      valor.hashCode;
  }
}
