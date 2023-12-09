import 'package:flutter/material.dart';

class MainTemplate extends StatefulWidget {

  final Widget child;
  final Function(int) onMenuChoose;

  const MainTemplate({super.key, required this.child, required this.onMenuChoose});

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 200,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Earth"),
                    onTap: () => widget.onMenuChoose(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rocket_launch),
                    title: const Text("Mars"),
                    onTap: () => widget.onMenuChoose(1),
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_red_eye_rounded),
                    title: const Text("Uranus"),
                    onTap: () => widget.onMenuChoose(2),
                  ),

                ],
              ),
            ),
          ),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}
