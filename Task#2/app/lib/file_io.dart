// Copyright (c) 2017, Frederic Aerts. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:path/path.dart' as path;

final String _fileRoot = path.join(Directory.current.parent.path, 'sample-input');

Future<List<String>> fetchLines(String fileName) async {
  List<String> lines = new List();

  try {
    lines = await new File(path.join(_fileRoot, fileName)).readAsLines();
    lines.remove('');
  } on FileSystemException catch (e) {
    print('${e.message}: ${path.join(_fileRoot, fileName)}');
  } catch (e, s) {
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  }

  return lines;
}
