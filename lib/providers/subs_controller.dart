import 'package:path/path.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subs_tracker/models/sub_slice.dart';

part 'subs_controller.g.dart';

@riverpod
Future<JsonSqFliteStorage> subsStorage(Ref ref) async {
  JsonSqFliteStorage storage = await JsonSqFliteStorage.open(join(await getDatabasesPath(), 'subs.db'));
  ref..onDispose(storage.close)..keepAlive();
  return storage;
}

@riverpod
@JsonPersist()
class SubsController extends _$SubsController {
  @override
  FutureOr<List<SubSlice>> build() async {
    await persist(
      ref.watch(subsStorageProvider.future),
    ).future;

    return state.value ?? [];
  }

  void addSlice(SubSlice slice) {
    state = AsyncValue.data(List.of(state.value ?? [])..add(slice));
  }

  void removeAt(int index) {
    state = AsyncValue.data(List.of(state.value ?? [])..removeAt(index));
  }

  void updateAt(int index, SubSlice updated) {
    state = AsyncValue.data(List.of(state.value ?? [])..[index] = updated);
  }

  void clear() {
    state = AsyncValue.data([]);
  }
}
