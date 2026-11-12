// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "Raporlarım" — the current user's own submitted reports with status.
/// Mirrors `ReportsController.GetMine` (`GET /api/reports/mine`, new
/// 2026-08-15). No existing mobile flow surfaced this before; added here
/// since a report-submission flow (`ReportUserDialog`) already exists.

@ProviderFor(myReports)
final myReportsProvider = MyReportsProvider._();

/// "Raporlarım" — the current user's own submitted reports with status.
/// Mirrors `ReportsController.GetMine` (`GET /api/reports/mine`, new
/// 2026-08-15). No existing mobile flow surfaced this before; added here
/// since a report-submission flow (`ReportUserDialog`) already exists.

final class MyReportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReportResponse>>,
          List<ReportResponse>,
          FutureOr<List<ReportResponse>>
        >
    with
        $FutureModifier<List<ReportResponse>>,
        $FutureProvider<List<ReportResponse>> {
  /// "Raporlarım" — the current user's own submitted reports with status.
  /// Mirrors `ReportsController.GetMine` (`GET /api/reports/mine`, new
  /// 2026-08-15). No existing mobile flow surfaced this before; added here
  /// since a report-submission flow (`ReportUserDialog`) already exists.
  MyReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myReportsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReportResponse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReportResponse>> create(Ref ref) {
    return myReports(ref);
  }
}

String _$myReportsHash() => r'4cfc5f943bfc6cae19d4dfc176eb39797f91e3b2';

/// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
/// actions, no cached query state to invalidate.

@ProviderFor(UserActionsController)
final userActionsControllerProvider = UserActionsControllerProvider._();

/// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
/// actions, no cached query state to invalidate.
final class UserActionsControllerProvider
    extends $AsyncNotifierProvider<UserActionsController, void> {
  /// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
  /// actions, no cached query state to invalidate.
  UserActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userActionsControllerHash();

  @$internal
  @override
  UserActionsController create() => UserActionsController();
}

String _$userActionsControllerHash() =>
    r'd71fcd5fa53631641c13b56e32fa82904067f8e3';

/// Mirrors `sosyolobi-web-2/src/hooks/useUserActions.ts` — plain mutation
/// actions, no cached query state to invalidate.

abstract class _$UserActionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
