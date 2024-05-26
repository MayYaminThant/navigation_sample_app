import 'package:dh_mobile/src/core/utils/environment_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dh_mobile/src/config/routes/routes.dart';

class EnvironmentSelectionSection extends StatefulWidget {
  const EnvironmentSelectionSection({super.key});

  @override
  State<EnvironmentSelectionSection> createState() => _EnvironmentSelectionSectionState();
}

class _EnvironmentSelectionSectionState extends State<EnvironmentSelectionSection> {

  _setEnvironment(Environment env) {
    setEnvironment(env);
    Get.offAllNamed(splashPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Column(children: [
      const Text("Select Environment", style: TextStyle(fontSize: 20)),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {
          _setEnvironment(Environment.test);
        },
        child: const Text("Test"),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          _setEnvironment(Environment.production);
        },
        child: const Text("Production / Moderator"),
      ),
    ])));
  }
}
