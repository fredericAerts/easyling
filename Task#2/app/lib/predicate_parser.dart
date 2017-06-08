// Copyright (c) 2017, Frederic Aerts. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:mirrors';

import 'package:petitparser/petitparser.dart';

bool resolveNumericalRelationalPredicateWithGetters(Object object, String predicate) {
  bool result;
  Parser predicateParser = _constructNumericalRelationalParser();
  String valuePredicate = _resolveGetters(object, predicate);

  try {
    result = predicateParser.parse(valuePredicate).value;
  } catch (e) {
    _handlePredicateParseError(predicate, e);
  }

  return result;
}

Parser _constructNumericalRelationalParser() {
  Parser number = word().or(char('.')).star().flatten().trim().map(double.parse);

  return number.seq(char('>').trim()).seq(number).map((values) => values[0] > values[2])
    .or(number.seq(char('<').trim()).seq(number).map((values) => values[0] < values[2]));
}

String _resolveGetters(Object object, String predicate) {
  String valuePredicate;
  Parser getterParser = _constructNumericalRelationalGetterParser(object, predicate);

  try {
    valuePredicate = getterParser.parse(predicate).value;
  } catch (e) {
    _handlePredicateParseError(predicate, e);
  }

  return valuePredicate;
}

// Supports explicit getters only
Parser _constructNumericalRelationalGetterParser(Object object, String predicate) {
  InstanceMirror instanceMirror = reflect(object);
  List<Symbol> getterNamesInPredicate = _getExplicitGetterNames(instanceMirror, predicate);
  Parser valueParser = word().star().flatten();

  return valueParser.seq(char('>').trim()).seq(valueParser).map((values) {
    values[0] = getterNamesInPredicate.contains(values[0]) ? instanceMirror.getField(new Symbol(values[0])).reflectee.toString() : values[0];
    values[2] = getterNamesInPredicate.contains(values[2]) ? instanceMirror.getField(new Symbol(values[2])).reflectee.toString() : values[2];

    return '${values[0]} ${values[1]} ${values[2]}';
  }).or(valueParser.seq(char('<').trim()).seq(valueParser).map((values) {
    values[0] = getterNamesInPredicate.contains(values[0]) ? instanceMirror.getField(new Symbol(values[0])).reflectee.toString() : values[0];
    values[2] = getterNamesInPredicate.contains(values[2]) ? instanceMirror.getField(new Symbol(values[2])).reflectee.toString() : values[2];

    return '${values[0]} ${values[1]} ${values[2]}';
  }));
}

List<Symbol> _getExplicitGetterNames(InstanceMirror instanceMirror, String predicate) {
  ClassMirror objectClassMirror = instanceMirror.type;
  Iterable<String> getterNamesInObject = objectClassMirror
    .declarations
    .values
    .where((DeclarationMirror dm) => dm is MethodMirror && dm.isGetter)
    .map((DeclarationMirror dm) => MirrorSystem.getName(dm.simpleName));
  Parser identifierParser = letter().seq(word().star()).flatten();

  return identifierParser.matchesSkipping(getterNamesInObject.fold('', (prev, element) => prev + ' ' + element).trim());
}

void _handlePredicateParseError(String predicate, Error e) {
  print('Failed to parse predicate \"$predicate\": $e');
}
