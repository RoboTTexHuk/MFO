import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfo_showcase_app/constants.dart';
import 'package:mfo_showcase_app/model/confirm_result.dart';
import 'package:mfo_showcase_app/model/offer.dart';
import 'package:mfo_showcase_app/support/flutter_webview_plugin.dart';
import 'package:mfo_showcase_app/support/support_innitor.dart';

part 'offer_list_state.dart';

class OfferListCubit extends Cubit<OfferListState> {

  OfferListCubit() : super(OfferListInitial());

  void loadOffers(ConfirmResult confirmResult) async {
    emit(OfferListLoading());

    try {
      // final response = await http.get(ApplicationConstants.OFFER_JSON_LINK);
      //
      // Iterable l = jsonDecode(response.body);

      Iterable l = jsonDecode(confirmResult.info);

      emit(
        OfferListLoaded(
          id: confirmResult.id,
          offerList: List<Offer>.from(l.map((model) => Offer.fromJson(model))),
        ),
      );
    } catch (e, s) {
      print(e);
      print(s);
      emit(OfferListFail());
    }
  }

  void openOfferLink(String offerLink) async {

    final clientId = (state as OfferListLoaded).id;

    emit(OfferOpened());

    String webViewLink = offerLink;

    Map<String, String> queryParameters =
        Uri.dataFromString(offerLink).queryParameters;

    if (!webViewLink.contains("?")) {
      webViewLink += "?";
    }

    if (!queryParameters.containsKey("sub2")) {
      webViewLink += "&sub2=" + ApplicationConstants.APPLICATION_ID;
    }

    if (queryParameters.containsKey("offer_id")) {
      String eventName = "offer_click_" + queryParameters["offer_id"];
      print("AppsFlyer Event - " + eventName);
      SupportLibraryInnitor.appsflyerSdk.trackEvent(eventName, {});
    }

    webViewLink += "&client_id=$clientId";

    String facebookLink = await FacebookAppLinkPlugin.fetchFacebookAppLink();
    List<String> splits = facebookLink.split("&");
    splits.removeAt(0);
    splits.insert(0, "");
    String subsParams = splits.join("&");

    webViewLink += subsParams;

    print(webViewLink);

    FlutterWebviewPlugin.startView(webViewLink);
  }
}
