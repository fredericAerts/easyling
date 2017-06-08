// Copyright (c) 2017, Frederic Aerts. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:app/file_io.dart' as fileIO;
import 'package:app/predicate_parser.dart' as predicateParser;
import 'package:app/shapes_parser.dart' as shapesParser;
import 'package:app/shapes.dart';

main() async {
  List<Shape> shapes = new List();
  List<String> shapesAsLines = await fileIO.fetchLines('inputs.txt');
  List<String> predicatesAsLines = await fileIO.fetchLines('predicates.txt');

  // parse shapes
  shapesAsLines.forEach((String line) {
    Shape shape = shapesParser.parseShapeFromLine(line);

    if (shape != null) shapes.add(shape);
  });

  shapes.forEach((Shape shape) async {
    Map<String, bool> results = new Map();

    // evaluate predicates against shape
    predicatesAsLines.forEach((String predicate) {
      bool result = predicateParser.resolveNumericalRelationalPredicateWithGetters(shape, predicate);

      if (result != null) results.addAll(<String, bool>{ predicate: result });
    });

    stdout.writeln('Predicates result for $shape: ');
    _printPredicatesResult(results);
  });
}

void _printPredicatesResult(Map<String, bool> results) {
  results.forEach((String key, bool value) {
    stdout.writeln('($key) => $value');
  });
  stdout.writeln('');
}
