import 'dart:convert' as json;

abstract class JsonConverter<T> {
  T fromJson(Map<String, dynamic> json);

  T fromJsonString(String jsonString) {
    return fromJson(json.jsonDecode(jsonString));
  }

  Map<String, dynamic> toJson(T value);
}
