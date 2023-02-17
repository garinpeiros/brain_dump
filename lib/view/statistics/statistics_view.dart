import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatisticsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  double _counter = 100;
  Color c = HexColor("#FF8C00");
  String message = 'starting...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.all_inclusive,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "card_list".tr(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _gauge(),
    );
  }

  Widget _gauge() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          childAspectRatio: 1.2,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(top: 40),
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 1000,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 100,
                          color: HexColor("#0ebeff"),
                        ),
                        GaugeRange(
                          startValue: 100,
                          endValue: 200,
                          color: HexColor("#26b2f7"),
                        ),
                        GaugeRange(
                          startValue: 200,
                          endValue: 300,
                          color: HexColor("#3ea5f0"),
                        ),
                        GaugeRange(
                          startValue: 300,
                          endValue: 400,
                          color: HexColor("#5699e8"),
                        ),
                        GaugeRange(
                          startValue: 400,
                          endValue: 500,
                          color: HexColor("#6e8ce1"),
                        ),
                        GaugeRange(
                          startValue: 500,
                          endValue: 600,
                          color: HexColor("#8780d9"),
                        ),
                        GaugeRange(
                          startValue: 600,
                          endValue: 700,
                          color: HexColor("#b767ca"),
                        ),
                        GaugeRange(
                          startValue: 700,
                          endValue: 800,
                          color: HexColor("#cf5bc2"),
                        ),
                        GaugeRange(
                          startValue: 800,
                          endValue: 900,
                          color: HexColor("#e74ebb"),
                        ),
                        GaugeRange(
                          startValue: 900,
                          endValue: 1000,
                          color: HexColor("#ff42b3"),
                        ),
                      ],
                      axisLineStyle: const AxisLineStyle(thickness: 30),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: _counter,
                          width: 30,
                          color: c,
                          enableAnimation: true,
                          cornerStyle: CornerStyle.endCurve,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Text(
                              "${_counter.toInt()}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
