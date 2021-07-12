import 'package:flutter/material.dart';

final double designScrennHeight = 667;
final double designScrennWidth = 375;

class Dimension {
  double width;
  double height;

  Dimension(double width, double height) {
    this.width = width;
    this.height = height;
  }
}

Dimension dimension(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;

  return new Dimension(w, h);
}

double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double height(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.height / designScrennHeight;

  return (size * ratio).ceil().toDouble();
}

double width(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.width / designScrennWidth;
  return (size * ratio).ceil().toDouble();
}

double fontSize(BuildContext context, double size) {
  double ratio = MediaQuery.of(context).size.width / designScrennWidth;
  return (size * ratio).ceil().toDouble();
}