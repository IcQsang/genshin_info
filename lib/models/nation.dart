class NationResult {
  String name;
  String element;
  String archon;
  String controllingEntity;


  NationResult(this.name, this.element, this.archon, this.controllingEntity);

  factory NationResult.fromJson(var json) {
    return
      NationResult(
          json['name'], json['element'], json['archon'], json['controllingEntity'],);
  }
}