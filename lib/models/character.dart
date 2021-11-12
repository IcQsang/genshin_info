class CharacterResult {
  String name;
  String vision;
  String weapon;
  String nation;
  int rarity;
  String birthday;



  CharacterResult(this.name, this.vision, this.weapon, this.nation, this.rarity,
      this.birthday);

  factory CharacterResult.fromJson(var json) {
    return
      CharacterResult(
          json['name'], json['vision'], json['weapon'], json['nation'],
          json['rarity'],
          json['birthday']);
  }
}