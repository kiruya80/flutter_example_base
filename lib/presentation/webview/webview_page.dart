import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_base/core/utils/print_log.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../../shared/state/base_con_state.dart';

///
///
/// https://cloudconvert.com/ttf-to-woff2
///
class WebviewPage extends ConsumerStatefulWidget {
  const WebviewPage({super.key});

  @override
  ConsumerState<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends BaseConState<WebviewPage> {
  InAppWebViewInitialData? initialData;
  String htmlContent = '';
  String filePath = '';

  @override
  void initState() {
    super.initState();
    QcLog.d('initState ==== ');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _loadHtmlFromAssets();
    });
  }

  Future<void> _loadHtmlFromAssets() async {
    // final directory = await getApplicationSupportDirectory();
    // final htmlPath = '${directory.path}/sample.html';
    // final fontPath = '${directory.path}/NanumGaRamYeonGgoc.ttf';

    // 복사: html
    // final htmlData = await rootBundle.loadString('assets/html/sample.html');
    // await File(htmlPath).writeAsString(htmlData);

    // 복사: 폰트
    // final fontData = await rootBundle.load('assets/fonts/NanumGaRamYeonGgoc.ttf');
    // final base64Font = base64Encode(fontData.buffer.asUint8List());
    final fontBytes = await rootBundle.load('assets/fonts/NanumGaRamYeonGgoc.woff2');
    final base64Font = base64Encode(fontBytes.buffer.asUint8List());

    // var  dataUrl = Uri.dataFromString(
    //   modifiedHtml,
    //   mimeType: 'text/html',
    //   encoding: utf8,
    // ).toString();
    // QcLog.d('dataUrl ==== $dataUrl');

    // 2. HTML 문자열 생성
    ///  src: url("data:font/ttf;base64,$base64Font") format("truetype");
    ///   src: url("data:font/woff2;base64,$base64Font") format("woff2");
    ///
    ///
    ///    <meta name="viewport" content="width=device-width, initial-scale=1">
    ///     <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    ///
    final html = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <style>
          @font-face {
            font-family: 'NanumFont';
           
           src: url("data:font/woff2;base64,$base64Font") format("woff2");
          }
          body {
            font-family: 'NanumFont', sans-serif;
            font-size: 18px;
            padding: 16px;
          }
        </style>
      </head>
      <body>
      <h1> 제목 </h1>
      <h2> 부제목 </h2>
        <p>이 문장은 나눔 손글씨 꽃체 폰트로 렌더링됩니다.</p>
      </body>
      </html>
    ''';

    setState(() {
      QcLog.d('initialData ==== ');
      htmlContent = html;
      // initialData = InAppWebViewInitialData(
      //     data:  dataUrl );
      // _localUrl = Uri.file(htmlPath).toString();
    });
  }

  ///
  /// 임시 파일에 저장
  ///
  Future<String> saveHtmlToTempFile(String htmlContent) async {
    QcLog.d('saveHtmlToTempFile ==== $htmlContent');
    final dir = await getTemporaryDirectory(); // 또는 getApplicationSupportDirectory()
    final file = File('${dir.path}/temp_page.html');
    await file.writeAsString(htmlContent);
    return file.path;
  }

  ///
  /// 파일 내용 불러오기
  ///
  Future<void> getHtmlToTempFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    QcLog.d('file ==== ${path},  ${file.path}');
    QcLog.d('contents ==== $contents');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('로컬 HTML + 폰트')), body: _makeHtmlFile());
  }

  bool makeFile = false;

  _makeHtmlFile() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            /// html 생성
            _loadHtmlFromAssets();

            /// 생성된 html을 임시 파일에 저장
            filePath = await saveHtmlToTempFile(htmlContent);
            QcLog.d('filePath ==== ${filePath}');
            getHtmlToTempFile(filePath);
            final fileUri = WebUri('file://$filePath');
            QcLog.d('fileUri ==== ${fileUri}');
            QcLog.d('존재함?: ${await File(filePath).exists()}');
            setState(() {
              makeFile = true;
            });
          },
          child: Text('html load'),
        ),
        Expanded(
          child:
              makeFile
                  ? InAppWebView(
                    // initialUrlRequest: URLRequest(
                    //     url: WebUri("https://m.naver.com/")
                    // ),
                    initialUrlRequest: URLRequest(url: WebUri('file://$filePath')),
                    // initialUrlRequest: URLRequest(
                    //   url: WebUri.fromFilePath('/data/user/0/your_app_package/cache/your_html_file.html'),
                    //   // 또는 File('path/to/your/file.html').uri
                    //   baseUrl: WebUri.uri(Uri.parse('file:///')),
                    // ),
                    // initialFile: '/data/user/0/com.example.base.flutter_example_base/cache/temp_page.html',
                    // initialFile:'file://$filePath',
                    initialSettings: InAppWebViewSettings(
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled: true,
                      mediaPlaybackRequiresUserGesture: false,
                      useHybridComposition: true,
                      networkAvailable: true,
                      allowFileAccessFromFileURLs: true,
                      allowUniversalAccessFromFileURLs: true,
                      useOnLoadResource: true,
                      useShouldInterceptRequest: true,
                    ),
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      return NavigationActionPolicy.ALLOW;
                    },
                  )
                  : Container(),
        ),
      ],
    );
  }

  _makeHtmlInitialData() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            /// html 생성
            _loadHtmlFromAssets();
            setState(() {});
          },
          child: Text('html load'),
        ),
        Expanded(
          child:
              htmlContent != ''
                  ? InAppWebView(
                    initialData: InAppWebViewInitialData(
                      data: htmlContent,
                      // baseUrl: WebUri("about:blank"),
                      encoding: "utf-8",
                      mimeType: "text/html",
                    ),

                    initialSettings: InAppWebViewSettings(
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled: true,
                      mediaPlaybackRequiresUserGesture: false,
                      useHybridComposition: true,
                      networkAvailable: true,
                    ),
                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      return NavigationActionPolicy.ALLOW;
                    },
                  )
                  : Container(),
        ),
      ],
    );
  }

  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //   // 플랫폼 상관없이 동작하는 옵션
  //   crossPlatform: InAppWebViewOptions(
  //     useShouldOverrideUrlLoading: true, // URL 로딩 제어
  //     mediaPlaybackRequiresUserGesture: false, // 미디어 자동 재생
  //     javaScriptEnabled: true, // 자바스크립트 실행 여부
  //     javaScriptCanOpenWindowsAutomatically: true, // 팝업 여부
  //   ),
  //   // 안드로이드 옵션
  //   android: AndroidInAppWebViewOptions(
  //     useHybridComposition: true, // 하이브리드 사용을 위한 안드로이드 웹뷰 최적화
  //   ),
  //   // iOS 옵션
  //   ios: IOSInAppWebViewOptions(
  //     allowsInlineMediaPlayback: true, // 웹뷰 내 미디어 재생 허용
  //   ),
  // );
}
