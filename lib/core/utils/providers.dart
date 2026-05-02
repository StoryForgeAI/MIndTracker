import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import '../../features/tracking/data/android_tracking_service.dart';
import '../../features/dashboard/data/dashboard_service.dart';
import '../../features/dashboard/data/supabase_repository.dart';
import '../../features/subscription/domain/subscription_service.dart';
import '../../features/onboarding/domain/onboarding_data.dart';
import '../../features/onboarding/data/onboarding_repository.dart';

final androidTrackingServiceProvider = Provider<AndroidTrackingService>((ref) {
  return AndroidTrackingServiceImpl();
});

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardServiceImpl();
});

final supabaseRepositoryProvider = Provider<SupabaseRepository>((ref) {
  return SupabaseRepositoryImpl(Supabase.instance.client);
});

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return MockSubscriptionService();
});

final onboardingDataProvider = StateProvider<OnboardingData>((ref) {
  return const OnboardingData();
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl();
});
