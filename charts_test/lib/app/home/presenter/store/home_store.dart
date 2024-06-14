import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/nfse.dart';

class HomeStore extends ChangeNotifier {
  final HomeRepository repository;

  HomeStore({required this.repository});

  late final List<Nfse> nfses;
  late List<Nfse> filteredNfses;
  Map<String, int> fornecedores = {};
  Map<String, int> situacoes = {};
  Map<String, int> centrosCusto = {};
  Map<String, int> status = {};
  Map<String, double> totalPorEmitente = {};
  late List<MapEntry> sortedFornecedores;
  late List<MapEntry> sortedSituacoes;
  late List<MapEntry> sortedCentroCusto;
  late List<MapEntry> sortedStatus;
  double totalGasto = 0;
  List<DateTime> dates = [];
  String currentCentroCusto = "TODOS";
  List<String> centrosCustoSelection = ["TODOS"];
  String currentPeriodoSelection = "";
  List<String> periodoSelection = [
    "Hoje",
    "Ontem",
    "Nos últimos 7 dias",
    "Nos últimos 30 dias",
    "Personalizado",
  ];

  void init() {
    Map<String, dynamic> jsonData = repository.getData();
    Nfses nfsesData = Nfses.fromMap(jsonData);

    nfses = nfsesData.nfsesList;
    filteredNfses = nfses;

    updateChartsMaps();
    updateAndSortLists();
    updateTotalGasto();
    updateCurrentPeriodo();
  }

  void updateCurrentPeriodo() {
    currentPeriodoSelection =
        "até ${DateFormat('dd/MM/yyyy').format(dates.last)}";
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

  void updateAndSortLists() {
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

    for (var nfse in filteredNfses) {
      if (!dates.contains(nfse.data)) {
        dates.add(nfse.data);
      }
    }
    dates.sort((a, b) => a.compareTo(b));
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

  void update() {
    clearLists();
    updateChartsMaps();
    updateAndSortLists();
    updateTotalGasto();
  }

  void filtrarPorCentroDeCusto(String centroCusto) {
    if (centroCusto == "TODOS") {
      currentCentroCusto = centroCusto;
      filteredNfses = nfses;
      clearLists();
      centrosCusto.clear();
      updateChartsMaps();
      updateAndSortLists();
      updateTotalGasto();
      updateCurrentPeriodo();
    } else {
      currentCentroCusto = centroCusto;
      filteredNfses = nfses.where((nfse) {
        return nfse.centroCustoId.fantasia == centroCusto;
      }).toList();
      clearLists();
      updateChartsMaps();
      updateAndSortLists();
      updateTotalGasto();
      updateCurrentPeriodo();
    }
    notifyListeners();
  }

  void filtrarPorData({
    required String periodo,
    DateTime? dataInicio,
    DateTime? dataFinal,
  }) {
    // HOJE
    void filtrarPorHoje() {
      final now = DateTime.now();
      final dataInicio = DateTime(now.year, now.month, now.day, 0, 0, 0);
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      filteredNfses.clear();
      filteredNfses = nfses.where((nfse) {
        return nfse.data.isAfter(dataInicio) && nfse.data.isBefore(dataFinal);
      }).toList();
      currentPeriodoSelection = "Hoje";
      update();

      notifyListeners();
    }

    // ONTEM
    void filtrarPorOntem() {
      final now = DateTime.now();
      final ontem = now.subtract(const Duration(days: 1));
      final dataInicio = DateTime(ontem.year, ontem.month, ontem.day, 0, 0, 0);
      final dataFinal =
          DateTime(ontem.year, ontem.month, ontem.day, 23, 59, 59);

      filteredNfses.clear();
      filteredNfses = nfses.where((nfse) {
        return nfse.data.isAfter(dataInicio) && nfse.data.isBefore(dataFinal);
      }).toList();
      currentPeriodoSelection = "Ontem";

      notifyListeners();
    }

    //NOS ÚLTIMOS 7 DIAS
    void filtrarPorUmaSemana() {
      final now = DateTime.now();
      final dataInicio = now.subtract(const Duration(days: 7));
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      filteredNfses.clear();
      filteredNfses = nfses.where((nfse) {
        return nfse.data.isAfter(dataInicio) && nfse.data.isBefore(dataFinal);
      }).toList();
      currentPeriodoSelection = "Nos últimos 7 dias";

      notifyListeners();
    }

    //NOS ÚLTIMOS 30 DIAS
    void filtrarPorUmMes() {
      final now = DateTime.now();
      final dataInicio = DateTime(now.year, now.month - 1, now.day);
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      filteredNfses.clear();
      filteredNfses = nfses.where((nfse) {
        return nfse.data.isAfter(dataInicio) && nfse.data.isBefore(dataFinal);
      }).toList();
      currentPeriodoSelection = "Nos últimos 30 dias";

      notifyListeners();
    }

    void filtrarPersonalizado() {
      try {
        filteredNfses = nfses.where((nfse) {
          return nfse.data.isAfter(dataInicio!) &&
              nfse.data.isBefore(dataFinal!);
        }).toList();
        updateCurrentPeriodo();
      } catch (e) {
        throw Exception("Erro em filtrar por data: ${e.toString()}");
      }

      notifyListeners();
    }

    switch (periodo) {
      case "Hoje":
        filtrarPorHoje();
        break;
      case "Ontem":
        filtrarPorOntem();
        break;
      case "Nos últimos 7 dias":
        filtrarPorUmaSemana();
        break;
      case "Nos últimos 30 dias":
        filtrarPorUmMes();
        break;
      case "Personalizado":
        filtrarPersonalizado();
        break;
      default:
        throw Exception("Período de filtro não reconhecido: $periodo");
    }

    notifyListeners();
  }
}
