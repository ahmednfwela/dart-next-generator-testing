import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:openapi_petstore/_internal.dart';
import 'package:xml/xml.dart';

part 'pets_api.models.dart';

class PetsApi {
  final NetworkingClientBase networkingClient;
  final Uri baseUrl;
  final Map<String, dynamic> context;

  const PetsApi({
    required this.networkingClient,
    required this.baseUrl,
    this.context = const {},
  });

  Future<PetsApiGetPetsResponse> getPets(
    PetsApiGetPetsRequest request, {
    Map<String, dynamic> context = const {},
  }) async {
    final newContext = {...this.context, ...context};
    final httpRequest = await request.createHttpRequest(
      context: newContext,
      baseUrl: baseUrl,
    );
    final response = await networkingClient.sendRequest(httpRequest);
    return PetsApiGetPetsResponse.fromResponse(
      response,
      context: newContext,
    );
  }
}
