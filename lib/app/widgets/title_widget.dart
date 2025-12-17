import 'package:flutter/material.dart';
import 'package:roomy/app/config/app_theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
      child: Text(title),
    );
  }
}
