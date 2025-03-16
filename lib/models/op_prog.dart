class OpProg {
  final String? motFini;
  final String? motFfin;
  final String motCodOdt;
  final String motDescrip;
  final String motNroElem;
  final String motCodMaq;
  final String motTirRet;
  final String motTipoMaq;
  final String secuencyMachine;
  final String motPliegos;
  final String motCant;
  final String motEstado;
  final String motNroComplem;

  OpProg(
      {required this.motFini,
      required this.motFfin,
      required this.motCodOdt,
      required this.motDescrip,
      required this.motNroElem,
      required this.motCodMaq,
      required this.motTirRet,
      required this.motTipoMaq,
      required this.secuencyMachine,
      required this.motPliegos,
      required this.motCant,
      required this.motEstado,
      required this.motNroComplem});

  factory OpProg.fromJson(Map<String, dynamic> json) {
    return OpProg(
        motFini: json['MotFini'] ?? '',
        motFfin: json['MotFfin'] ?? '',
        motCodOdt: json['MotCodOdt'] ?? '',
        motDescrip: json['MotDescrip'] ?? '',
        motNroElem: json['MotNroElem'] ?? '',
        motCodMaq: json['MotCodMaq'] ?? '',
        motTirRet: json['MotTirRet'] ?? '',
        motTipoMaq: json['MotTipoMaq'] ?? '',
        secuencyMachine: json['SecuencyMachine'] ?? '',
        motPliegos: json['MotPliegos'] ?? '',
        motCant: json['MotCant'] ?? '',
        motEstado: json['MotEstado'] ?? '',
        motNroComplem: json['MotNroComplem'] ?? '');
  }
}
