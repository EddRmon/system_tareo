// To parse this JSON data, do
//
//     final opFecha = opFechaFromJson(jsonString);

import 'dart:convert';

List<OpFecha> opFechaFromJson(String str) => List<OpFecha>.from(json.decode(str).map((x) => OpFecha.fromJson(x)));

String opFechaToJson(List<OpFecha> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpFecha {
    String odtCod;
    String odtOrd;
    String fecEst;
    String enProceso;

    OpFecha({
        required this.odtCod,
        required this.odtOrd,
        required this.fecEst,
        required this.enProceso,
    });

    factory OpFecha.fromJson(Map<String, dynamic> json) => OpFecha(
        odtCod: json["OdtCod"] ?? '',
        odtOrd: json["OdtOrd"] ?? '',
        fecEst: json["FecEst"] ?? '',
        enProceso: json["EnProceso"] ?? ''
    );

    Map<String, dynamic> toJson() => {
        "OdtCod": odtCod,
        "OdtOrd": odtOrd,
        "FecEst": fecEst,
        "EnProceso": enProceso,
    };
}
