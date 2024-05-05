import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  String? get privacyPolicy => _remoteConfig.getString("privacy_policy");
  String? get termsOfUse => _remoteConfig.getString("terms_of_use");
  String? get promotion => _remoteConfig.getString("promotion");
  String? get subscription => _remoteConfig.getString("subscription");
  String? get key => _remoteConfig.getString("api_key");
}
