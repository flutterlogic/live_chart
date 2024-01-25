import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class StockMarketChart extends StatefulWidget {
  const StockMarketChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StockMarketChartState createState() => _StockMarketChartState();
}

class _StockMarketChartState extends State<StockMarketChart> {
  List<ChartData> chartData = [];

  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      fetchData();
    });
  }

  void fetchData() {
    // Replace this with your logic to fetch data dynamically
    // For demonstration, generate random data
    setState(() {
      chartData.add(ChartData(DateTime.now(), getRandomValue(), getRandomValue(), getRandomValue(), getRandomValue()));
    });
  }

  double getRandomValue() {
    // Helper function to generate random values
    return Random().nextDouble() * 100; // You can adjust the range as needed
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Chart'),
      ),
      body: Center(
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
          ),

          series: <CartesianSeries>[
            CandleSeries<ChartData, double>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) =>
                  data.date.millisecondsSinceEpoch.toDouble(),
              lowValueMapper: (ChartData data, _) => data.low,
              highValueMapper: (ChartData data, _) => data.high,
              openValueMapper: (ChartData data, _) => data.open,
              closeValueMapper: (ChartData data, _) => data.close,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.date, this.open, this.high, this.low, this.close);

  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
}
