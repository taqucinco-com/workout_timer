import 'package:flutter/material.dart';
import 'package:workout_timer/component/duration_led.dart';
import 'package:workout_timer/feature/page/home/compoment/home_side_menu.dart'; // Import DurationLed

class TimeSettingNotSetScreen extends StatelessWidget {
  const TimeSettingNotSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox.expand(
                child: HomeSideMenu(),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 24),
                  LayoutBuilder(builder: (context, constraint) {
                    return DurationLed(
                      duration: Duration(minutes: 0, seconds: 0),
                      color: Colors.orange.shade700,
                    );
                  }),
                  SizedBox(width: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
