part of 'pet.dart';

Map<String, dynamic> _$PetToJson(Pet instance) => {
      if (!instance.imageBytes.isUndefined)
        'imageBytes': instance.imageBytes.valueRequired,
      'name1': instance.name1,
      'name2': instance.name2,
      if (!instance.name3.isUndefined) 'name3': instance.name3.valueRequired,
      if (!instance.name4.isUndefined) 'name4': instance.name4.valueRequired,
      'childPets': instance.childPets.map(
        (src) => src.map(
          (src) => src.map(
            (src) => src.map(
              (src) => src.toJson(),
            ),
          ),
        ),
      )
    };

Pet _$PetFromJson(Map<String, dynamic> src) {
  return Pet.$all(
    imageBytes: src
        .getOrUndefinedMapped(
          Pet.$jsonReflection.imageBytes.oasName,
          (v) => v as String?,
        )
        .map((v) => v == null ? null : base64.decode(v)),
    name1: src.getRequiredMapped(
      Pet.$jsonReflection.name1.oasName,
      (v) => v as String,
    ),
    name2: src.getRequiredMapped('name2', (v) => v as String?),
    name3: src.getOrUndefinedMapped('name3', (v) => v as String),
    name4: src.getOrUndefinedMapped('name4', (v) => v as String?),
    childPets: src.getOrUndefinedMapped(
      'childPets',
      (v) => (v as List)
          .map(
            (a) => (a as List)
                .map(
                  (b) => (b as List)
                      .map(
                        (c) => Pet.fromJson(c),
                      )
                      .toList(),
                )
                .toList(),
          )
          .toList(),
    ),
  );
}

XmlElement _$PetToXml(Pet instance) {
  final reflection = PetXmlReflection.instance;
  final result = XmlElement(
    XmlName(reflection.oasName, reflection.oasNamespace),
    //attributes
    [
      XmlAttribute(
        XmlName(
          reflection.name1.oasName,
          reflection.name1.oasNamespace,
        ),
        instance.name1,
      ),
    ],
    //elements
    [
      XmlElement(
        XmlName(
          reflection.name2.oasName,
          reflection.name2.oasNamespace,
        ),
        [],
        [
          if (instance.name2 != null) XmlText(instance.name2!),
        ],
      ),
      if (instance.name3.isDefined)
        XmlElement(
          XmlName(
            reflection.name3.oasName,
            reflection.name3.oasNamespace,
          ),
          [],
          [
            XmlText(instance.name3.valueRequired),
          ],
        ),
      if (instance.name4.isDefined)
        XmlElement(
          XmlName(
            reflection.name4.oasName,
            reflection.name4.oasNamespace,
          ),
          [],
          [
            if (instance.name4.valueRequired != null)
              XmlText(instance.name4.valueRequired!),
          ],
        ),
      if (instance.imageBytes.isDefined)
        XmlElement(
          XmlName(
            reflection.imageBytes.oasName,
            reflection.imageBytes.oasNamespace,
          ),
          [],
          [
            if (instance.imageBytes.valueRequired != null)
              XmlText(base64.encode(instance.imageBytes.valueRequired!)),
          ],
        ),
      if (instance.childPets.isDefined)
        XmlElement(
          XmlName(
            reflection.childPets.oasName,
            reflection.childPets.oasNamespace,
          ),
          [],
          [],
          // TODO:
          // instance.childPets.valueRequired.map(
          //   (v) => v.map(
          //     (v) => v.map(
          //       (v) => v.toXml(),
          //     ),
          //   ),
          // ),
        ),
    ],
  );
  // builder.element(
  //   'childPets',
  //   nest: () => builder.element('Pet', nest: null),
  // );
  return result;
}

Pet _$PetFromXml(XmlElement src) {
  final reflection = PetXmlReflection.instance;
  // src.children;
  return Pet.$all(
    imageBytes: src.getElementOrUndefinedMapped(
      reflection.imageBytes.oasName,
      (src) => src.value == null ? null : base64.decode(src.value!),
    ),
    name1: src.getAttributeRequiredMapped(
      reflection.name1.oasName,
      (v) => v.value,
    ),
    name2: src.getElementRequiredMapped(
      reflection.name2.oasName,
      (v) => v.value,
    ),
    name3: src.getElementOrUndefinedMapped(
      reflection.name3.oasName,
      (v) => v.value!,
    ),
    name4: src.getElementOrUndefinedMapped(
      reflection.name4.oasName,
      (v) => v.value,
    ),
    childPets: src.getElementOrUndefinedMapped(
      reflection.childPets.oasName,
      // TODO
      (v) => [],
    ),
  );
}

Status _$StatusFromJson(Object? src) {
  return Status.values.firstWhere((v) => v.jsonReflection.oasValue == src);
}

Object? _$StatusToJson(Status src) {
  return src.jsonReflection.oasValue;
}

Status _$StatusFromXml(XmlNode src) {
  return Status.values
      .firstWhere((v) => v.xmlReflection.oasValue == src.innerText);
}

XmlText _$StatusToXml(Status src) {
  return XmlText(src.xmlReflection.oasValue);
}
