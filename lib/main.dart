import 'package:flutter/material.dart';

import 'pages/clickIntensity.dart';
import 'pages/verticalMovement.dart';

void main() {
  runApp(MouseGraphHomeApp());
}

class MouseGraphHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: MouseDataHomePage(),
    );
  }
}

class MouseDataHomePage extends StatefulWidget {
  @override
  _MouseDataHomePageState createState() => _MouseDataHomePageState();
}

class _MouseDataHomePageState extends State<MouseDataHomePage> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    ClickIntensityPage(),
    VerticalMovementPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Set a fixed width for the NavigationRail to accommodate the text
    double railWidth = 200;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Mouse App'),
      ),
      body: Row(
        children: [
          NavigationRail(
            minWidth: railWidth,
            selectedIndex: currentIndex,
            useIndicator: false,
            onDestinationSelected: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.none, // Hide default labels
            groupAlignment: -1.0, // Align to the top
            destinations: [
              NavigationRailDestination(
                icon: currentIndex == 0
                    ? Container(
                        width: railWidth,
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.mouse),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Click Intensity',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Icon(Icons.mouse_outlined),
                label: Text('Click Intensity'),
              ),
              NavigationRailDestination(
                icon: currentIndex == 1
                    ? Container(
                        width: railWidth,
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.swap_vert),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Vertical Movement',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Icon(Icons.swap_vert_outlined),
                label: Text('Vertical Movement'),
              ),
            ],
          ),
          Expanded(
            child: _pages[currentIndex],
          ),
        ],
      ),
    );
  }
}
