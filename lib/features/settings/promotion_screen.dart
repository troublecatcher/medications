import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/service/remote_config_service.dart';
import 'package:template/shared/base_screen.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bottom: false,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(GetIt.I<RemoteConfigService>().promotion!),
        ),
      ),
    );
  }
}
