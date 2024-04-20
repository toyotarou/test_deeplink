import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

//==============================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _sub;

  ///
  @override
  void initState() {
    init();
    super.initState();
  }

  ///
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  ///
  Future<void> init() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final host = uri.host; // myapp

        switch (host) {
          case 'page1': // myapp://page1
            pushPage(const Page1());
            break;

          case 'page2': // myapp://page2
            pushPage(const Page2());
            break;
        }
      }
    });
  }

  ///
  Future<void> pushPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hyperlinkButton('myapp://page1'), // myapp://page1 を開くボタン
            hyperlinkButton('myapp://page2'), // myapp://page2 を開くボタン
          ],
        ),
      ),
    );
  }

  ///
  Widget hyperlinkButton(String url) {
    final uri = Uri.parse(url);

    return ElevatedButton(
      onPressed: () async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri); // URLを開く
        }
      },
      child: Text(url),
    );
  }
}

//==============================================

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Page1')),
    );
  }
}

//==============================================

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Page2')),
    );
  }
}
