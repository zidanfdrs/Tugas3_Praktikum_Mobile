import 'package:flutter/material.dart';
import 'package:tugas2/zadon.dart';

void main() {
  runApp(const ZadonApp());
}

class ZadonApp extends StatelessWidget {
  const ZadonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 2 Zadon',
      home: const Bmi(),
      debugShowCheckedModeBanner: false,
    );
  }
}
