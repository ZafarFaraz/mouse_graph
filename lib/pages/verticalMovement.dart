import 'dart:async';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../graphData.dart';

class VerticalMovementPage extends StatefulWidget {
  @override
  _VerticalMovementPageState createState() => _VerticalMovementPageState();
}

class _VerticalMovementPageState extends State<VerticalMovementPage> {
  bool isRunning = false;
  List<GraphData> movementData = [];

  double startTime = 0.0;

  Timer? _timer;
  double lastMouseYPosition = 0.0; // Holds the last known Y position

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
                    spots: movementData
                        .map((data) => FlSpot(data.time, data.value))
                        .toList(),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 100, // Adjust as needed for your data
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toStringAsFixed(0),
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
                    interval: 1, // Adjust as needed for your data
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
            ),
          ),
        ),
      ),
      floatingActionButton: floatingButtons(),
    );
  }

  void handleMouseMovement(double positionY) {
    lastMouseYPosition = 300 - positionY;
  }

  void updateMovementData() {
    final currentTime =
        DateTime.now().millisecondsSinceEpoch.toDouble() - startTime;
    setState(() {
      movementData.add(GraphData(currentTime / 1000, lastMouseYPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        if (isRunning && event.kind == PointerDeviceKind.mouse) {
          handleMouseMovement(event.position.dy);
        }
      },
      child: graphContainer(),
    );
  }

  void startTracking() {
    setState(() {
      isRunning = true;
      startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
      movementData.clear();
      lastMouseYPosition = 0.0;
    });

    // Start the timer to update the graph every 100 milliseconds
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (isRunning) {
        updateMovementData();
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
      movementData.clear();
      lastMouseYPosition = 0.0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
