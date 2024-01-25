import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

double yValue = 0;
double horizontalLineY = 0;
double horizontalLineX = 0;
bool showHorizontalLine = false;

class LiveLineChart extends StatefulWidget {
  const LiveLineChart({super.key});
  @override
  State<LiveLineChart> createState() => _LiveLineChartState();
}

class _LiveLineChartState extends State<LiveLineChart> {
  _LiveLineChartState() {
    timer = Timer.periodic(const Duration(seconds: 1), _updateDataSource);
  }

  @override
  void dispose() {
    timer?.cancel();
    chartData!.clear();
    _chartSeriesController.clear();
    super.dispose();
  }

  @override
  void initState() {
    count = 19;
    chartData = <ChartData>[
      ChartData(0, 0),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildLiveLineChart(),
    );
  }

  SfCartesianChart _buildLiveLineChart() {
    List<LineSeries<ChartData, int>> seriesList = [
      LineSeries<ChartData, int>(
        onRendererCreated: (ChartSeriesController<ChartData, int> controller) {
          _chartSeriesController.add(controller);
        },
        dataSource: chartData,
        color: Colors.white,
        xValueMapper: (ChartData sales, _) => sales.country,
        yValueMapper: (ChartData sales, _) => sales.sales,
        animationDuration: 0,
      ),
    ];
    return SfCartesianChart(
      backgroundColor: Colors.black,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0, color: Colors.pink),
        maximum: chartData!.length.toDouble() + 100,
        axisLine: const AxisLine(width: 0),
        borderColor: Colors.orange,
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
      ),
      primaryYAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        opposedPosition: true,
        interval: 5,
        plotBands: [
          PlotBand(
            start: chartData!.last.sales,
            end: chartData!.last.sales,
            borderColor: Colors.indigo,
            borderWidth: 1,
            color: Colors.transparent,
            associatedAxisStart: 1,
          ),
        ],
        axisLine: const AxisLine(width: 0),
        majorGridLines:
            MajorGridLines(width: 2, color: Colors.white.withOpacity(0.2)),
      ),
      series: seriesList,
    );
  }

  void _updateDataSource(Timer timer) {
    if (isCardView != null || !showHorizontalLine) {
      chartData!.add(ChartData(count, _getRandomInt(0, 5)));

      if (_chartSeriesController.isEmpty) {
        return;
      }

      _chartSeriesController.first.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
      );

      double newX = chartData!.last.country.toDouble();
      double newY = chartData!.last.sales.toDouble();

      setState(() {
        horizontalLineY = newY;
        horizontalLineX = newX;
      });

      count = count + 1;
    }
  }

  int _getRandomInt(int min, int max) {
    final math.Random random = math.Random();
    return min + random.nextInt(max - min);
  }
}

class ChartData {
  ChartData(this.country, this.sales);

  final int country;
  final num sales;
}

Timer? timer;
List<ChartData>? chartData;
List<List<ChartData>> lineDataList = [];
late int count;
List<ChartSeriesController<ChartData, int>> _chartSeriesController = [];
bool isCardView = true;
var lineTimers = <Timer>[];
num? a;
int xValue = 0;
