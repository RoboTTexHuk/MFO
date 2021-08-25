
class Offer {
  final String typeIcon;
  final String innerText;
  final String offerLabelIcon;
  final String offerLabelText;
  final String offerLogo;
  final String offerSum;
  final String offerPercent;
  final String offerAge;
  final String offerTime;
  final String offerDocs;
  final String offerLink;

  Offer(
      {this.typeIcon,
      this.innerText,
      this.offerLabelIcon,
      this.offerLabelText,
      this.offerLogo,
      this.offerSum,
      this.offerPercent,
      this.offerAge,
      this.offerTime,
      this.offerDocs,
      this.offerLink});

  factory Offer.fromJson(Map<String, dynamic> json) =>
      _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);

}

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    typeIcon: json['typeIcon'] as String,
    innerText: json['innerText'] as String,
    offerLabelIcon: json['offerLabelIcon'] as String,
    offerLabelText: json['offerLabelText'] as String,
    offerLogo: json['offerLogo'] as String,
    offerSum: json['offerSum'] as String,
    offerPercent: json['offerPercent'] as String,
    offerAge: json['offerAge'] as String,
    offerTime: json['offerTime'] as String,
    offerDocs: json['offerDocs'] as String,
    offerLink: json['offerLink'] as String,
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
  'typeIcon': instance.typeIcon,
  'innerText': instance.innerText,
  'offerLabelIcon': instance.offerLabelIcon,
  'offerLabelText': instance.offerLabelText,
  'offerLogo': instance.offerLogo,
  'offerSum': instance.offerSum,
  'offerPercent': instance.offerPercent,
  'offerAge': instance.offerAge,
  'offerTime': instance.offerTime,
  'offerDocs': instance.offerDocs,
  'offerLink': instance.offerLink,
};
