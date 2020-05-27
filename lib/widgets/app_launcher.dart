import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  final String url;
  AppLauncher({@required this.url}) : assert(url != null);

  Future<void> _launchURL(String url) async {
    print('_launchURL $url');
    if (Platform.isIOS) {
      print('_launchURL ios if');
      if (await canLaunch(url)) {
        print('_launchURL ios if if');
        final bool nativeAppLaunchSucceeded =
            await launch(url, forceSafariVC: false, universalLinksOnly: true);

        print(
            '_launchURL ios nativeAppLaunchSucceeded: $nativeAppLaunchSucceeded');
        if (!nativeAppLaunchSucceeded) await launch(url, forceSafariVC: true);
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
