
import '../GetNewData.dart';
import 'api_provider.dart';
import 'dart:io' show File, Platform;
import 'package:sampleapp/utils/api_constants.dart' as _apiconstants;


ApiProvider _provider = ApiProvider();

Future<GetNewDataLister> getCardDatum() async {
  final response = await _provider.get(_apiconstants.getApi);
  return GetNewDataLister.fromJson(response);
}

// Future<CreateProjects> createProject(var body) async {
//   final response = await _provider.post(_apiconstants.createProjectApi, body);
//   return CreateProjects.fromJson(response);
// }


// put the data

// Future<UpdateResponse> updateProjects(String?id,var body) async {
//   final response = await _provider.update(_apiconstants.createProjectApi+"/"+id!,body);
//   return UpdateResponse.fromJson(response);
// }

// delete api

// Future<DeleteResponse> delete(String? id) async {
//   final response = await _provider.delete(_apiconstants.createProjectApi+"/"+id!);
//   return DeleteResponse.fromJson(response);
// }





