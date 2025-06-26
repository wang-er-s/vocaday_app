/// Bmob 游戏数据模型
/// 对应 Bmob 后端的游戏数据表
class BmobGameModel {
  /// 数据唯一标志
  String? objectId;
  
  /// 数据创建时间
  String? createdAt;
  
  /// 数据更新时间
  String? updatedAt;
  
  /// 用户ID（关联到用户表）
  String? userId;
  
  /// 游戏总积分
  int? totalPoints;
  
  /// 游戏总金币
  int? totalGold;
  
  /// 已完成的游戏次数
  int? gamesCompleted;
  
  /// 最高分数
  int? highScore;
  
  /// 最后游戏时间
  String? lastPlayTime;
  
  /// 游戏记录列表
  List<GameRecord>? gameRecords;
  
  BmobGameModel({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.totalPoints,
    this.totalGold,
    this.gamesCompleted,
    this.highScore,
    this.lastPlayTime,
    this.gameRecords,
  });
  
  /// 从 JSON 创建对象
  factory BmobGameModel.fromJson(Map<String, dynamic> json) {
    return BmobGameModel(
      objectId: json['objectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
      totalPoints: json['totalPoints'] ?? 0,
      totalGold: json['totalGold'] ?? 0,
      gamesCompleted: json['gamesCompleted'] ?? 0,
      highScore: json['highScore'] ?? 0,
      lastPlayTime: json['lastPlayTime'],
      gameRecords: json['gameRecords'] != null
          ? (json['gameRecords'] as List)
              .map((record) => GameRecord.fromJson(record))
              .toList()
          : [],
    );
  }
  
  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (objectId != null) data['objectId'] = objectId;
    if (userId != null) data['userId'] = userId;
    if (totalPoints != null) data['totalPoints'] = totalPoints;
    if (totalGold != null) data['totalGold'] = totalGold;
    if (gamesCompleted != null) data['gamesCompleted'] = gamesCompleted;
    if (highScore != null) data['highScore'] = highScore;
    if (lastPlayTime != null) data['lastPlayTime'] = lastPlayTime;
    if (gameRecords != null) {
      data['gameRecords'] = gameRecords!.map((record) => record.toJson()).toList();
    }
    
    return data;
  }
}

/// 游戏记录
class GameRecord {
  /// 游戏类型
  String? gameType;
  
  /// 获得的积分
  int? points;
  
  /// 获得的金币
  int? gold;
  
  /// 游戏时长（秒）
  int? duration;
  
  /// 正确率
  double? accuracy;
  
  /// 游戏时间
  String? playTime;
  
  GameRecord({
    this.gameType,
    this.points,
    this.gold,
    this.duration,
    this.accuracy,
    this.playTime,
  });
  
  /// 从 JSON 创建对象
  factory GameRecord.fromJson(Map<String, dynamic> json) {
    return GameRecord(
      gameType: json['gameType'],
      points: json['points'] ?? 0,
      gold: json['gold'] ?? 0,
      duration: json['duration'] ?? 0,
      accuracy: json['accuracy']?.toDouble() ?? 0.0,
      playTime: json['playTime'],
    );
  }
  
  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (gameType != null) data['gameType'] = gameType;
    if (points != null) data['points'] = points;
    if (gold != null) data['gold'] = gold;
    if (duration != null) data['duration'] = duration;
    if (accuracy != null) data['accuracy'] = accuracy;
    if (playTime != null) data['playTime'] = playTime;
    
    return data;
  }
} 