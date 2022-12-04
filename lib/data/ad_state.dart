import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'dart:async';
import 'dart:io';

class AdState {
  Future<InitializationStatus>? initialization;
  AdState(this.initialization);

  String get bannerAdUnitID => Platform.isAndroid
      ? "ca-app-pub-4144877982953525/5392878278"
      : "ca-app-pub-3940256099942544/2934735716";

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => log('Ad loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => log("Ad closed: ${ad.adUnitId}"),
    onAdFailedToLoad: (ad, error) =>
        log("Ad failed to load: ${ad.adUnitId}, $error"),
    onAdOpened: (ad) => log("Ad opened: ${ad.adUnitId}"),
    onAdClicked: (ad) => log("Ad clicked: ${ad.adUnitId}"),
    onAdImpression: (ad) => log("Ad impression: ${ad.adUnitId}"),
    onAdWillDismissScreen: (ad) => log("Ad wild dismiss: ${ad.adUnitId}"),
    onPaidEvent: (ad, valueMicros, precision, currencyCode) => log(
        "Ad paid event: ${ad.adUnitId}, $valueMicros,$precision,$currencyCode"),
  );
}

final adStateProvider = Provider((ref) {
  final initFuture = MobileAds.instance.initialize();
  return AdState(initFuture);
});
