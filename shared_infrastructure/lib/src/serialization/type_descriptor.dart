/// Describes a dart type.
class TypeDescriptor {
  final Type type;
  final bool nullable;
  final List<TypeDescriptor> genericTypeParameters;

  bool get isGeneric => genericTypeParameters.isNotEmpty;

  const TypeDescriptor.nonGeneric(this.type, {required this.nullable})
      : genericTypeParameters = const [];

  TypeDescriptor.generic(
    this.type,
    this.genericTypeParameters, {
    required this.nullable,
  }) : assert(
          genericTypeParameters.isNotEmpty,
          'generic type must have at least one parameter',
        );
  
  TypeDescriptor.listOf(
    TypeDescriptor genericTypeParameter, {
    required bool nullable,
  }) : this.generic(
          List,
          [
            genericTypeParameter,
          ],
          nullable: nullable,
        );

  TypeDescriptor.mapOf(
    TypeDescriptor keyType,
    TypeDescriptor valueType, {
    required bool nullable,
  }) : this.generic(
          Map,
          [keyType, valueType],
          nullable: nullable,
        );

  TypeDescriptor.setOf(
    TypeDescriptor type, {
    required bool nullable,
  }) : this.generic(
          Set,
          [type],
          nullable: nullable,
        );
}

