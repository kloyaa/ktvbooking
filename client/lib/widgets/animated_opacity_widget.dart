import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../const/colors.const.dart';

class AnimatedOpacityWidget extends StatelessWidget {
  final double statusBarHeight;
  final String responseCode;
  final String responseMessage;

  const AnimatedOpacityWidget({
    super.key,
    required this.statusBarHeight,
    required this.responseCode,
    required this.responseMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('responseCode: $responseCode');
    }
    final errorCodes = ["0052", "0051", "501"];

    final initialOpacity = errorCodes.contains(responseCode) ? 1.0 : 0.0;
    final duration = responseCode != "00"
        ? const Duration(seconds: 1)
        : const Duration(seconds: 0);

    return AnimatedOpacity(
      opacity: initialOpacity,
      duration: duration,
      child: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        color: Colors.redAccent,
        child: Text(
          responseMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: kLight,
          ),
        ),
      ),
    );
  }
}
