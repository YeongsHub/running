import 'dart:convert';
import 'package:flutter/material.dart';

class FriendTerritory {
  final String id;
  final List<List<double>> polygon; // [[lat, lng], ...]
  final double areaM2;
  final DateTime claimedAt;

  const FriendTerritory({
    required this.id,
    required this.polygon,
    required this.areaM2,
    required this.claimedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'polygon': polygon,
        'areaM2': areaM2,
        'claimedAt': claimedAt.millisecondsSinceEpoch,
      };

  factory FriendTerritory.fromJson(Map<String, dynamic> j) => FriendTerritory(
        id: j['id'] as String,
        polygon: (j['polygon'] as List)
            .map((p) => (p as List).map((v) => (v as num).toDouble()).toList())
            .toList(),
        areaM2: (j['areaM2'] as num).toDouble(),
        claimedAt: DateTime.fromMillisecondsSinceEpoch(j['claimedAt'] as int),
      );
}

class Friend {
  final String id;
  final String name;
  final Color color;
  final List<FriendTerritory> territories;
  final DateTime addedAt;

  const Friend({
    required this.id,
    required this.name,
    required this.color,
    required this.territories,
    required this.addedAt,
  });

  String get colorHex =>
      '#${color.r.round().toRadixString(16).padLeft(2, '0')}${color.g.round().toRadixString(16).padLeft(2, '0')}${color.b.round().toRadixString(16).padLeft(2, '0')}';

  /// Encodes this friend's profile + territories into a shareable text code
  String toShareCode() {
    final payload = {
      'id': id,
      'name': name,
      'color': colorHex,
      'territories': territories.map((t) => t.toJson()).toList(),
    };
    return base64Url.encode(utf8.encode(jsonEncode(payload)));
  }

  /// Decodes a share code into a Friend object
  static Friend? fromShareCode(String code) {
    try {
      final json = jsonDecode(utf8.decode(base64Url.decode(code))) as Map<String, dynamic>;
      final hexColor = json['color'] as String;
      final colorInt = int.parse(hexColor.replaceFirst('#', 'FF'), radix: 16);
      return Friend(
        id: json['id'] as String,
        name: json['name'] as String,
        color: Color(colorInt),
        territories: (json['territories'] as List)
            .map((t) => FriendTerritory.fromJson(t as Map<String, dynamic>))
            .toList(),
        addedAt: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toDbMap() => {
        'id': id,
        'name': name,
        'color_hex': colorHex,
        'territories_json': jsonEncode(territories.map((t) => t.toJson()).toList()),
        'added_at': addedAt.millisecondsSinceEpoch,
      };

  factory Friend.fromDbMap(Map<String, dynamic> m) {
    final hexColor = m['color_hex'] as String;
    final colorInt = int.parse(hexColor.replaceFirst('#', 'FF'), radix: 16);
    return Friend(
      id: m['id'] as String,
      name: m['name'] as String,
      color: Color(colorInt),
      territories: (jsonDecode(m['territories_json'] as String) as List)
          .map((t) => FriendTerritory.fromJson(t as Map<String, dynamic>))
          .toList(),
      addedAt: DateTime.fromMillisecondsSinceEpoch(m['added_at'] as int),
    );
  }
}
