// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Endereco {
  final String logradouro;
  final String numero;
  final String bairro;
  final String codigoMunicipio;
  final String municipio;
  final String estado;
  final String cep;

  Endereco({
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.codigoMunicipio,
    required this.municipio,
    required this.estado,
    required this.cep,
  });

  Endereco copyWith({
    String? logradouro,
    String? numero,
    String? bairro,
    String? codigoMunicipio,
    String? municipio,
    String? estado,
    String? cep,
  }) {
    return Endereco(
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      codigoMunicipio: codigoMunicipio ?? this.codigoMunicipio,
      municipio: municipio ?? this.municipio,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'codigoMunicipio': codigoMunicipio,
      'municipio': municipio,
      'estado': estado,
      'cep': cep,
    };
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      bairro: map['bairro'] as String,
      codigoMunicipio: map['codigo_municipio'] as String,
      municipio: map['municipio'] as String,
      estado: map['estado'] as String,
      cep: map['cep'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Endereco.fromJson(String source) => Endereco.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Endereco(logradouro: $logradouro, numero: $numero, bairro: $bairro, codigoMunicipio: $codigoMunicipio, municipio: $municipio, estado: $estado, cep: $cep)';
  }

  @override
  bool operator ==(covariant Endereco other) {
    if (identical(this, other)) return true;
  
    return 
      other.logradouro == logradouro &&
      other.numero == numero &&
      other.bairro == bairro &&
      other.codigoMunicipio == codigoMunicipio &&
      other.municipio == municipio &&
      other.estado == estado &&
      other.cep == cep;
  }

  @override
  int get hashCode {
    return logradouro.hashCode ^
      numero.hashCode ^
      bairro.hashCode ^
      codigoMunicipio.hashCode ^
      municipio.hashCode ^
      estado.hashCode ^
      cep.hashCode;
  }
}
