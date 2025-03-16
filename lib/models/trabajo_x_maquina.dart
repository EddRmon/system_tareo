// To parse this JSON data, do
//
//     final trabajoMaquina = trabajoMaquinaFromJson(jsonString);

import 'dart:convert';

List<TrabajoMaquina> trabajoMaquinaFromJson(String str) => List<TrabajoMaquina>.from(json.decode(str).map((x) => TrabajoMaquina.fromJson(x)));

String trabajoMaquinaToJson(List<TrabajoMaquina> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrabajoMaquina {
    String maqNro;
    String? motCodOdt;
    String motEnlace;
    String iniproc;
    String horaInProc;
    String finproc;
    String horaFinProc;
    String clides;
    String motDescrip;
    String motTipoMaq;
    String motCant;
    String motPliegos;
    String? fecofrec;
    String enlace;
    String mottirret;
    String? estadoAlm;
    dynamic estadoMatri;
    String? estadoCtp;
    String? estadoMatiz;

    TrabajoMaquina({
        required this.maqNro,
        required this.motCodOdt,
        required this.motEnlace,
        required this.iniproc,
        required this.horaInProc,
        required this.finproc,
        required this.horaFinProc,
        required this.clides,
        required this.motDescrip,
        required this.motTipoMaq,
        required this.motCant,
        required this.motPliegos,
        required this.fecofrec,
        required this.enlace,
        required this.mottirret,
        required this.estadoAlm,
        required this.estadoMatri,
        required this.estadoCtp,
        required this.estadoMatiz,
    });

    factory TrabajoMaquina.fromJson(Map<String, dynamic> json) => TrabajoMaquina(
        maqNro: json["MaqNro"] ?? '',
        motCodOdt: json["MotCodOdt"]?? '',
        motEnlace: json["MotEnlace"]?? '',
        iniproc: json["INIPROC"]?? '',
        horaInProc: json["HoraINProc"]?? '',
        finproc: json["FINPROC"]?? '',
        horaFinProc: json["HoraFinProc"]?? '',
        clides: json["Clides"]?? '',
        motDescrip: json["MotDescrip"]?? '',
        motTipoMaq: json["MotTipoMaq"]?? '',
        motCant: json["MotCant"]?? '',
        motPliegos: json["MotPliegos"]?? '',
        fecofrec: json["FECOFREC"]?? '',
        enlace: json["Enlace"]?? '',
        mottirret: json["mottirret"]?? '',
        estadoAlm: json["estadoALM"]?? '',
        estadoMatri: json["estadoMATRI"]?? '',
        estadoCtp: json["estadoCTP"]?? '',
        estadoMatiz: json["estadoMATIZ"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "MaqNro": maqNro,
        "MotCodOdt": motCodOdt,
        "MotEnlace": motEnlace,
        "INIPROC": iniproc,
        "HoraINProc": horaInProc,
        "FINPROC": finproc,
        "HoraFinProc": horaFinProc,
        "Clides": clides,
        "MotDescrip": motDescrip,
        "MotTipoMaq": motTipoMaq,
        "MotCant": motCant,
        "MotPliegos": motPliegos,
        "FECOFREC": fecofrec,
        "Enlace": enlace,
        "mottirret": mottirret,
        "estadoALM": estadoAlm,
        "estadoMATRI": estadoMatri,
        "estadoCTP": estadoCtp,
        "estadoMATIZ": estadoMatiz,
    };
}
