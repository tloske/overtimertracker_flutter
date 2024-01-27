import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider extends ChangeNotifier {
  AdProvider() {
    loadAd();
  }

  bool _bShowAd = true;

  bool get bShowAd => _bShowAd;

  set bShowAd(bool value) {
    _bShowAd = value;
    notifyListeners();
  }

  BannerAd? bannerAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load:$err');
          ad.dispose();
          notifyListeners();
        },
      ),
      request: const AdRequest(),
    )..load();
  }
}
