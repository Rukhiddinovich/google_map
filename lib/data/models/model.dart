class Model {
  final num id;
  final String number;
  final String name;
  final String img;
  final List<dynamic> type;
  final String height;
  final String weight;
  final String candy;
  final num candyCount;
  final String egg;
  final num spawnChance;
  final num avgSpawns;
  final String spawnTime;
  final List<dynamic> weaknesses;

  Model(
      {required this.id,
        required this.img,
        required this.weight,
        required this.height,
        required this.name,
        required this.type,
        required this.number,
        required this.avgSpawns,
        required this.candy,
        required this.candyCount,
        required this.egg,
        required this.spawnTime,
        required this.spawnChance,
        required this.weaknesses});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        id: json["id"] as num? ?? 0,
        img: json["img"] as String? ?? "",
        weight: json["weight"] as String? ?? "",
        height: json["height"] as String? ?? "",
        name: json["name"] as String? ?? "",
        type: json["type"] as List<dynamic>? ?? [],
        number: json["num"] as String? ?? "",
        avgSpawns: json["avg_spawns"]as num? ?? 0,
        candy: json["candy"]as String? ?? "",
        candyCount: json["candy_count"]as num? ?? 0,
        egg: json["egg"]as String? ?? "",
        spawnTime: json["spawn_time"]as String? ?? "",
        spawnChance: json["spawn_chance"]as num? ?? 0,
        weaknesses: json["weaknesses"]as List<dynamic>? ?? []);
  }
}