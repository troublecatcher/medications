import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/init/remote_config_service.dart';
import 'package:template/shared/base_screen.dart';

@RoutePage()
class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(GetIt.I<RemoteConfigService>().promotion!),
        ),
      ),
    );
  }
}
