enum SubscriptionTier { free, premium, pro }

abstract class SubscriptionService {
  Future<SubscriptionTier> getCurrentTier();
  Future<bool> canUseFeature(String feature);
  Future<void> upgradeToPremium();
  Future<void> upgradeToPro();
}

class MockSubscriptionService implements SubscriptionService {
  SubscriptionTier _currentTier = SubscriptionTier.free;

  @override
  Future<SubscriptionTier> getCurrentTier() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _currentTier;
  }

  @override
  Future<bool> canUseFeature(String feature) async {
    await Future.delayed(const Duration(milliseconds: 100));
    switch (_currentTier) {
      case SubscriptionTier.free:
        return feature == 'basic_tracking';
      case SubscriptionTier.premium:
        return feature != 'advanced_analytics';
      case SubscriptionTier.pro:
        return true;
    }
  }

  @override
  Future<void> upgradeToPremium() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentTier = SubscriptionTier.premium;
  }

  @override
  Future<void> upgradeToPro() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentTier = SubscriptionTier.pro;
  }
}
