import 'dart:convert';
import 'dart:typed_data';

import 'package:openapi_petstore/_internal.dart';
import 'package:xml/xml.dart';

part 'pet.reflection.dart';
part 'pet.serialization.dart';

mixin PetMixin {
  ///1. name accepts String only:
  /// required = true
  /// isNullable = false
  String get name1;

  ///2. name accepts String or null:
  /// required = true
  /// isNullable = true
  String? get name2;

  ///3. name accepts String or undefined:
  /// required = false
  /// isNullable = false
  UndefinedWrapper<String> get name3;

  ///4. name accepts String or null or undefined:
  /// required = false
  /// isNullable = true
  UndefinedWrapper<String?> get name4;

  ///5. imageBytes accepts Uint8List or null or undefined
  /// Nullable: true
  /// Required: false
  UndefinedWrapper<Uint8List?> get imageBytes;

  /// Nested list of pets
  /// Nullable: false
  /// Required: false
  UndefinedWrapper<List<List<List<Pet>>>> get childPets;

  /// There can only be a single additionalProperties per class
  AdditionalProperties<dynamic> get additionalProperties;
}

extension type const AdditionalProperties<T>._(Map<String, T> src)
    implements Map<String, dynamic> {
  const AdditionalProperties([Map<String, T> src = const {}]) : this._(src);
  factory AdditionalProperties.srcExcept(
    Map<String, T> src,
    Set<String> toRemove,
  ) =>
      AdditionalProperties(
        Map.fromEntries(src.entries.where((e) => !toRemove.contains(e.key))),
      );
}

//one of a,b
// enum PetOneOfCase { a, b }
// PetOneOfCase get case;
// UndefinedWrapper<A> asA;
// UndefinedWrapper<B> asB;

/// A class describing a pet
class Pet with PetMixin {
  @override
  UndefinedWrapper<Uint8List?> imageBytes;

  @override
  String name1;

  @override
  String? name2;

  @override
  UndefinedWrapper<String> name3;

  @override
  UndefinedWrapper<String?> name4;

  @override
  UndefinedWrapper<List<List<List<Pet>>>> childPets;

  @override
  AdditionalProperties additionalProperties;

  /// Use the `all` constructor when creating a new instance of this class in
  /// deserialization or copyWith operations.
  Pet.$all({
    required this.imageBytes,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.childPets,
    required this.additionalProperties,
  });

  Pet({
    this.imageBytes = const UndefinedWrapper.undefined(),
    required this.name1,
    this.name2,
    this.name3 = const UndefinedWrapper.undefined(),
    this.name4 = const UndefinedWrapper.undefined(),
    this.childPets = const UndefinedWrapper.undefined(),
    this.additionalProperties = const AdditionalProperties(),
  });

  // ====== JSON ======
  static const $jsonReflection = PetJsonReflection.instance;

  /// Serializes a [Pet] to a json Map.
  Map<String, dynamic> toJson() => _$PetToJson(this);

  /// Deserializes a json Map into [Pet].
  factory Pet.fromJson(Map<String, dynamic> src) => _$PetFromJson(src);

  // ====== XML ======
  static const $xmlReflection = PetXmlReflection.instance;

  XmlElement toXml() => _$PetToXml(this);

  factory Pet.fromXml(XmlElement src) => _$PetFromXml(src);
}

extension type const Status._(String src) {
  const Status.ready() : this._(r'ready');
  const Status.notReady() : this._(r'notReady');
  factory Status.$safe(String src) {
    final res = values.where((element) => element.src == src).firstOrNull;
    if (res == null) {
      throw 'Invalid enum value $src';
    }
    return res;
  }
  const Status.$unsafe(String src) : this._(src);

  static const List<Status> values = [
    Status.ready(),
    Status.notReady(),
  ];
}
