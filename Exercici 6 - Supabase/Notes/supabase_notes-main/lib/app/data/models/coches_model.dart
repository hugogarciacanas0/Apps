class Coches {
  int? id;
  int? userId;
  String? marca;
  String? modelo;
  int? anyo;
  String? color;
  double? precio;
  String? createdAt;

  Coches({this.id, this.userId, this.marca, this.modelo, this.anyo, this.color, this.precio, this.createdAt});

  Coches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    marca = json['marca'];
    modelo = json['modelo'];
    anyo = json['anyo'];
    color = json['color'];
    precio = (json['precio'] as num?)?.toDouble();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['marca'] = marca;
    data['modelo'] = modelo;
    data['anyo'] = anyo;
    data['color'] = color;
    data['precio'] = precio;
    data['created_at'] = createdAt;
    return data;
  }

  static List<Coches> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Coches.fromJson(e)).toList();
  }
}
