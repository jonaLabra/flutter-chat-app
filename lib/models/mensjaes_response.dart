// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);
import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) =>
    MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) =>
    json.encode(data.toJson());

class MensajesResponse {
  bool ok;
  List<Mensaje> mensajes;

  MensajesResponse({
    required this.ok,
    required this.mensajes,
  });

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  Mensaje({
    required this.de,
    required this.para,
    required this.mensaje,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": deValues.reverse[de],
        "para": deValues.reverse[para],
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum De { THE_663299_D68_DCEBB57099_F9341, THE_66329_CA1_F3_F7_A1_F00_B753483 }

final deValues = EnumValues({
  "663299d68dcebb57099f9341": De.THE_663299_D68_DCEBB57099_F9341,
  "66329ca1f3f7a1f00b753483": De.THE_66329_CA1_F3_F7_A1_F00_B753483
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
