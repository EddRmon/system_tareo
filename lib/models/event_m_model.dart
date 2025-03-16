// To parse this JSON data, do
//
//     final eventM = eventMFromJson(jsonString);

import 'dart:convert';

List<EventM> eventMFromJson(String str) => List<EventM>.from(json.decode(str).map((x) => EventM.fromJson(x)));

String eventMToJson(List<EventM> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventM {
    String codeEvent;
    String description;

    EventM({
        required this.codeEvent,
        required this.description,
    });

    factory EventM.fromJson(Map<String, dynamic> json) => EventM(
        codeEvent: json["CodeEvent"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "CodeEvent": codeEvent,
        "Description": description,
    };
}
