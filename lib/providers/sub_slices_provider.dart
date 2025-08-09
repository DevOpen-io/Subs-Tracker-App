import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subs_tracker/data/sub_slice_data.dart';
import 'package:subs_tracker/models/sub_slice.dart';

class SubSlicesNotifier extends StateNotifier<List<SubSlice>> {
  SubSlicesNotifier() : super(kDemoSlices);

  void addSlice(SubSlice slice) {
    state = [...state, slice];
  }

  void removeAt(int index) {
    if (index < 0 || index > state.length) return;
    final copy = [...state]..removeAt(index);
    state = copy;
  }

  void updateAt(int index, SubSlice updated) {
    if (index < 0 || index > state.length) return;
    final copy = [...state]..[index] = updated;
    state = copy;
  }

  void clear() {
    state = const [];
  }
}

final subSlicesProvider =
    StateNotifierProvider<SubSlicesNotifier, List<SubSlice>>(
      (ref) => SubSlicesNotifier(),
    );
