import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartComponent extends StatelessWidget {
  final String title;
  final Map<String, int> items;
  final int totalItems;
  final List<MapEntry> sortedItems;
  const PieChartComponent({
    super.key,
    required this.title,
    required this.items,
    required this.totalItems,
    required this.sortedItems,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final List<PieChartSectionData> pieSections = items.entries.map((entry) {
      final percentage = (entry.value / totalItems) * 100;

      return PieChartSectionData(
        color: Colors.primaries[
            items.keys.toList().indexOf(entry.key) % Colors.primaries.length],
        value: entry.value.toDouble(),
        title: "${percentage.round()}%",
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        Container(
          height: screenSize.height * 0.5,
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
          margin: const EdgeInsets.fromLTRB(6, 8, 6, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: PieChart(
                  PieChartData(
                    sections: pieSections,
                    centerSpaceRadius: 30,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear, //
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: sortedItems.map((entry) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.primaries[
                              items.keys.toList().indexOf(entry.key) %
                                  Colors.primaries.length],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${entry.key.toString().toUpperCase()} (${entry.value})'),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
