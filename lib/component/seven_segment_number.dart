import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SevenSegmentNumber extends StatelessWidget {
  final String digit;
  final Color color;
  final Size? segmentSize;
  final Size? colonSize;

  const SevenSegmentNumber({
    super.key,
    required this.digit,
    this.color = Colors.red, // Default color for LED
    this.segmentSize,
    this.colonSize,
  });

  @override
  Widget build(BuildContext context) {
    String assetName = 'assets/images/seven_segment/$digit.svg';
    return SvgPicture.asset(
      assetName,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      fit: BoxFit.fill,
      width: segmentSize?.width ?? 24.0,
      height: segmentSize?.height ?? 24.0,
    );
  }
}

// --- Widget Previewer Code ---
// These are functions that return widgets for previewing.
// They are typically placed at the end of the file or in a separate preview file.

@Preview(name: 'seven_segment_number0')
Widget previewSevenSegmentNumber0() {
  return const SevenSegmentNumber(digit: '0', color: Colors.red);
}

@Preview(name: 'seven_segment_number1')
Widget previewSevenSegmentNumber1() {
  return const SevenSegmentNumber(digit: '1', color: Colors.blue);
}

@Preview(name: 'seven_segment_number2')
Widget previewSevenSegmentNumber2() {
  return const SevenSegmentNumber(
    digit: '2',
    color: Colors.green,
    segmentSize: Size(48, 96),
  );
}

@Preview(name: 'seven_segment_number3')
Widget previewSevenSegmentNumber3() {
  return const SevenSegmentNumber(
    digit: '3',
    color: Colors.yellow,
    segmentSize: Size(96, 48),
  );
}

@Preview(name: 'seven_segment_number4')
Widget previewSevenSegmentNumber4() {
  return const SevenSegmentNumber(digit: '4', color: Colors.purple);
}

@Preview(name: 'seven_segment_number5')
Widget previewSevenSegmentNumber5() {
  return const SevenSegmentNumber(digit: '5', color: Colors.orange);
}

@Preview(name: 'seven_segment_number6')
Widget previewSevenSegmentNumber6() {
  return const SevenSegmentNumber(digit: '6', color: Colors.cyan);
}

@Preview(name: 'seven_segment_number7')
Widget previewSevenSegmentNumber7() {
  return const SevenSegmentNumber(digit: '7', color: Colors.pink);
}

@Preview(name: 'seven_segment_number8')
Widget previewSevenSegmentNumber8() {
  return const SevenSegmentNumber(digit: '8', color: Colors.teal);
}

@Preview(name: 'seven_segment_number9')
Widget previewSevenSegmentNumber9() {
  return SizedBox(
    width: 10,
    height: 100,
    child: const SevenSegmentNumber(
      digit: '9',
      color: Colors.lime,
    ),
  );
}

@Preview(name: 'seven_segment_number_colon')
Widget previewSevenSegmentNumberColon() {
  return const SevenSegmentNumber(digit: 'colon', color: Colors.red);
}
