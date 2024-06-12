// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/centro_custo/nfse_centro_custo.dart';
import 'package:charts_test/app/home/models/duplicata/nfse_duplicata.dart';
import 'package:charts_test/app/home/models/item/nfse_item.dart';
import 'package:charts_test/app/home/models/pessoa/nfse_pessoa.dart';
import 'package:charts_test/app/home/models/pgto/nfse_pgto.dart';

class Nfses {
  final List<Nfse> nfsesList;

  Nfses({
    required this.nfsesList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': nfsesList.map((x) => x.toMap()).toList(),
    };
  }

  factory Nfses.fromMap(Map<String, dynamic> map) {
    return Nfses(
      nfsesList: List<Nfse>.from(
        (map['data'] as List<Map<String, Object?>>).map<Nfse>(
          (x) => Nfse.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nfses.fromJson(String source) =>
      Nfses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Nfses(data: $nfsesList)';
}

class Nfse {
  final String id;
  final String tipo;
  final int numeroNfe;
  final int serieNfe;
  final DateTime data;
  final DateTime? dataEntrada;
  final String chaveAcessoNfe;
  final dynamic xml;
  final double totalNf;
  final bool nfeCompleta;
  final String nomeEmitente;
  final int versao;
  final String situacao;
  final bool nfeImportada;
  final String status;
  final NfsePessoaId pessoaId;
  final NfseCentroCustoId centroCustoId;
  final List<NfseItem> itens;
  final List<NfseDuplicata> duplicatas;
  final List<NfsePgto> pgtos;

  Nfse({
    required this.id,
    required this.tipo,
    required this.numeroNfe,
    required this.serieNfe,
    required this.data,
    required this.dataEntrada,
    required this.chaveAcessoNfe,
    required this.xml,
    required this.totalNf,
    required this.nfeCompleta,
    required this.nomeEmitente,
    required this.versao,
    required this.situacao,
    required this.nfeImportada,
    required this.status,
    required this.pessoaId,
    required this.centroCustoId,
    required this.itens,
    required this.duplicatas,
    required this.pgtos,
  });

  Nfse copyWith({
    String? id,
    String? tipo,
    int? numeroNfe,
    int? serieNfe,
    DateTime? data,
    DateTime? dataEntrada,
    String? chaveAcessoNfe,
    dynamic xml,
    double? totalNf,
    bool? nfeCompleta,
    String? nomeEmitente,
    int? versao,
    String? situacao,
    bool? nfeImportada,
    String? status,
    NfsePessoaId? pessoaId,
    NfseCentroCustoId? centroCustoId,
    List<NfseItem>? itens,
    List<NfseDuplicata>? duplicatas,
    List<NfsePgto>? pgtos,
  }) {
    return Nfse(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      numeroNfe: numeroNfe ?? this.numeroNfe,
      serieNfe: serieNfe ?? this.serieNfe,
      data: data ?? this.data,
      dataEntrada: dataEntrada ?? this.dataEntrada,
      chaveAcessoNfe: chaveAcessoNfe ?? this.chaveAcessoNfe,
      xml: xml ?? this.xml,
      totalNf: totalNf ?? this.totalNf,
      nfeCompleta: nfeCompleta ?? this.nfeCompleta,
      nomeEmitente: nomeEmitente ?? this.nomeEmitente,
      versao: versao ?? this.versao,
      situacao: situacao ?? this.situacao,
      nfeImportada: nfeImportada ?? this.nfeImportada,
      status: status ?? this.status,
      pessoaId: pessoaId ?? this.pessoaId,
      centroCustoId: centroCustoId ?? this.centroCustoId,
      itens: itens ?? this.itens,
      duplicatas: duplicatas ?? this.duplicatas,
      pgtos: pgtos ?? this.pgtos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'numero_nfe': numeroNfe,
      'serie_nfe': serieNfe,
      'data': data.millisecondsSinceEpoch,
      'data_entrada': dataEntrada?.millisecondsSinceEpoch,
      'chave_acesso_nfe': chaveAcessoNfe,
      'xml': xml,
      'total_nf': totalNf,
      'nfe_completa': nfeCompleta,
      'nome_emitente': nomeEmitente,
      'versao': versao,
      'situacao': situacao,
      'nfe_importada': nfeImportada,
      'status': status,
      'pessoa_id': pessoaId.toMap(),
      'centro_custo_id': centroCustoId.toMap(),
      'itens': itens.map((x) => x.toMap()).toList(),
      'duplicatas': duplicatas.map((x) => x.toMap()).toList(),
      'pgtos': pgtos.map((x) => x.toMap()).toList(),
    };
  }

  factory Nfse.fromMap(Map<String, dynamic> map) {
    return Nfse(
      id: map['id'] as String,
      tipo: map['tipo'] as String,
      numeroNfe: map['numero_nfe'] ?? 0,
      serieNfe: map['serie_nfe'] ?? 0,
      data: DateTime.tryParse(map['data']) ?? DateTime(0000, 00, 00),
      dataEntrada: map['data_entrada'] != null
          ? DateTime.tryParse(map['data_entrada'])
          : null,
      chaveAcessoNfe: map['chave_acesso_nfe'] as String,
      xml: map['xml'] as dynamic,
      totalNf: double.tryParse(map['total_nf']) ?? 0,
      nfeCompleta: map['nfe_completa'] as bool,
      nomeEmitente: map['nome_emitente'] as String,
      versao: map['versao'] as int,
      situacao: map['situacao'] as String,
      nfeImportada: map['nfe_importada'] as bool,
      status: map['status'] as String,
      pessoaId: NfsePessoaId.fromMap(map['pessoa_id'] as Map<String, dynamic>),
      centroCustoId: NfseCentroCustoId.fromMap(
          map['centro_custo_id'] as Map<String, dynamic>),
      itens: List<NfseItem>.from(
        (List<Map<String, dynamic>>.from(map['itens'])).map<NfseItem>(
          (x) => NfseItem.fromMap(x),
        ),
      ),
      duplicatas: List<NfseDuplicata>.from(
        (List<Map<String, dynamic>>.from(map['duplicatas'])).map<NfseDuplicata>(
          (x) => NfseDuplicata.fromMap(x),
        ),
      ),
      pgtos: List<NfsePgto>.from(
        (List<Map<String, dynamic>>.from(map['pgtos'])).map<NfsePgto>(
          (x) => NfsePgto.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nfse.fromJson(String source) =>
      Nfse.fromMap(json.decode(source) as Map<String, dynamic>);
}
