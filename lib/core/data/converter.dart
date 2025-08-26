class Converter<From, To> {
  Converter(this.mapper);

  final To Function(From from) mapper;

  To convert(From from) {
    return mapper(from);
  }

  To call(From from) {
    return convert(from);
  }

  List<To> convertAll(Iterable<From> items) {
    return (items).map<To>(convert).toList();
  }
}
