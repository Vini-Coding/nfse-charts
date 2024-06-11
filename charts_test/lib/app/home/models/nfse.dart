// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/item/nfse_item.dart';
import 'package:charts_test/app/home/models/nfse_duplicata.dart';
import 'package:charts_test/app/home/models/nfse_pgto.dart';

class Nfse {
  String id;
  String tipo;
  int numeroNfe;
  int serieNfe;
  DateTime data;
  DateTime? dataEntrada;
  String chaveAcessoNfe;
  dynamic xml;
  double totalNf;
  bool nfeCompleta;
  String nomeEmitente;
  int versao;
  String situacao;
  bool nfeImportada;
  String status;
  int pessoaId;
  int centroCustoId;
  List<NfseItem> itens;
  List<NfseDuplicata> duplicatas;
  List<NfsePgto> pagamentos;

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
    required this.pagamentos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'numeroNfe': numeroNfe,
      'serieNfe': serieNfe,
      'data': data.millisecondsSinceEpoch,
      'dataEntrada': dataEntrada?.millisecondsSinceEpoch,
      'chaveAcessoNfe': chaveAcessoNfe,
      'xml': xml,
      'totalNf': totalNf,
      'nfeCompleta': nfeCompleta,
      'nomeEmitente': nomeEmitente,
      'versao': versao,
      'situacao': situacao,
      'nfeImportada': nfeImportada,
      'status': status,
      'pessoaId': pessoaId,
      'centroCustoId': centroCustoId,
      'itens': itens.map((x) => x.toMap()).toList(),
      'duplicatas': duplicatas.map((x) => x.toMap()).toList(),
      'pagamentos': pagamentos.map((x) => x.toMap()).toList(),
    };
  }

  factory Nfse.fromMap(Map<String, dynamic> map) {
    return Nfse(
      id: map['id'] as String,
      tipo: map['tipo'] as String,
      numeroNfe: map['numeroNfe'] as int,
      serieNfe: map['serieNfe'] as int,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
      dataEntrada: map['dataEntrada'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dataEntrada'] as int) : null,
      chaveAcessoNfe: map['chaveAcessoNfe'] as String,
      xml: map['xml'] as dynamic,
      totalNf: map['totalNf'] as double,
      nfeCompleta: map['nfeCompleta'] as bool,
      nomeEmitente: map['nomeEmitente'] as String,
      versao: map['versao'] as int,
      situacao: map['situacao'] as String,
      nfeImportada: map['nfeImportada'] as bool,
      status: map['status'] as String,
      pessoaId: map['pessoaId'] as int,
      centroCustoId: map['centroCustoId'] as int,
      itens: List<NfseItem>.from((map['itens'] as List<int>).map<NfseItem>((x) => NfseItem.fromMap(x as Map<String,dynamic>),),),
      duplicatas: List<NfseDuplicata>.from((map['duplicatas'] as List<int>).map<NfseDuplicata>((x) => NfseDuplicata.fromMap(x as Map<String,dynamic>),),),
      pagamentos: List<NfsePgto>.from((map['pagamentos'] as List<int>).map<NfsePgto>((x) => NfsePgto.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Nfse.fromJson(String source) => Nfse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Nfse(id: $id, tipo: $tipo, numeroNfe: $numeroNfe, serieNfe: $serieNfe, data: $data, dataEntrada: $dataEntrada, chaveAcessoNfe: $chaveAcessoNfe, xml: $xml, totalNf: $totalNf, nfeCompleta: $nfeCompleta, nomeEmitente: $nomeEmitente, versao: $versao, situacao: $situacao, nfeImportada: $nfeImportada, status: $status, pessoaId: $pessoaId, centroCustoId: $centroCustoId, itens: $itens, duplicatas: $duplicatas, pagamentos: $pagamentos)';
  }
}
