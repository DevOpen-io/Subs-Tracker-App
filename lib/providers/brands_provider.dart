import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subs_tracker/models/brand.dart';

part 'brands_provider.g.dart';

@riverpod
Future<JsonSqFliteStorage> brandsStorage(Ref ref) async {
  JsonSqFliteStorage storage = await JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'brands.db'),
  );
  ref
    ..onDispose(storage.close)
    ..keepAlive();
  return storage;
}

@Riverpod(keepAlive: true)
@JsonPersist()
class Brands extends _$Brands {
  @override
  FutureOr<List<Brand>> build() async {
    await persist(
      ref.watch(brandsStorageProvider.future),
      options: StorageOptions(
        cacheTime: StorageCacheTime.unsafe_forever,
        destroyKey: "v1",
      ),
    ).future;
    if (state.value != null) {
      return state.value!;
    }
    final jsonString = await rootBundle.loadString('assets/brands.json');
    final jsonData = jsonDecode(jsonString) as List<dynamic>;
    return jsonData
        .map((e) => Brand.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
