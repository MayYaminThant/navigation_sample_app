import 'dart:async';
import 'dart:math';

import '../../domain/entities/entities.dart';

class SpotlightLatestCache {
  SpotlightLatestCache._();

  static final SpotlightLatestCache _instance = SpotlightLatestCache._();

  static const cacheExpiryMinutes = 5;
  static const cycleTimeMinutes = 1;
  static const profilesPerCycle = 10;

  DateTime? _lastRefresh;
  List<Candidate>? _cacheProfiles;
  int _startPoint = 0;

  static final _random = Random();

  Timer? _reloadTimer;
  Function _reloadCallback = () {};
  void registerReloadCallback(Function callback) {
    _reloadCallback = callback;
    _reloadTimer?.cancel();
    _reloadTimer =
        Timer.periodic(const Duration(minutes: cycleTimeMinutes), (Timer t) {
      _reloadCallback();
    });
  }

  void cancelReloadCallback() {
    _reloadCallback = () {};
    _reloadTimer?.cancel();
  }

  List<Candidate> generateLatestDisplayProfiles(List<Candidate> allProfiles) {
    _initialiseAndRefresh(allProfiles);
    return _generateSubsetProfiles();
  }

  List<Candidate> _generateSubsetProfiles() {
    if (_cacheProfiles == null) {
      return [];
    }
    _lastRefresh ??= _now;

    if (_cacheProfileCount <= profilesPerCycle) {
      return _cacheProfiles!;
    }

    final cacheAgeMinutes = _now.difference(_lastRefresh!).inMinutes;
    final cyclesPassed = (cacheAgeMinutes / cycleTimeMinutes).floor();
    final profilesPassed = cyclesPassed * profilesPerCycle;
    final currentIndex = (_startPoint + profilesPassed) % _cacheProfileCount;

    /// generate subset of profiles
    if (currentIndex + profilesPerCycle > _cacheProfileCount) {
      final tailList = _cacheProfiles!.sublist(currentIndex);
      final headListCount =
          (currentIndex + profilesPerCycle) - _cacheProfileCount;
      final headList = _cacheProfiles!.sublist(0, headListCount);
      return tailList + headList;
    }
    return _cacheProfiles!
        .sublist(currentIndex, currentIndex + profilesPerCycle);
  }

  void _initialiseAndRefresh(List<Candidate> newProfiles) {
    _lastRefresh ??= _now;
    if (_cacheProfiles == null ||
        _cacheProfiles!.isEmpty ||
        _now.difference(_lastRefresh!).inMinutes > cacheExpiryMinutes) {
      _refreshCache(newProfiles);
    }
  }

  void _refreshCache(List<Candidate> newProfiles) {
    _cacheProfiles = newProfiles;
    _updateLastRefresh();
    _generateStartPoint();
  }

  void _updateLastRefresh() {
    _lastRefresh = DateTime.now();
  }

  void _generateStartPoint() {
    if (_cacheProfiles == null) return;
    _startPoint = _random.nextInt(_cacheProfiles!.length);
  }

  int get _cacheProfileCount {
    return _cacheProfiles?.length ?? 0;
  }

  DateTime get _now {
    return DateTime.now();
  }

  factory SpotlightLatestCache() {
    return _instance;
  }
}
