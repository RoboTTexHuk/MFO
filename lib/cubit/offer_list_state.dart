

part of 'offer_list_cubit.dart';

abstract class OfferListState extends Equatable {
  const OfferListState();
}

class OfferListInitial extends OfferListState {
  @override
  List<Object> get props => [];
}

class OfferListLoading extends OfferListState {
  @override
  List<Object> get props => [];
}

class OfferListFail extends OfferListState {
  @override
  List<Object> get props => [];
}

class OfferListLoaded extends OfferListState {

  final String id;
  final List<Offer> offerList;

  OfferListLoaded({this.id, this.offerList});

  @override
  List<Object> get props => [offerList];
}

class OfferOpened extends OfferListState {
  @override
  List<Object> get props => [];
}