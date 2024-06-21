part of 'pets_api.dart';

class PetsApiGetPetsRequest {
  static const urlPathTemplate = r'/pets';
  static const method = r'GET';

  final Map<String, String> extraHeaders;
  final Map<String, Object /* String | List<String> */> extraQueryParameters;
  // Add path, query, header, cookie parameters here.
  final int skip;
  final int limit;

  PetsApiGetPetsRequest({
    this.skip = 0,
    required this.limit,
    this.extraHeaders = const {},
    this.extraQueryParameters = const {},
  });

  Future<Uri> getResolvedUri({
    required Uri baseUrl,
    Map<String, dynamic> context = const {},
  }) async {
    return baseUrl.replace(
      pathSegments: [
        ...baseUrl.pathSegments,
        ...url.pathSegments,
      ],
      queryParameters: {
        ...baseUrl.queryParameters,
        ...url.queryParameters,
        'skip': skip.toString(),
        'limit': limit.toString(),
      },
    );
  }

  Future<Map<String, String>> getResolvedHeaders({
    Map<String, dynamic> context = const {},
  }) async {
    return const {};
  }

  Stream<List<int>> getResolvedBody({
    Map<String, dynamic> context = const {},
  }) async* {}

  Future<HttpRequestBase> createHttpRequest({
    required Uri baseUrl,
    Map<String, dynamic> context = const {},
  }) async {
    final futures = [
      getResolvedUri(
        context: context,
        baseUrl: baseUrl,
      ),
      getResolvedHeaders(context: context),
    ];
    final futureResults = await Future.wait(futures);
    // Add any path/query parameters to the knownUrl.
    return HttpRequestBase.stream(
      url: futureResults[0] as Uri,
      headers: futureResults[1] as Map<String, String>,
      method: method,
      bodyBytesStream: getResolvedBody(context: context),
      context: context,
    );
  }

  const factory PetsApiGetPetsRequest.json({
    int skip,
    required int limit,
    required List<Pet> pets,
  }) = PetsApiGetPetsRequestApplicationJson;
}

class PetsApiGetPetsRequestApplicationJson extends PetsApiGetPetsRequest {
  const PetsApiGetPetsRequestApplicationJson({
    required super.limit,
    super.skip,
    required this.pets,
  });

  final List<Pet> pets;

  @override
  Stream<List<int>> getResolvedBody({
    Map<String, dynamic> context = const {},
  }) async* {
    yield utf8.encode(jsonEncode(pets.map((v) => v.toJson()).toList()));
  }
}

class PetsApiGetPetsResponse {
  const PetsApiGetPetsResponse({
    required this.response,
  });

  static Future<PetsApiGetPetsResponse> fromResponse(
    HttpResponseBase response, {
    Map<String, dynamic> context = const {},
  }) async {
    Future<String> getStringResponse() async {
      final charset = response.normalizedCharset;
      if (charset == null) {
        // non-text response is wanted
        throw 'non text response is not supported';
      }
      final decoded = await Encoding.getByName(charset)
          ?.decodeStream(response.bodyBytesStream);
      if (decoded == null) {
        throw 'decoding bytes into charset $charset failed';
      }
      return decoded;
    }

    if (OASNetworkingUtils.matchesStatusCodePattern(
      response.statusCode,
      '200',
    )) {
      //
      if (OASNetworkingUtils.matchesMimeTypePattern(
        response.contentType,
        'application/json',
      )) {
        final decoded = await getStringResponse();
        final parsed = jsonDecode(decoded);
        final result = (parsed as List).map((x) => Pet.fromJson(x)).toList();
        return PetsApiGetPetsResponse200ApplicationJson(
          data: result,
          response: response,
        );
      } else if (OASNetworkingUtils.matchesMimeTypePattern(
        response.contentType,
        'application/xml',
      )) {
        final decoded = await getStringResponse();
        final parsedXml = XmlDocument.parse(decoded);
        final result = parsedXml.childElements
            .where(
              (element) =>
                  element.name.local == Pet.$xmlReflection.oasName &&
                  element.namespacePrefix == Pet.$xmlReflection.oasNamespace,
            )
            .map(Pet.fromXml)
            .toList();
        return PetsApiGetPetsResponse200ApplicationXml(
          data: result,
          response: response,
        );
      } else if (OASNetworkingUtils.matchesMimeTypePattern(
        response.contentType,
        'text/plain',
      )) {
        final decoded = await getStringResponse();
        final result = decoded;
        return PetsApiGetPetsResponse200TextPlain(
          data: result,
          response: response,
        );
      } else {
        return PetsApiGetPetsResponse200(response: response);
      }
    } else if (OASNetworkingUtils.matchesStatusCodePattern(
      response.statusCode,
      '401',
    )) {
      final decoded = await getStringResponse();
      final result = decoded;
      return PetsApiGetPetsResponse401(
        response: response,
        data: result,
      );
    } else {
      return PetsApiGetPetsResponse(
        response: response,
      );
    }
  }

  @nonVirtual
  T split<T>({
    required T Function(PetsApiGetPetsResponse200) on200,
    required T Function(PetsApiGetPetsResponse401) on401,
    required T Function(PetsApiGetPetsResponse) onOther,
  }) {
    switch (this) {
      case PetsApiGetPetsResponse200 r:
        return on200(r);
      case PetsApiGetPetsResponse401 r:
        return on401(r);
      default:
        return onOther(this);
    }
  }

  final HttpResponseBase response;
}

class PetsApiGetPetsResponse200 extends PetsApiGetPetsResponse {
  const PetsApiGetPetsResponse200({
    required super.response,
  });

  T split200<T>({
    required T Function(PetsApiGetPetsResponse200ApplicationJson)
        onApplicationJson,
    required T Function(PetsApiGetPetsResponse200ApplicationXml)
        onApplicationXml,
    required T Function(PetsApiGetPetsResponse200TextPlain) onTextPlain,
    required T Function(PetsApiGetPetsResponse200) onOther,
  }) {
    return switch (this) {
      PetsApiGetPetsResponse200ApplicationJson r => onApplicationJson(r),
      PetsApiGetPetsResponse200ApplicationXml r => onApplicationXml(r),
      PetsApiGetPetsResponse200TextPlain r => onTextPlain(r),
      _ => onOther(this),
    };
  }
}

class PetsApiGetPetsResponse200ApplicationJson
    extends PetsApiGetPetsResponse200 {
  const PetsApiGetPetsResponse200ApplicationJson({
    required super.response,
    required this.data,
  });
  final List<Pet> data;
}

class PetsApiGetPetsResponse200ApplicationXml
    extends PetsApiGetPetsResponse200 {
  const PetsApiGetPetsResponse200ApplicationXml({
    required super.response,
    required this.data,
  });
  final List<Pet> data;
}

class PetsApiGetPetsResponse200TextPlain extends PetsApiGetPetsResponse200 {
  const PetsApiGetPetsResponse200TextPlain({
    required super.response,
    required this.data,
  });
  final String data;
}

class PetsApiGetPetsResponse401 extends PetsApiGetPetsResponse {
  final String data;

  const PetsApiGetPetsResponse401({
    required this.data,
    required super.response,
  });
}
