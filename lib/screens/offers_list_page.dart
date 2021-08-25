import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mfo_showcase_app/cubit/offer_list_cubit.dart';
import 'package:mfo_showcase_app/widgets/html_widget.dart';
import 'package:mfo_showcase_app/widgets/offer_card.dart';
import 'package:mfo_showcase_app/widgets/text_with_header.dart';

class OffersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferListCubit, OfferListState>(
      builder: (context, state) {
        final elements = [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/money_bg.6cf790b0.png"),
                      fit: BoxFit.cover),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    TextWithHeader(
                      text: "14",
                      header: "ФИНАНСОВЫХ ПРОДУКТОВ",
                    ),
                    TextWithHeader(
                      text: "73",
                      header: "ВЫДАННЫХ ЗАЙМОВ ВЧЕРА",
                    ),
                    TextWithHeader(
                      text: "1 971 000 ₽",
                      header: "ВЫДАНО СРЕДСТВ",
                    ),
                    TextWithHeader(
                      text: "98 %",
                      header: "ОДОБРЕНИЙ",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Мгновенные займы онлайн до 100000р с одобрением!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 21),
                ),
                const SizedBox(height: 8),
                Text(
                  "Выберите МФО, отправьте заявки и мы поможем в получении денег!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
        ];

        if (state is OfferListLoading) {
          elements.add(
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state is OfferListFail) {
          elements.add(
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Center(
                child: Text("Произошла ошибка при загрузке"),
              ),
            ),
          );
        }

        if (state is OfferOpened) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OfferListLoaded) {
          elements.addAll(state.offerList.map((offer) {
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: OfferCard(offer: offer));
          }));

          elements.add(HtmlWidget());
        }

        return ListView(children: elements);
      },
    );
  }

  Container _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF02CD88),
            const Color(0xFF039AF0),
          ], // red to yellow
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/moyzaem.com.svg",
            ),
            Text(
              "Заполнение двух и более заявок увеличит ваш шанс по получение займа",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}






