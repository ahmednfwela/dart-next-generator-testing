import 'package:std_uritemplate/std_uritemplate.dart';

abstract class OpenApiParameterSerialization {
  final bool explode;
  final String parameterName;

  const OpenApiParameterSerialization({
    required this.parameterName,
    required this.explode,
  });

  String get appendExplode => explode ? '*' : '';

  String get oldParameterPlaceHolder => '{$parameterName}';
}

/// in: path ------------------

abstract class OpenApiParameterSerializationPath
    extends OpenApiParameterSerialization {
  const OpenApiParameterSerializationPath({
    required super.explode,
    required super.parameterName,
  });
  String modifyTemplateToRFC6570(String template);
}

class OpenApiParameterSerializationPathSimple
    extends OpenApiParameterSerializationPath {
  const OpenApiParameterSerializationPathSimple({
    required super.explode,
    required super.parameterName,
  });

  @override
  String modifyTemplateToRFC6570(String template) {
    return template.replaceAll(
      oldParameterPlaceHolder,
      '{$parameterName$appendExplode}',
    );
  }
}

class OpenApiParameterSerializationPathLabel
    extends OpenApiParameterSerializationPath {
  const OpenApiParameterSerializationPathLabel({
    required super.explode,
    required super.parameterName,
  });

  @override
  String modifyTemplateToRFC6570(String template) {
    return template.replaceAll(
      oldParameterPlaceHolder,
      '{.$parameterName$appendExplode}',
    );
  }
}

class OpenApiParameterSerializationPathMatrix
    extends OpenApiParameterSerializationPath {
  const OpenApiParameterSerializationPathMatrix({
    required super.explode,
    required super.parameterName,
  });

  @override
  String modifyTemplateToRFC6570(String template) {
    return template.replaceAll(
      oldParameterPlaceHolder,
      '{;$parameterName$appendExplode}',
    );
  }
}

// in: query ------------------

abstract class OpenApiParameterSerializationQuery
    extends OpenApiParameterSerialization {
  const OpenApiParameterSerializationQuery({
    required super.explode,
    required super.parameterName,
    required this.allowEmptyValue,
  });
  final bool allowEmptyValue;

  /// The templates passed here are valid [Uri]s missing query parameters
  Uri expandUri(Uri template, Object? value) {
    if ((value == null ||
            (value is String && value.isEmpty) ||
            (value is Iterable && value.isEmpty)) &&
        !allowEmptyValue) {
      return template;
    }
    return template.replace(queryParameters: {
      ...template.queryParameters,
      parameterName: value,
    });
  }
}

/// Default behavior is the same as [OpenApiParameterSerializationQuery].
class OpenApiParameterSerializationQueryForm
    extends OpenApiParameterSerializationQuery {
  const OpenApiParameterSerializationQueryForm({
    required super.explode,
    required super.parameterName,
    required super.allowEmptyValue,
  });
}

class OpenApiParameterSerializationQuerySpaceDelimited
    extends OpenApiParameterSerializationQuery {
  const OpenApiParameterSerializationQuerySpaceDelimited({
    required super.explode,
    required super.parameterName,
    required super.allowEmptyValue,
  });

  @override
  Uri expandUri(
    Uri template,
    Object? value,
  ) {
    if (value is Iterable) {
      value = value.join(' ');
    }

    return super.expandUri(template, value);
  }
}

class OpenApiParameterSerializationQueryPipeDelimited
    extends OpenApiParameterSerializationQuery {
  const OpenApiParameterSerializationQueryPipeDelimited({
    required super.explode,
    required super.parameterName,
    required super.allowEmptyValue,
  });

  @override
  Uri expandUri(
    Uri template,
    Object? value,
  ) {
    if (value is Iterable) {
      value = value.join('|');
    }

    return super.expandUri(template, value);
  }
}

class OpenApiParameterSerializationQueryDeepObject
    extends OpenApiParameterSerializationQuery {
  const OpenApiParameterSerializationQueryDeepObject({
    required super.explode,
    required super.parameterName,
    required super.allowEmptyValue,
  });

  @override
  Uri expandUri(
    Uri template,
    Object? value,
  ) {
    if (value is Map) {
      return template.replace(queryParameters: {
        ...template.queryParameters,
        ...value.map(
          (key, v) => MapEntry('$parameterName[$key]', v),
        ),
      });
    }
    return super.expandUri(template, value);
  }
}

/// in: header ------------------

class OpenApiParameterSerializationHeader
    extends OpenApiParameterSerialization {
  const OpenApiParameterSerializationHeader({
    required super.explode,
    required super.parameterName,
  });

  //Style is always "simple"
  String serialize(Object? value) {
    return StdUriTemplate.expand('{$parameterName$appendExplode}', {
      parameterName: value,
    });
  }
}

/// in: cookie ------------------

class OpenApiParameterSerializationCookie
    extends OpenApiParameterSerialization {
  const OpenApiParameterSerializationCookie({
    required super.explode,
    required super.parameterName,
  });

  String serialize(Object? value) {
    return StdUriTemplate.expand('{$parameterName$appendExplode}', {
      parameterName: value,
    });
  }
}
