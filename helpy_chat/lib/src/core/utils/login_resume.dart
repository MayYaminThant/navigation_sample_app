import 'package:get/get.dart';

class LoginResume {
  // LoginResume is a singleton
  static final LoginResume _loginResume = LoginResume._internal();

  factory LoginResume() {
    return _loginResume;
  }

  LoginResume._internal();

  SavedRouteState? _savedState;

  bool saveCurrentState(String? currentRoute, Map<String, String?>? parameters,
      Map<String, Object?>? arguments) {
    if (_savedState != null) {
      return false;
    }
    final newSaveState = SavedRouteState(
        currentRoute: currentRoute,
        parameters: parameters,
        arguments: arguments);
    _savedState = newSaveState;
    return true;
  }

  bool get resumeAvailable {
    return !(_savedState == null);
  }

  resetResumeState() {
    _savedState = null;
  }

  resumeState() {
    if (_savedState == null) {
      return;
    }
    if (_savedState!.currentRoute == null) {
      return;
    }
    Get.toNamed(_savedState!.currentRoute!,
        // parameters: _savedState!.parameters,
        arguments: _savedState!.arguments);
    _savedState = null;
  }
}

class SavedRouteState {
  String? currentRoute;
  late Map<String, String>? parameters;
  Map<String, Object?>? arguments;

  SavedRouteState(
      {required this.currentRoute,
        required Map<String, String?>? parameters,
        required this.arguments}) {
    if (parameters == null) {
      this.parameters = null;
      return;
    }
    final cleanParameters = parameters;
    parameters.removeWhere((key, value) => value == null);
    this.parameters = cleanParameters as Map<String, String>;
  }
}
