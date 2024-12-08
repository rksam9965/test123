
import '../GetNewData.dart';
import 'api_provider.dart';
import 'dart:io' show File, Platform;
import 'package:sampleapp/utils/api_constants.dart' as _apiconstants;


ApiProvider _provider = ApiProvider();

Future<GetNewDataLister> getCardDatum() async {
  final response = await _provider.get(_apiconstants.getApi);
  return GetNewDataLister.fromJson(response);
}




