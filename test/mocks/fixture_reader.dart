import 'dart:io';

// String fixture(String name) => File('test/mocks/$name').readAsStringSync();

String fixture(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/mocks/$name').readAsStringSync();
}
