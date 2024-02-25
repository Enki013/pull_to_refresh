import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull To Refresh',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(background: const Color(0xFFC1ECF6)),
      ),
      home: const MyHomePage(title: 'Pull To Refresh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _offsetToArm = 220.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFfefdfe)),
        ),
      ),
      body: CustomRefreshIndicator(
        child: DummyList(),
        onRefresh: () => Future.delayed(const Duration(seconds: 1)),
        offsetToArmed: _offsetToArm,
        builder: (context, child, controller) => AnimatedBuilder(
          animation: controller,
          child: child,
          builder: (context, child) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: _offsetToArm * controller.value,
                  child: const RiveAnimation.asset(
                    "assets/3d_raster_test.riv",
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, _offsetToArm * controller.value),
                  child: controller.isLoading ? DummyList() : child,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DummyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      // Number of items in the list
      separatorBuilder: (context, index) => Divider(),
      // Separator between items
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFdbb7cb),
          ),
          height: 300,
          child: Center(child: Text('Item $index')),
        );
      },
    );
  }
}
