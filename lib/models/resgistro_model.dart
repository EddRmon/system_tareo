class Registro {
    String odtCod;
    String odtEle;
    String? description;
    String fecIniProc;
    String fecFinProc;
    String pliegosParc;
    String? pliegosparcmal;
    String? odtObs;

    Registro({
        required this.odtCod,
        required this.odtEle,
        required this.description,
        required this.fecIniProc,
        required this.fecFinProc,
        required this.pliegosParc,
        required this.pliegosparcmal,
        required this.odtObs,
    });

    factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        odtCod: json["OdtCod"] ?? '',
        odtEle: json["OdtEle"] ?? '',
        description: json["Description"] ?? '',
        fecIniProc: json["FecIniProc"] ?? '',
        fecFinProc: json["FecFinProc"] ?? '',
        pliegosParc: json["PliegosParc"] ?? '',
        pliegosparcmal: json["PLIEGOSPARCMAL"] ?? '',
        odtObs: json["OdtObs"] ?? ''
    );

    Map<String, dynamic> toJson() => {
        "OdtCod": odtCod,
        "OdtEle": odtEle,
        "Description": description,
        "FecIniProc": fecIniProc,
        "FecFinProc": fecFinProc,
        "PliegosParc": pliegosParc,
        "PLIEGOSPARCMAL": pliegosparcmal,
        "OdtObs": odtObs,
    };
}




