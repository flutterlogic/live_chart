import 'package:chart_demo/candle_chart/candle_live_chart.dart';
import 'package:chart_demo/flutter_live_chart/chart_flutter_demo.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const StockMarketChart());

                },
                child: const Text("Candle Live Chart")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const LiveLineChart());

                },
                child: const Text("Cartesian Live Chart"))
          ],
        ),
      ),
    );
  }
}
