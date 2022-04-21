import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewapp/network_error.dart';
import 'package:webviewapp/parameters.dart';
import 'package:provider/provider.dart';
import 'package:webviewapp/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

String Current_URL = INIT_URL;
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
        child: homePage(),
      )
    ],
    child: MaterialApp(
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
      home: homePage(),
    ),
  ));
}

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late WebViewController _controller;
  Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);  
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(TOP_SPACING),
        child: AppBar(
            backgroundColor: APPBAR_BACKGROUND,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFFFDFDFD),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            )),
      ),
      body: ui(),
    );
  }

  Widget ui() {
    return Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
        if (value.isOnline != null) {
          return value.isOnline ? webUi() : ErrorNetworkPage(context);
        }
        return Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget webUi() {
    return Container(
        child: WillPopScope(
      onWillPop: () => _goBack(context),
      child: WebView(
          initialUrl: Current_URL,
          zoomEnabled: false,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter = new Completer<WebViewController>();

            if (!_controllerCompleter.isCompleted) {
              _controllerCompleter.future.then((value) => _controller = value);
              _controllerCompleter.complete(webViewController);
            }
          },
          onPageFinished: (p) {
            Current_URL = p;
          }),
    ));
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(DIALOG_TEXT),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(DIALOG_REJ_TEXT),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text(DIALOG_ACC_TEXT),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}
