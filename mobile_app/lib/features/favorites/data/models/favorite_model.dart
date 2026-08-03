import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 2)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String inventionId;

  FavoriteModel({
    required this.inventionId,
  });

  // ==========================
  // Backup JSON
  // ==========================

  Map<String, dynamic> toJson() {
    return {
      'inventionId': inventionId,
    };
  }

  // ==========================
  // Restore JSON
  // ==========================

  factory FavoriteModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FavoriteModel(
      inventionId: json['inventionId'] ?? '',
    );
  }
}