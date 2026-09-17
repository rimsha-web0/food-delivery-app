import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/main.dart';

void main() {
  testWidgets('App loads without crash', (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    await tester.pump(); // render frame

    // just check app starts
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}