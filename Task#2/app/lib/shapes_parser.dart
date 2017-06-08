// Copyright (c) 2017, Frederic Aerts. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:app/shapes.dart';

Shape parseShapeFromLine(String line) {
  Shape shape;
  List<String> cols = line.split(' ');
  String shapeName = cols[0];

  try {
    switch(shapeName) {
      case 'rectangle':
        shape = new Rectangle(int.parse(cols[1]), int.parse(cols[2]));
        break;
      case 'square':
        shape = new Square(int.parse(cols[1]));
        break;
      case 'circle':
        shape = new Circle(int.parse(cols[1]));
        break;
      default:
        print('Shape $shapeName is not supported');
    }
  } catch (e) {
    _handleShapeInitFromLineError(shapeName, line);
  }

  return shape;
}

void _handleShapeInitFromLineError(String shapeName, String line) {
  print('Failed to initialize $shapeName object from line \"$line\"\n');
}
