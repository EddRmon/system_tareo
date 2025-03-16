// To parse this JSON data, do
//
//     final eventP = eventPFromJson(jsonString);

import 'dart:convert';

List<EventP> eventPFromJson(String str) => List<EventP>.from(json.decode(str).map((x) => EventP.fromJson(x)));

String eventPToJson(List<EventP> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventP {
    String codeEvent;
    String description;

    EventP({
        required this.codeEvent,
        required this.description,
    });

    factory EventP.fromJson(Map<String, dynamic> json) => EventP(
        codeEvent: json["CodeEvent"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "CodeEvent": codeEvent,
        "Description": description,
    };
}
