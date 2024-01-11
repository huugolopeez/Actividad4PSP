import 'package:flutter/foundation.dart';

class PlatformAdmin {

  int platformDifference() {
    if (kIsWeb) {
      return 0;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 1;
      case TargetPlatform.iOS:
        return 2;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  String getImage(String sUrlImage) {
    int platform = platformDifference();

    switch (platform) {
      case 0:
        return 'assets/web/imagenes/$sUrlImage';
      case 1:
        return 'assets/android/imagenes/$sUrlImage';
      case 2:
        return 'assets/ios/imagenes/$sUrlImage';
      default:
        return 'error';
    }
  }

  String getFont() {
    int platform = platformDifference();

    switch (platform) {
      case 0:
        return 'Roboto';
      case 1:
        return 'Oswald';
      case 2:
        return 'MavenPro';
      default:
        return 'error';
    }
  }
}