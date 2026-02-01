import 'package:flutter/material.dart';

class HomeSideMenu extends StatelessWidget {
  const HomeSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      color: Colors.green,
                      child: Text('プログラム'),
                    ),
                  ),
                ),
                // TODO: 音声
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      color: Colors.yellow,
                      child: Text('設定'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              height: 48 + 16 + 48,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                // TODO: running icon
                // TODO: rest icon
              ],
            ),
            Text(
              '0/0 sets',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
