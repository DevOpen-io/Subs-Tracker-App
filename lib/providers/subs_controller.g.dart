// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subsStorage)
const subsStorageProvider = SubsStorageProvider._();

final class SubsStorageProvider
    extends
        $FunctionalProvider<
          AsyncValue<JsonSqFliteStorage>,
          JsonSqFliteStorage,
          FutureOr<JsonSqFliteStorage>
        >
    with
        $FutureModifier<JsonSqFliteStorage>,
        $FutureProvider<JsonSqFliteStorage> {
  const SubsStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subsStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subsStorageHash();

  @$internal
  @override
  $FutureProviderElement<JsonSqFliteStorage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JsonSqFliteStorage> create(Ref ref) {
    return subsStorage(ref);
  }
}

String _$subsStorageHash() => r'2e3ce2bce27a4b50ba13ce6a41863ac5131f4985';

@ProviderFor(SubsController)
@JsonPersist()
const subsControllerProvider = SubsControllerProvider._();

@JsonPersist()
final class SubsControllerProvider
    extends $AsyncNotifierProvider<SubsController, List<SubSlice>> {
  const SubsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subsControllerHash();

  @$internal
  @override
  SubsController create() => SubsController();
}

String _$subsControllerHash() => r'c558d5c64d9366ad75eed419989c9f6038a880a0';

@JsonPersist()
abstract class _$SubsControllerBase extends $AsyncNotifier<List<SubSlice>> {
  FutureOr<List<SubSlice>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<SubSlice>>, List<SubSlice>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SubSlice>>, List<SubSlice>>,
              AsyncValue<List<SubSlice>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// **************************************************************************
// JsonGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
abstract class _$SubsController extends _$SubsControllerBase {
  /// The default key used by [persist].
  String get key {
    const resolvedKey = "SubsController";
    return resolvedKey;
  }

  /// A variant of [persist], for JSON-specific encoding.
  ///
  /// You can override [key] to customize the key used for storage.
  PersistResult persist(
    FutureOr<Storage<String, String>> storage, {
    String? key,
    String Function(List<SubSlice> state)? encode,
    List<SubSlice> Function(String encoded)? decode,
    StorageOptions options = const StorageOptions(),
  }) {
    return NotifierPersistX(this).persist<String, String>(
      storage,
      key: key ?? this.key,
      encode: encode ?? $jsonCodex.encode,
      decode:
          decode ??
          (encoded) {
            final e = $jsonCodex.decode(encoded);
            return (e as List)
                .map((e) => SubSlice.fromJson(e as Map<String, Object?>))
                .toList();
          },
      options: options,
    );
  }
}
