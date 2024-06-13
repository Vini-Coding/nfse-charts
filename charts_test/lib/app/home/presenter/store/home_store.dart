import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/nfse.dart';

class HomeStore extends ChangeNotifier {
  final HomeRepository repository;

  HomeStore({required this.repository});

  late final List<Nfse> nfses;
  late List<Nfse> filteredNfses;
  final Map<String, int> fornecedores = {};
  final Map<String, int> situacoes = {};
  final Map<String, int> centrosCusto = {};
  final Map<String, int> status = {};
  final Map<String, double> totalPorEmitente = {};
  late List<MapEntry> sortedFornecedores;
  late List<MapEntry> sortedSituacoes;
  late List<MapEntry> sortedCentroCusto;
  late List<MapEntry> sortedStatus;
  double totalGasto = 0;
  List<String> dates = [];
  String currentCentroCusto = "TODOS";
  List<String> centrosCustoSelection = ["TODOS"];
  String currentPeriodoSelection = "";
  List<String> periodoSelection = [
    "Hoje",
    "Ontem",
    "Nos últimos 7 dias",
    "No último mês",
    "Personalizado",
  ];

  void init() {
    Map<String, dynamic> jsonData = repository.getData();
    Nfses nfsesData = Nfses.fromMap(jsonData);

    nfses = nfsesData.nfsesList;
    filteredNfses = nfses;

    updateChartsMaps();
    sortLists();
    updateTotalGasto();
    currentPeriodoSelection = "até ${dates.last}";
  }

  void updateTotalGasto() {
    totalGasto = 0;
    for (var nfse in filteredNfses) {
      totalGasto = totalGasto + nfse.totalNf;
    }
  }

  void updateChartsMaps() {
    for (Nfse nfse in filteredNfses) {
      //PIE CHARTS
      fornecedores[nfse.nomeEmitente] =
          (fornecedores[nfse.nomeEmitente] ?? 0) + 1;
      situacoes[nfse.situacao] = (situacoes[nfse.situacao] ?? 0) + 1;
      centrosCusto[nfse.centroCustoId.fantasia] =
          (centrosCusto[nfse.centroCustoId.fantasia] ?? 0) + 1;
      status[nfse.status] = (status[nfse.status] ?? 0) + 1;

      // BAR CHARTS
      totalPorEmitente[nfse.nomeEmitente] =
          (totalPorEmitente[nfse.nomeEmitente] ?? 0) + nfse.totalNf;
    }
  }

  void sortLists() {
    sortedFornecedores = fornecedores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedSituacoes = situacoes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedCentroCusto = centrosCusto.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedStatus = status.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    centrosCustoSelection = centrosCusto.entries.map((centroCusto) {
      return centroCusto.key;
    }).toList()
      ..add("TODOS");

    for (var nfse in nfses) {
      final formattedDate = DateFormat('dd/MM/yy').format(nfse.data);
      if (!dates.contains(formattedDate)) {
        dates.add(formattedDate);
      }
    }
  }

  void clearLists() {
    fornecedores.clear();
    situacoes.clear();
    status.clear();
    totalPorEmitente.clear();
    sortedFornecedores.clear();
    sortedSituacoes.clear();
    sortedCentroCusto.clear();
    sortedStatus.clear();
    dates.clear();
  }

  void filtrarPorCentroDeCusto(String centroCusto) {
    if (centroCusto == "TODOS") {
      currentCentroCusto = centroCusto;
      filteredNfses = nfses;
      clearLists();
      centrosCusto.clear();
      updateChartsMaps();
      sortLists();
      updateTotalGasto();
    } else {
      currentCentroCusto = centroCusto;
      clearLists();
      filteredNfses = nfses.where((nfse) {
        return nfse.centroCustoId.fantasia == centroCusto;
      }).toList();
      updateChartsMaps();
      sortLists();
      updateTotalGasto();
    }
    notifyListeners();
  }

  void filtrarPorData({
    required DateTime dataInicio,
    required DateTime dataFinal,
  }) {
    try {
      filteredNfses = nfses.where((nfse) {
        return nfse.data.isAfter(dataInicio) && nfse.data.isBefore(dataFinal);
      }).toList();
    } catch (e) {
      throw Exception("Erro em filtrar por data: ${e.toString()}");
    }

    notifyListeners();
  }
}
