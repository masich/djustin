import 'dart:convert' as json;

abstract class JsonConverter<T> {
  T fromNotBlankJson(Map<String, dynamic> json);

  T fromJson(Map<String, dynamic> json) {
    return (json == null || json.isEmpty) ? null : fromNotBlankJson(json);
  }

  T fromJsonString(String jsonString) {
    return fromJson(json.jsonDecode(jsonString));
  }
}
