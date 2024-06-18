import 'package:charts_test/app/core/utils/generate_colors_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartComponent extends StatefulWidget {
  final String title;
  final Map<String, int> items;
  final int totalItems;
  final List<MapEntry> sortedItems;
  final bool showTitle;
  const PieChartComponent({
    super.key,
    required this.title,
    required this.items,
    required this.totalItems,
    required this.sortedItems,
    this.showTitle = true,
  });

  @override
  State<PieChartComponent> createState() => _PieChartComponentState();
}

class _PieChartComponentState extends State<PieChartComponent> {
  int _touchedIndex = -1;

  int indexOfKey(String key, List<String> keys) {
    return keys.indexOf(key);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List<String> keys = widget.items.keys.toList();
    final List<Color> customColors = generateColors(
      const Color.fromARGB(255, 0, 164, 107),
      keys.length,
    );

    final List<PieChartSectionData> pieSections = widget.totalItems != 0
        ? widget.items.entries.map((entry) {
            final percentage = (entry.value / widget.totalItems) * 100;
            final int index = indexOfKey(entry.key, keys);

            return PieChartSectionData(
              color: customColors[index % Colors.primaries.length],
              value: entry.value.toDouble(),
              title: "${percentage.round()}%",
              showTitle: widget.showTitle,
              radius: _touchedIndex == index ? 110 : 100,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList()
        : [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: "Nunito",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF151515),
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        Container(
          height: screenSize.height * 0.5,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Visibility(
            visible: widget.totalItems != 0,
            replacement: const Center(
              child: Text(
                "Sem gráficos para esse período",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00935F),
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: PieChart(
                    PieChartData(
                      sections: pieSections,
                      centerSpaceRadius: 20,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                      pieTouchData: PieTouchData(
                        enabled: true,
                        touchCallback: (touchEvent, touchResponse) {
                          if (touchResponse != null &&
                              touchResponse.touchedSection != null) {
                            setState(() {
                              _touchedIndex = touchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          }
                        },
                      ),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 1000),
                    swapAnimationCurve: Curves.easeOutBack,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: widget.sortedItems.map((entry) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: customColors[
                                widget.items.keys.toList().indexOf(entry.key) %
                                    customColors.length],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${entry.key.toString().toUpperCase()} (${entry.value})',
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 12,
                            fontWeight: _touchedIndex ==
                                    widget.items.keys
                                        .toList()
                                        .indexOf(entry.key)
                                ? FontWeight.w900
                                : FontWeight.w600,
                            color: _touchedIndex ==
                                    widget.items.keys
                                        .toList()
                                        .indexOf(entry.key)
                                ? customColors[widget.items.keys
                                        .toList()
                                        .indexOf(entry.key) %
                                    customColors.length]
                                : const Color(0xFF151515),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
