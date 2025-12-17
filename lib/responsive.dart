import 'package:flutter/widgets.dart';


class Responsive {
  const Responsive._();

  static const double _designWidth = 390.0;

  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / _designWidth).clamp(0.75, 1.3);
  }

  static double text(BuildContext context, double base) => base * scale(context);

  static double space(BuildContext context, double base) => base * scale(context);

  static EdgeInsets horizontal(BuildContext context, double base) {
    final value = base * scale(context);
    return EdgeInsets.symmetric(horizontal: value);
  }

  static EdgeInsets symmetric(
      BuildContext context, {
        double horizontal = 0,
        double vertical = 0,
      }) {
    final factor = scale(context);
    return EdgeInsets.symmetric(
      horizontal: horizontal * factor,
      vertical: vertical * factor,
    );
  }
}

extension ResponsiveContext on BuildContext {
  double get rScale => Responsive.scale(this);
  double rText(double base) => Responsive.text(this, base);
  double rSpace(double base) => Responsive.space(this, base);
}

class ResponsiveViewport extends StatelessWidget {
  const ResponsiveViewport({super.key, required this.child});

  final Widget child;

  static const double _designWidth = 390.0;
  static const double _minScale = 0.85;
  static const double _maxScale = 1.2;
  static const double _maxLayoutWidth = 520.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final scale = (width / _designWidth).clamp(_minScale, _maxScale);
        final textScaler = TextScaler.linear(scale);
        final media = MediaQuery.of(context);

        Widget content = child;

        if (width > _maxLayoutWidth) {
          content = Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxLayoutWidth),
              child: content,
            ),
          );
        }

        return MediaQuery(
          data: media.copyWith(textScaler: textScaler, size: Size(width, height)),
          child: content,
        );
      },
    );
  }
}
