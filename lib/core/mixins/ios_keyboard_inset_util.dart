import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin IOSKeyboardInsetUtil<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  bool get isIOSWeb {
    return kIsWeb && TargetPlatform.iOS == defaultTargetPlatform;
  }

  @override
  void initState() {
    super.initState();
    if (isIOSWeb) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    if (isIOSWeb) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (isIOSWeb) {
      final bottomInset = View.of(context).viewInsets.bottom;

      final newKeyboardState = bottomInset > 0;

      if (_isKeyboardVisible != newKeyboardState) {
        setState(() {
          _isKeyboardVisible = newKeyboardState;
        });

        if (!newKeyboardState) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      }
    }
  }

  bool get isKeyboardVisible => _isKeyboardVisible;
}
