// Copyright (c) 2017, Frederic Aerts. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

abstract class Shape {
  num get area;
  num get circumference;
}

class Rectangle implements Shape {
  int _x;
  int _y;

  Rectangle(this._x, this._y);

  int get area => _x * _y;
  int get circumference => 2 * (_x + _y);
}

class Square implements Shape {
  int _x;

  Square(this._x);

  int get area => _x * _x;
  int get circumference => 4 * _x;
  void noSuchMethod(Invocation mirror) {
    print('BLABLA');
  }
}

class Circle implements Shape {
  int _x;

  Circle(this._x);

  double get area => PI * pow(_x, 2);
  double get circumference => 2 * PI * _x;
}
