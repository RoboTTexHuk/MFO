import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mfo_showcase_app/cubit/offer_list_cubit.dart';
import 'package:mfo_showcase_app/model/offer.dart';
import 'package:mfo_showcase_app/widgets/left_header_text_widget.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor;

    if (offer.typeIcon == "offers__item_like") {
      borderColor = const Color(0xFF039AF0);
    }

    if (offer.typeIcon == "offers__item_stock") {
      borderColor = const Color(0xFF02CD88);
    }

    return Card(
      shape: borderColor != null
          ? RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: 2.0),
              borderRadius: BorderRadius.circular(6.0),
            )
          : null,
      child: Column(
        children: [
          _buildType(borderColor),
          _buildLabel(borderColor != null),
          const SizedBox(height: 16),
          _buildIcon(),
          _buildWrapTable(),
          const SizedBox(height: 8),
          MaterialButton(
            child: Text(
              "ОФОРМИТЬ ЗАЙМ",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            color: Color(0xFF138DDB),
            textColor: Colors.white,
            onPressed: () => BlocProvider.of<OfferListCubit>(context)
                .openOfferLink(offer.offerLink),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLabel(bool hasType) {
    return Row(
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(hasType ? 0 : 6)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF02CD88),
                  const Color(0xFF039AF0)
                ], // red to yellow
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/" + offer.offerLabelIcon,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    offer.offerLabelText,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Wrap _buildWrapTable() {
    return Wrap(
      children: [
        LeftHeaderTextWidget(
          header: "СУММА",
          text: offer.offerSum,
        ),
        LeftHeaderTextWidget(
          header: "ПРОЦЕНТ",
          text: offer.offerPercent,
        ),
        LeftHeaderTextWidget(
          header: "ВОЗРАСТ",
          text: offer.offerAge,
        ),
        LeftHeaderTextWidget(
          header: "СРОК",
          text: offer.offerTime,
        ),
        LeftHeaderTextWidget(
          header: "ДОКУМЕНТЫ",
          text: offer.offerDocs,
        ),
      ],
    );
  }

  Widget _buildIcon() {
    final width = 150.0;
    final height = 80.0;

    if (offer.offerLogo.contains("http")) {
      if (offer.offerLogo.contains("svg")) {
        return SvgPicture.network(
          offer.offerLogo,
          width: width,
          height: height,
          fit: BoxFit.scaleDown,
        );
      }

      return Image.network(
        offer.offerLogo,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
      );
    }

    if (offer.offerLogo.contains("svg")) {
      return SvgPicture.asset(
        "assets/logo/" + offer.offerLogo,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
      );
    }

    return Image.asset(
      "assets/logo/" + offer.offerLogo,
      width: width,
      height: height,
      fit: BoxFit.scaleDown,
    );
  }

  Widget _buildType(Color borderColor) {
    if (borderColor == null) {
      return SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
      child: Container(
        color: borderColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/" + offer.typeIcon + ".png",
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8),
              Text(
                offer.innerText,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
