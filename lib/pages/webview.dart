import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jupiter_web_app/pages/homepage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../globals.dart' as globals;

class WebView extends StatefulWidget {
  static const String routeName='webview';
  String link;
   WebView({Key? key,this.link = ''}) : super(key: key);
  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    globals.weblink=widget.link;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity=Connectivity();
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(globals.weblink));
    late WebViewController controllerGlobal;
    return WillPopScope(
      onWillPop: ()async{

        if(await controller.canGoBack())
        {
          controller.goBack();
          return false;
        }
        else
        {

          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
            body: StreamBuilder(
              stream: connectivity.onConnectivityChanged,
              builder: (_, snapshot){
                return snapshot.connectionState==ConnectionState.active?
                snapshot.data!=ConnectivityResult.none?
                WebViewWidget(controller: controller): Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.wifi_off_sharp,size: 45,),
                      SizedBox(height: 10,),
                      Text('No Data Connection')
                    ],
                  ),
                )
                    :WebViewWidget(controller: controller);
              },),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
            elevation: 3,
            hoverColor: Colors.amber,
            backgroundColor: Colors.green.withOpacity(0.8),
            child: const Icon(Icons.home),
          ),
        ),
      ),
    );
  }
}

