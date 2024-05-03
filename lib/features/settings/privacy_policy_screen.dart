import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/init/remote_config_service.dart';
import 'package:template/shared/base_screen.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      navigationBar: const CupertinoNavigationBar(),
      bottom: false,
      child: Builder(builder: (context) {
        final privacyPolicy = GetIt.I<RemoteConfigService>().privacyPolicy;
        if (privacyPolicy != null && privacyPolicy != '') {
          return InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(privacyPolicy),
            ),
          );
        } else {
          return const Center(
            child: Text('Failed to load Privacy Policy'),
          );
        }
      }),
    );
  }
}
