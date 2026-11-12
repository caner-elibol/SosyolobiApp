import 'package:riverpod/riverpod.dart';

import '../../map/application/map_activities_provider.dart';
import '../../map/application/nearby_activities_slider_provider.dart';
import 'activities_providers.dart';

void invalidateMapActivityCaches(Ref ref) {
  ref.invalidate(nearbyActivitiesProvider);
  ref.invalidate(mapActivitiesProvider);
  ref.invalidate(nearbyActivitiesSliderProvider);
  ref.invalidate(joinedUpcomingActivitiesProvider);
}
