class ConfirmResult {
  final String id;
  final String logId;
  final String result;
  final String info;

  ConfirmResult({
    this.id,
    this.logId,
    this.result,
    this.info,
  });

  factory ConfirmResult.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResultFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmResultToJson(this);
}

ConfirmResult _$ConfirmResultFromJson(Map<String, dynamic> json) {
  return ConfirmResult(
    id: json['id'] as String,
    logId: json['logId'] as String,
    result: json['result'] as String,
    info: json['info'] as String,
  );
}

Map<String, dynamic> _$ConfirmResultToJson(ConfirmResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logId': instance.logId,
      'result': instance.result,
      'info': instance.info,
    };
