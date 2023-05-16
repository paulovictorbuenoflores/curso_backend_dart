extension ParserExtensio on String {
  toType(Type type) {
    switch (type) {
      case String:
        return toString().trim();

      case int:
        return int.parse(toString().trim());
      default:
    }
  }
}
