import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarChartExample extends StatefulWidget {
  const BarChartExample({super.key});

  @override
  State<BarChartExample> createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  final List<DataModel> _list = [
    DataModel(key: "01", value: "25"),
    DataModel(key: "02", value: "10"),
    DataModel(key: "03", value: "26"),
    DataModel(key: "04", value: "9"),
    DataModel(key: "05", value: "20"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040F2F),
      appBar: AppBar(
        title: const Text('Bar Chart Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLegendItem(Colors.greenAccent, 'Active'),
                const SizedBox(width: 10),
                _buildLegendItem(Colors.redAccent, 'InActive'),
              ],
            ),
          ),
          // Bar Chart
          Container(
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BarChart(
              BarChartData(
                maxY: 30,
                alignment: BarChartAlignment.spaceEvenly,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                  tooltipRoundedRadius: 8,
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String weekDay = _list[group.x.toInt()].key!;
                    return BarTooltipItem(
                      '$weekDay\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: rod.toY.toString(),
                            style: TextStyle(
                              color: rod.gradient?.colors.first ?? rod.color,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    );
                  },
                )),
                barGroups: _chartGroups(),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                gridData: const FlGridData(
                  drawHorizontalLine: false,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _list[value.toInt()].key!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chart Groups
  List<BarChartGroupData> _chartGroups() {
    return List.generate(_list.length, (index) {
      final active = double.parse(_list[index].value!);
      final inActive = 30 - active;
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
          toY: active,
          width: 18,
          gradient: const LinearGradient(
            colors: [Colors.greenAccent, Colors.blueAccent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        BarChartRodData(
          toY: inActive,
          width: 18,
          gradient: const LinearGradient(
            colors: [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ]);
    });
  }
}

// making custem text

Widget _buildLegendItem(Color color, String text) {
  return Row(
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      )
    ],
  );
}

// Create a Model
class DataModel {
  final String? key;
  final String? value;
  DataModel({this.key, this.value});
}
