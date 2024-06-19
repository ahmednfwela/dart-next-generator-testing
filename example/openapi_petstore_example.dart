import 'package:openapi_petstore/openapi_petstore.dart';

Future<void> main() async {
  final serverUrl = Uri.parse('https://example.com/api?client=dart');
  var api = OpenApiPetStore(
    networkingClient: PackageHttpNetworkingClient(),
    baseUrl: serverUrl,
  );
  final petsApi = api.petsApi;
  final petsResponse = await petsApi.getPets(
    PetsApiGetPetsRequest(
      limit: 10,
      skip: 20,
    ),
  );

  final data = petsResponse.split<List<Pet>?>(
    on200: (r) => r.split200(
      onApplicationJson: (p0) => p0.data,
      onApplicationXml: (p0) => p0.data,
      onTextPlain: (p0) => null,
      onOther: (p0) => null,
    ),
    on401: (p0) => null,
    onOther: (p0) => null,
  );
  if (data != null) {
    print('fetched ${data.length} pets');
  } else {
    print(
      'was not able to fetch pets, returned headers: ${petsResponse.response.headers}.',
    );
  }
}
