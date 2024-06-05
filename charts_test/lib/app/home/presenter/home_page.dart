import 'package:charts_test/app/home/models/nfse.dart';
import 'package:charts_test/app/home/presenter/components/pie_chart_component.dart';
import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomeRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> fornecedores = {};

  @override
  void initState() {
    super.initState();

    for (Nfse nfse in widget.repository.nfses) {
      fornecedores[nfse.nomeEmitente] =
          (fornecedores[nfse.nomeEmitente] ?? 0) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final int nfsesTotalItems = widget.repository.nfses.length;
    final List<MapEntry> sortedFornecedores = fornecedores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("DASHBOARD Notas Fiscais"),
        toolbarHeight: screenSize.height * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: PieChartComponent(
                title: "Notas fiscais por fornecedores",
                items: fornecedores,
                totalItems: nfsesTotalItems,
                sortedItems: sortedFornecedores,
              ),
            ),
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
      ),
    );
  }
}
