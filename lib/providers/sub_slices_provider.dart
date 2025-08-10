import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/data/sub_slice_data.dart';
import 'package:subs_tracker/models/sub_slice.dart';

class SubSlicesNotifier extends StateNotifier<List<SubSlice>> {
  SubSlicesNotifier() : super(kDemoSlices);

  void addSlice(SubSlice slice) {
    debugPrint('before=${state.length}');
    state = [...state, slice];
    debugPrint('after=${state.length}');
  }

  void removeAt(int index) {
    state = List.of(state)..removeAt(index);
  }

  void updateAt(int index, SubSlice updated) {
    state = List.of(state)..[index] = updated;
  }

  void clear() {
    state = const [];
  }
}

final subSlicesProvider =
    StateNotifierProvider<SubSlicesNotifier, List<SubSlice>>(
      (ref) => SubSlicesNotifier(),
    );
