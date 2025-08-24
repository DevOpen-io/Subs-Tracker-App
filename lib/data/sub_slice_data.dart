import 'package:flutter/material.dart';
import '../models/sub_slice.dart';

List<SubSlice> kDemoSlices = [
  SubSlice(name: 'Netflix', amount: 99, color: Colors.red.toARGB32(), startDate: DateTime.now()),
  SubSlice(name: 'Spotify', amount: 39, color: Colors.green.toARGB32(), startDate: DateTime.now()),
  SubSlice(name: 'YouTube', amount: 57, color: Colors.blue.toARGB32(), startDate: DateTime.now()),
  SubSlice(name: 'iCloud', amount: 26, color: Colors.lightBlueAccent.toARGB32(), startDate: DateTime.now()),
];
