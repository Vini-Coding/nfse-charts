import 'package:charts_test/app/home/models/nfse.dart';
import 'package:charts_test/app/home/presenter/components/pie_chart_component.dart';
import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

import 'components/line_chart_component.dart';
import 'components/simple_bar_chart_component.dart';

class HomePage extends StatefulWidget {
  final HomeRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, int> fornecedores = {};
  final Map<String, int> situacoes = {};
  final Map<String, double> totalPorEmitente = {};

  @override
  void initState() {
    super.initState();

    for (Nfse nfse in widget.repository.nfses) {
      //PIE CHARTS
      fornecedores[nfse.nomeEmitente] =
          (fornecedores[nfse.nomeEmitente] ?? 0) + 1;
      situacoes[nfse.situacao] = (situacoes[nfse.situacao] ?? 0) + 1;

      // BAR CHARTS
      totalPorEmitente[nfse.nomeEmitente] =
          (totalPorEmitente[nfse.nomeEmitente] ?? 0) + nfse.total;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final int nfsesTotalItems = widget.repository.nfses.length;

    final List<MapEntry> sortedFornecedores = fornecedores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final List<MapEntry> sortedSituacoes = situacoes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));



    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("DASHBOARD Notas Fiscais"),
        toolbarHeight: screenSize.height * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: PieChartComponent(
                      title: "Situação das notas fiscais",
                      items: situacoes,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedSituacoes,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.02),
                  Expanded(
                    child: PieChartComponent(
                      title: "Notas fiscais por fornecedores",
                      items: fornecedores,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedFornecedores,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              SimpleBarChartComponent(
                title: "Total por emitentes",
                totalPorEmitente: totalPorEmitente,
              ),
              SizedBox(height: screenSize.height * 0.02),
              LineChartComponent(
                title: "Total ao longo do tempo",
                nfses: widget.repository.nfses,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
