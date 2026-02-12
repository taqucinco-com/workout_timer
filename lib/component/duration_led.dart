import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workout_timer/component/seven_segment_number.dart';

class DurationLed extends HookConsumerWidget {
  final Duration duration;
  final Color color;
  final Size? segmentSize;
  final Size? colonSize;
  final double margin;
  final bool blinking;

  const DurationLed({
    super.key,
    required this.duration,
    this.color = Colors.red,
    this.segmentSize,
    this.colonSize,
    this.margin = 4.0,
    this.blinking = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    final minuteString = minutes.toString().padLeft(2, '0');
    final secondString = seconds.toString().padLeft(2, '0');

    final animationController = useAnimationController(duration: const Duration(milliseconds: 750));

    useEffect(() {
      if (blinking) {
        animationController.repeat(reverse: true);
      } else {
        animationController.stop();
      }
      return null;
    }, [blinking]);

    final animatedColor = useAnimation(
      ColorTween(begin: color, end: color.withAlpha((256 / 10).toInt())).animate(animationController),
    );

    final displayColor = blinking ? animatedColor ?? color : color;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        segmentSize != null
            ? SizedBox(
                width: segmentSize!.width,
                height: segmentSize!.height,
                child: SevenSegmentNumber(
                  digit: minuteString[0],
                  color: displayColor,
                  segmentSize: segmentSize,
                ),
              )
            : SevenSegmentNumber(
                digit: minuteString[0],
                color: displayColor,
              ),
        SizedBox(width: margin),
        segmentSize != null
            ? SizedBox(
                width: segmentSize!.width,
                height: segmentSize!.height,
                child: SevenSegmentNumber(
                  digit: minuteString[1],
                  color: displayColor,
                  segmentSize: segmentSize,
                ),
              )
            : SevenSegmentNumber(
                digit: minuteString[1],
                color: displayColor,
              ),
        SizedBox(width: margin),
        colonSize != null
            ? SizedBox(
                width: colonSize!.width,
                height: colonSize!.height,
                child: SevenSegmentNumber(
                  digit: 'colon',
                  color: displayColor,
                  colonSize: colonSize,
                ),
              )
            : SevenSegmentNumber(
                digit: 'colon',
                color: displayColor,
              ),
        SizedBox(width: margin),
        segmentSize != null
            ? SizedBox(
                width: segmentSize!.width,
                height: segmentSize!.height,
                child: SevenSegmentNumber(
                  digit: secondString[0],
                  color: displayColor,
                  segmentSize: segmentSize,
                ),
              )
            : SevenSegmentNumber(
                digit: secondString[0],
                color: displayColor,
              ),
        SizedBox(width: margin),
        segmentSize != null
            ? SizedBox(
                width: segmentSize!.width,
                height: segmentSize!.height,
                child: SevenSegmentNumber(
                  digit: secondString[1],
                  color: displayColor,
                  segmentSize: segmentSize,
                ),
              )
            : SevenSegmentNumber(
                digit: secondString[1],
                color: displayColor,
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
        segmentSize: Size(12, 48),
        colonSize: Size(20, 100),
      ),
      SizedBox(width: 20),
      DurationLed(
        duration: Duration(minutes: 0, seconds: 5),
        color: Colors.blue,
        segmentSize: Size(48, 96),
        colonSize: Size(8, 96),
      ),
      SizedBox(width: 20),
      DurationLed(
        duration: Duration(minutes: 0, seconds: 4, milliseconds: 500),
        color: Colors.blue,
        segmentSize: Size(48, 96),
        colonSize: Size(8, 96),
      ),
      SizedBox(width: 20),
      DurationLed(
        duration: Duration(minutes: 99, seconds: 59),
        color: Colors.green,
      ),
    ],
  );
}

@Preview(name: 'duration_led_preview_case')
Widget previewDurationLedCase() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(width: 20),
      DurationLed(duration: Duration(minutes: 1, seconds: 0, milliseconds: 1), color: Colors.green),
      SizedBox(width: 20),
      DurationLed(duration: Duration(minutes: 1, seconds: 0, milliseconds: 0), color: Colors.green),
      SizedBox(width: 20),
      DurationLed(duration: Duration(minutes: 0, seconds: 59, milliseconds: 999), color: Colors.green),
      SizedBox(width: 20),
      DurationLed(duration: Duration(minutes: 0, seconds: 59, milliseconds: 0), color: Colors.green),
    ],
  );
}
