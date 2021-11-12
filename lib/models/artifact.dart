class ArtifactResult {
  String name;
  int max_rarity;
  String piece_bonus_2;
  String piece_bonus_4;


  ArtifactResult(
      this.name, this.max_rarity, this.piece_bonus_2, this.piece_bonus_4);

  factory ArtifactResult.fromJson(var json) {
    return
      ArtifactResult(
        json['name'], json['max_rarity'], json['2-piece_bonus'], json['4-piece_bonus'],);
  }
}