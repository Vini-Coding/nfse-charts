import 'package:flutter/material.dart';

List<Color> generateColors(Color startColor, int count) {
  final List<Color> colors = [startColor];
  final HSVColor startHSV = HSVColor.fromColor(startColor);

  for (int i = 1; i < count; i++) {
    final double hue = (startHSV.hue + (i * 30)) % 360;
    final double saturation = (startHSV.saturation * 1.25).clamp(0.0, 1.0); // Reduzindo a saturação um pouco menos
    final double value = (startHSV.value * 1.4).clamp(0.0, 1.0); // Reduzindo o valor (luminosidade) um pouco menos
    colors.add(HSVColor.fromAHSV(startHSV.alpha, hue, saturation, value).toColor());
  }

  return colors;
}