// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors the inline `useQuery` in `CreateActivityForm.tsx` — `staleTime:
/// Infinity` on web maps to `keepAlive` + no auto-invalidation here.

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

/// Mirrors the inline `useQuery` in `CreateActivityForm.tsx` — `staleTime:
/// Infinity` on web maps to `keepAlive` + no auto-invalidation here.

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Category>>,
          List<Category>,
          FutureOr<List<Category>>
        >
    with $FutureModifier<List<Category>>, $FutureProvider<List<Category>> {
  /// Mirrors the inline `useQuery` in `CreateActivityForm.tsx` — `staleTime:
  /// Infinity` on web maps to `keepAlive` + no auto-invalidation here.
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Category>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Category>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'bbeea301ea8d4906fded3267527a8a724e04b345';
