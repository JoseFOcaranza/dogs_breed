class FormatBreed {
  late final String valor;
  FormatBreed._(this.valor);

  factory FormatBreed.constructor(String porpose) {
    if (porpose.trim().isEmpty) {
      throw ('Breed mal formada');
    }
    return FormatBreed._(porpose);
  }
}
