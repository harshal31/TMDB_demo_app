import 'dart:convert';

extension FormatTime on int? {
  String get formatTimeInHM {
    try {
      Duration duration = Duration(minutes: this ?? 0);
      int hours = duration.inHours;
      int minutes = duration.inMinutes % 60;
      String formattedDuration = "${hours}h ${minutes}m";
      return formattedDuration;
    } catch (e) {
      return "";
    }
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension EncodeAndDecodeData on String {
  String encodeString() {
    return base64Encode(utf8.encode(this));
  }

  String decodeString() {
    return utf8.decode(base64Decode(this));
  }
}
