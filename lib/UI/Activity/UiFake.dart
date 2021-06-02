import 'dart:ui' as ui;


class platformViewRegistry {
  static registerViewFactory(String viewId, dynamic cb) {
    // ignore: camel_case_types
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}