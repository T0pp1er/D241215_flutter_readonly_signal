import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_flutter/src/core/readonly.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _CountState _count = _CountState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Column(children: [
        MyText(countSignal: _count.readonlySignal),
        MyButton(countSignal: _count.signal)
      ]))
    );
  }
}

class _CountState {
  final FlutterSignal<int> _count = FlutterSignal<int>(0);

  FlutterSignal<int>         get signal         { return _count; }
  FlutterReadonlySignal<int> get readonlySignal { return _count; }
}

class MyText extends StatelessWidget{
  const MyText({super.key, required this.countSignal});

  final FlutterReadonlySignal<int> countSignal;

  @override
  Widget build(BuildContext context) {
    return Column( children: [
        Watch((context) => Text("${countSignal.value}")),
        TextButton(onPressed: (){ /* countSignal.value += 1; */  }, child: Text("+1"))
      ],
    );
  }
}

class MyButton extends StatelessWidget{
  const MyButton({super.key, required this.countSignal});

  final FlutterSignal<int> countSignal;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){ countSignal.value += 2; }, child: Text("+2"));
  }
}

