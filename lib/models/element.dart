class ElementResult {
  String name;
  List<dynamic> reaction;


  ElementResult(this.name, this.reaction);

  factory ElementResult.fromJson(var json) {
    return
      ElementResult(
        json['name'], json['reactions']);
  }
}