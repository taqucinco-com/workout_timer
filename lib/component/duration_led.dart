import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:workout_timer/component/seven_segment_number.dart';

class DurationLed extends StatelessWidget {
  final Duration duration;
  final Color color;
  final Size? segmentSize; // Added segmentSize parameter

  const DurationLed({
    super.key,
    required this.duration,
    this.color = Colors.red,
    this.segmentSize, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    final minuteString = minutes.toString().padLeft(2, '0');
    final secondString = seconds.toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SevenSegmentNumber(
          digit: minuteString[0],
          color: color,
          width: segmentSize?.width,
          height: segmentSize?.height,
        ),
        const SizedBox(width: 4),
        SevenSegmentNumber(
          digit: minuteString[1],
          color: color,
          width: segmentSize?.width,
          height: segmentSize?.height,
        ),
        const SizedBox(width: 4),
        SevenSegmentNumber(
          digit: 'colon',
          color: color,
          width: segmentSize?.width,
          height: segmentSize?.height,
        ),
        const SizedBox(width: 4),
        SevenSegmentNumber(
          digit: secondString[0],
          color: color,
          width: segmentSize?.width,
          height: segmentSize?.height,
        ),
        const SizedBox(width: 4),
        SevenSegmentNumber(
          digit: secondString[1],
          color: color,
          width: segmentSize?.width,
          height: segmentSize?.height,
        ),
      ],
    );
  }
}

// --- Widget Previewer Code ---
@Preview(name: 'duration_led_preview')
Widget previewDurationLed() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      DurationLed(
        duration: Duration(minutes: 1, seconds: 30),
        color: Colors.red,
        segmentSize: Size(30, 50), // Example size
      ),
      SizedBox(width: 20),
      DurationLed(
        duration: Duration(minutes: 0, seconds: 5),
        color: Colors.blue,
        segmentSize: Size(20, 35), // Example size
      ),
      SizedBox(width: 20),
      DurationLed(
        duration: Duration(minutes: 99, seconds: 59),
        color: Colors.green,
      ), // No segmentSize, uses default
    ],
  );
}
