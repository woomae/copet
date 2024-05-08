import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/providers/user_notifier_provider.dart';

class WebviewLoginWidget extends StatefulWidget {
  final String url;
  const WebviewLoginWidget({
    super.key,
    required this.url
  });

  @override
  State<WebviewLoginWidget> createState() => _WebviewLoginWidgetState();
}

class _WebviewLoginWidgetState extends State<WebviewLoginWidget> {
 @override
 void initState() {
    super.initState();
 }
 final GlobalKey webViewKey = GlobalKey();
 InAppWebViewController? webViewController;
 final CookieManager cookieManager = CookieManager.instance();

  @override
  build(BuildContext context){
    return SafeArea(
      child: Consumer(builder:(context, provider, child){
        final ref = provider.read(UserProvider);
        return  InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) async {
              String? apiKey = dotenv.env['API_KEY'].toString();
              if(url.toString().contains(apiKey)){
                //리다이렉트 시
                final List<Cookie> cookie = await cookieManager.getCookies(url: url!);
                if (cookie[0].value.contains('user_id')) {
                  //쿠키에서 userid가져온 후, provider를 통해 id 업데이트
                  final value = cookie[0].value.toString();
                  final userIdIndex = value.substring(value.indexOf('user_id')+8, value.length);
                  final userId = int.parse(userIdIndex.split('%')[0]);

                  provider.read(UserProvider.notifier).updateUser(id: userId);
                }
                if(cookie[0].value.contains('user_id') == false){
                  provider.read(UserProvider.notifier).updateUser(id: 0, nickname: '');
                  print('------------------------------------------------userid없음');
                  //쿠키에 userid없으면 logintype으로 이동
                }
                else{
                  //에러처리
                }
                Navigator.pop(context);
              }
            }
        );
      })
    );
  }
}
