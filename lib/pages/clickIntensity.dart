import 'dart:async'; // Added for Timer
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mouse_graph/graphData.dart';

class ClickIntensityPage extends StatefulWidget {
  @override
  _ClickIntensityPageState createState() => _ClickIntensityPageState();
}

class _ClickIntensityPageState extends State<ClickIntensityPage> {
  bool isRunning = false;
  List<GraphData> clickData = [];

  double startTime = 0.0;

  Timer? _timer;
  double currentIntensity = 0.0; // Holds the current intensity value

  // Decay rate (adjust as needed)
  final double decayRate = 0.05;

  Widget floatingButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: startTracking,
          child: Icon(Icons.play_arrow),
          heroTag: 'start',
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: stopTracking,
          child: Icon(Icons.pause),
          heroTag: 'stop',
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: clearData,
          child: Icon(Icons.clear),
          heroTag: 'clear',
        )
      ],
    );
  }

  Widget graphContainer() {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(16),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: clickData
                      .map((data) => FlSpot(data.time, data.value))
                      .toList(),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 2,
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 0.2,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          '${value.toInt()}s',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
              minY: 0,
              maxY: 1.0,
            ),
          ),
        ),
      ),
      floatingActionButton: floatingButtons(),
    );
  }

  void handleClickEvent() {
    if (isRunning) {
      // On click, set intensity to maximum (1.0)
      currentIntensity = 1.0;
      final currentTime =
          DateTime.now().millisecondsSinceEpoch.toDouble() - startTime;
      setState(() {
        clickData.add(GraphData(currentTime / 1000, currentIntensity));
      });
    }
  }

  void updateIntensity() {
    if (currentIntensity > 0.0) {
      // Decay the intensity over time
      currentIntensity -= decayRate;
      if (currentIntensity < 0.0) currentIntensity = 0.0;

      final currentTime =
          DateTime.now().millisecondsSinceEpoch.toDouble() - startTime;
      setState(() {
        clickData.add(GraphData(currentTime / 1000, currentIntensity));
      });
    } else {
      // Optionally, add a data point to show zero intensity
      final currentTime =
          DateTime.now().millisecondsSinceEpoch.toDouble() - startTime;
      setState(() {
        clickData.add(GraphData(currentTime / 1000, 0.0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse &&
            event.buttons == kPrimaryMouseButton) {
          handleClickEvent();
        }
      },
      child: graphContainer(),
    );
  }

  void startTracking() {
    setState(() {
      isRunning = true;
      startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
      clickData.clear();
      currentIntensity = 0.0;
    });

    // Start the timer to update the graph every 100 milliseconds
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (isRunning) {
        updateIntensity();
      }
    });
  }

  void stopTracking() {
    setState(() {
      isRunning = false;
    });
    _timer?.cancel();
  }

  void clearData() {
    setState(() {
      clickData.clear();
      currentIntensity = 0.0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
