import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfo_showcase_app/constants.dart';
import 'package:mfo_showcase_app/model/confirm_result.dart';
import 'package:mfo_showcase_app/support/flutter_webview_plugin.dart';
import 'package:mfo_showcase_app/support/support_innitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'offer_list_cubit.dart';

part 'confirm_state.dart';

class ConfirmCubit extends Cubit<ConfirmState> {
  final OfferListCubit offerListCubit;

  ConfirmCubit(this.offerListCubit) : super(ConfirmInitial());

  checkAuthorization() async {
    emit(ConfirmLoading());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    ConfirmResult confirmResult;

    if (prefs.containsKey("id")) {

      confirmResult = ConfirmResult(
        id: prefs.getString("id"),
        logId: prefs.getString("logId"),
        result: prefs.getString("result"),
        info: prefs.getString("info"),
      );
    }

    String appsFlyerDeviceId =
        await SupportLibraryInnitor.appsflyerSdk.getAppsFlyerUID();
    String advertisingId = await AdvertisingIdPlugin.getAdvertisingId();
    String referrer = await FacebookAppLinkPlugin.fetchFacebookAppLink();

    var postParameters = {
      'id': prefs.getString("id") ?? "",
      'appName': ApplicationConstants.APPLICATION_ID,
      'advertisingId': advertisingId,
      'referrer': referrer,
      'appsFlyerDeviceId': appsFlyerDeviceId,
    };

    try {
      final domain =
          prefs.getString("domain") ?? await DomainGetter.getDomain();

      if (domain.isEmpty) {
        throw Exception();
      } else {
        prefs.setString("domain", domain);
      }

      final response = await http.post(domain, body: postParameters);

      Map<String, dynamic> jsonResult = json.decode(response.body);

      if (jsonResult.containsKey("result")) {

        confirmResult = ConfirmResult(
          id: jsonResult["id"],
          logId: jsonResult["logId"],
          result: jsonResult["result"],
          info: jsonResult["info"],
        );

        prefs.setString("id", confirmResult.id);
        prefs.setString("logId", confirmResult.logId);
        prefs.setString("result", confirmResult.result.replaceAll(RegExp("&event4=1"), ""));
        prefs.setString("info", confirmResult.info);
      }

    } catch (e, s) {
      print(e);
      print(s);
    }

    if (confirmResult != null && confirmResult.result.isNotEmpty) {
      emit(ConfirmPass(confirmResult));
      offerListCubit.loadOffers(confirmResult);
    } else {
      emit(ConfirmFail());
    }
  }
}

class DomainGetter {
  static Future<String> getDomain() async {
    final response = await http.get(ApplicationConstants.PASTBIN_LINK);
    return response.body;
  }
}

