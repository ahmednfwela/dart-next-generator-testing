part of 'pet.dart';

/// Reflection for the [Pet] class.
class PetJsonReflection extends JsonClassReflection<Pet> {
  static const PetJsonReflection instance = PetJsonReflection._(
    name1: JsonPropertyReflection(
      dartName: 'name1',
      nullable: false,
      required: true,
      oasName: 'name1',
      oasType: 'string',
      $default: null,
    ),
    name2: JsonPropertyReflection(
      dartName: 'name2',
      nullable: true,
      required: true,
      oasName: 'name2',
      oasType: 'string',
      $default: null,
    ),
    name3: JsonPropertyReflection(
      dartName: 'name3',
      nullable: false,
      required: false,
      oasName: 'name3',
      oasType: 'string',
      $default: null,
    ),
    name4: JsonPropertyReflection(
      dartName: 'name4',
      nullable: true,
      required: false,
      oasName: 'name4',
      oasType: 'string',
      $default: null,
    ),
    imageBytes: JsonPropertyReflection(
      dartName: r'imageBytes',
      nullable: true,
      required: false,
      oasName: r'imageBytes',
      oasType: 'string',
      $default: null,
    ),
  );

  const PetJsonReflection._({
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.imageBytes,
  });

  @override
  Type get type => Pet;

  final JsonPropertyReflection name1;
  final JsonPropertyReflection name2;
  final JsonPropertyReflection name3;
  final JsonPropertyReflection name4;
  final JsonPropertyReflection imageBytes;

  @override
  List<JsonPropertyReflection> get members => [
        name1,
        name2,
        name3,
        name4,
        imageBytes,
      ];

  @override
  Pet Function(Map<String, dynamic> json) get fromJsonFunction =>
      (json) => Pet.fromJson(json);

  @override
  Map<String, dynamic> Function(Pet src) get toJsonFunction =>
      (src) => src.toJson();
}

class PetXmlReflection extends XmlClassReflection<Pet> {
  static const PetXmlReflection instance = PetXmlReflection._(
    oasName: 'Pet',
    oasNamespace: null,
    childPets: XmlElementReflection(
      dartName: 'childPets',
      oasName: 'children',
      oasType: 'array',
      required: false,
      nullable: false,
    ),
    name1: XmlAttributeReflection(
      dartName: 'name1',
      nullable: false,
      required: true,
      oasName: 'name1',
      oasType: 'string',
      oasNamespace: null,
    ),
    name2: XmlElementReflection(
      dartName: 'name2',
      nullable: true,
      required: true,
      oasName: 'name2',
      oasType: 'string',
      $default: null,
    ),
    name3: XmlElementReflection(
      dartName: 'name3',
      nullable: false,
      required: false,
      oasName: 'name3',
      oasType: 'string',
      $default: null,
    ),
    name4: XmlElementReflection(
      dartName: 'name4',
      nullable: true,
      required: false,
      oasName: 'name4',
      oasType: 'string',
      $default: null,
    ),
    imageBytes: XmlElementReflection(
      dartName: r'imageBytes',
      nullable: true,
      required: false,
      oasName: r'imageBytes',
      oasType: 'string',
      $default: null,
    ),
  );

  const PetXmlReflection._({
    required this.oasName,
    required this.oasNamespace,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.imageBytes,
    required this.childPets,
  });

  @override
  Type get type => Pet;

  final String oasName;
  final String? oasNamespace;

  final XmlAttributeReflection name1;
  final XmlElementReflection name2;
  final XmlElementReflection name3;
  final XmlElementReflection name4;
  final XmlElementReflection imageBytes;
  final XmlElementReflection childPets;

  @override
  List<XmlAttributeReflection> get attributes => [
        name1,
      ];

  @override
  List<XmlElementReflection> get children => [
        name2,
        name3,
        name4,
        imageBytes,
        childPets,
      ];

  @override
  Pet Function(XmlElement json) get fromXmlFunction =>
      (json) => Pet.fromXml(json);

  @override
  XmlElement Function(Pet src) get toXmlFunction => (src) => src.toXml();
}

class StatusJsonReflection {
  static const ready = JsonEnumMemberReflection(
    dartName: r'ready',
    oasValue: r'ready',
  );
}

class StatusXmlReflection {
  static const XmlEnumMemberReflection ready = XmlEnumMemberReflection(
    dartName: r'ready',
    oasValue: r'ready',
  );
}
