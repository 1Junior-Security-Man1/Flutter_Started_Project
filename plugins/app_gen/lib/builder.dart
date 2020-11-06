import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/app_string_generatot.dart';

Builder appStringsBuilder(BuilderOptions options) =>
    LibraryBuilder(AppStringGenerator(), generatedExtension: '.res.dart');
