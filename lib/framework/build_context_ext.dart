import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// 親Widgetに対するOffsetとSizeを取得する
  /// Returns `null` コンテキストが見つからないとき
  (Offset, Size)? boundingRect() {
    // ignore: unnecessary_this
    final RenderObject? renderObject = this.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      return (renderObject.localToGlobal(Offset.zero), renderObject.size);
    }
    return null;
  }
}
