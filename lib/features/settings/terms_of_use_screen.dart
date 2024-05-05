import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/service/remote_config_service.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/base_screen.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      navigationBar: CupertinoNavigationBar(
        middle: Text(S.of(context).termsOfUse),
        border: null,
      ),
      bottom: false,
      child: Builder(builder: (context) {
        final privacyPolicy = GetIt.I<RemoteConfigService>().termsOfUse;
        if (privacyPolicy != null && privacyPolicy != '') {
          return InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(privacyPolicy),
            ),
          );
        } else {
          return Center(
            child: Text(S.of(context).failedToLoadTermsOfUse),
          );
        }
      }),
    );
  }
}
