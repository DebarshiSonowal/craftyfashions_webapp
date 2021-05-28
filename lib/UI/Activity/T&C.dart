import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpScreen extends StatefulWidget {
  @override
  HelpScreenState createState() {
    return HelpScreenState();
  }

  String which;

  HelpScreen(this.which);
}

class HelpScreenState extends State<HelpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Help')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: EasyWebView(
            src: widget.which.toString().trim() == "T&C"
                ? 'assets/assets/Policy/index.html'
                : 'assets/assets/Policy/RETURN AND REFUND POLICY.htm',
            isHtml: false,
            // Use Html syntax
            isMarkdown: false,
            // Use markdown syntax
            convertToWidgets: false,
            onLoaded: () {
              IFrameElement iframeElement = IFrameElement()
                ..src = widget.which.toString().trim() == "T&C"
                    ? 'assets/assets/Policy/index.html'
                    : 'assets/assets/Policy/RETURN AND REFUND POLICY.htm'
                ..style.border = 'none'
                ..onLoad.listen((event) {
                  // perform you logic here.
                });

              ui.platformViewRegistry.registerViewFactory(
                'webpage',
                    (int viewId) => iframeElement,
              );

              return Directionality(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: Container(child: HtmlElementView(viewType: 'webpage')),
                ),
              );
            }, // Try to convert to flutter widgets
            // width: 100,
            // height: 100,
          ),
        ));
  }

}
