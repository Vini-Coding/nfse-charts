import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SimpleBarChartComponent extends StatelessWidget {
  final String title;
  final Map<String, double> totalPorEmitente;
  const SimpleBarChartComponent({
    super.key,
    required this.title,
    required this.totalPorEmitente,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final List<BarChartGroupData> barGroups = [];
    int index = 0;

    totalPorEmitente.forEach((emitente, total) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: total,
              color: Colors.blue,
            ),
          ],
        ),
      );
      index++;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < totalPorEmitente.length) {
                        final emitente = totalPorEmitente.keys.elementAt(index);
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            emitente,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
            swapAnimationDuration: const Duration(
              milliseconds: 150,
            ),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ],
    );
  }
}
