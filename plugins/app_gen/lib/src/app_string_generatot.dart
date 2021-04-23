import 'dart:async';

import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

final _dartfmt = DartFormatter();

class AppStringGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    try {
      final appLocClass = library.classes.firstWhere(
          (element) => element.name == 'AppLocalizations_Labels',
          orElse: () => null);
      if (appLocClass != null) {
        final l = appLocClass.fields.map((e) {
          final b = MethodBuilder()
            ..name = e.displayName
            ..static = true
            ..lambda = true
            ..type = MethodType.getter
            ..returns =
                refer('String', 'package:flutter_starter/utils/localization/localization.dart')
            ..body = refer('AppLocalizations')
                .property('of')
                .call([
                  refer('App', 'package:flutter_starter/app.dart')
                      .property('globalNavigatorKey')
                      .property('currentContext')
                      .expression
                ])
                .property(e.displayName)
                .code;
          return b.build();
        }).toList();
        final clazz = Class((b) => b
          ..name = 'AppStrings'
          ..methods.addAll(l));

        final emitter = DartEmitter(Allocator(), true, true);
        final lb = Library((b) => b.body.add(clazz));
        return _dartfmt.format('${lb.accept(emitter)}');
      }
    } catch (_) {
      return null;
    }
    return null;
  }
}
