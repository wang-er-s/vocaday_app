/// Bmob 用户模型
/// 对应 Bmob 后端的用户数据表
class BmobUserModel {
  /// 数据唯一标志
  String? objectId;
  
  /// 数据创建时间
  String? createdAt;
  
  /// 数据更新时间
  String? updatedAt;
  
  /// 用户名（用于登录）
  String? username;
  
  /// 密码（仅用于注册和登录）
  String? password;
  
  /// 邮箱
  String? email;
  
  /// 用户昵称
  String? nickname;
  
  /// 用户头像URL
  String? avatarUrl;
  
  /// 用户积分
  int? points;
  
  /// 用户金币
  int? gold;
  
  /// 用户等级
  int? level;
  
  /// 已学习天数
  int? learningDays;
  
  /// 连续学习天数
  int? streakDays;
  
  /// 上次登录时间
  String? lastLoginTime;
  
  /// 出勤日期列表
  List<String>? attendanceDates;
  
  /// 收藏的单词列表
  List<String>? favourites;
  
  /// 已掌握的单词列表
  List<String>? knowns;
  
  /// 是否是新用户
  bool? isNewUser;
  
  BmobUserModel({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.password,
    this.email,
    this.nickname,
    this.avatarUrl,
    this.points,
    this.gold,
    this.level,
    this.learningDays,
    this.streakDays,
    this.lastLoginTime,
    this.attendanceDates,
    this.favourites,
    this.knowns,
    this.isNewUser,
  });
  
  /// 从 JSON 创建对象
  factory BmobUserModel.fromJson(Map<String, dynamic> json) {
    return BmobUserModel(
      objectId: json['objectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      username: json['username'],
      email: json['email'],
      nickname: json['nickname'],
      avatarUrl: json['avatarUrl'],
      points: json['points'] ?? 0,
      gold: json['gold'] ?? 0,
      level: json['level'] ?? 1,
      learningDays: json['learningDays'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      lastLoginTime: json['lastLoginTime'],
      attendanceDates: json['attendanceDates'] != null 
          ? List<String>.from(json['attendanceDates'])
          : [],
      favourites: json['favourites'] != null 
          ? List<String>.from(json['favourites'])
          : [],
      knowns: json['knowns'] != null 
          ? List<String>.from(json['knowns'])
          : [],
      isNewUser: json['isNewUser'] ?? false,
    );
  }
  
  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (objectId != null) data['objectId'] = objectId;
    if (username != null) data['username'] = username;
    if (password != null) data['password'] = password;
    if (email != null) data['email'] = email;
    if (nickname != null) data['nickname'] = nickname;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (points != null) data['points'] = points;
    if (gold != null) data['gold'] = gold;
    if (level != null) data['level'] = level;
    if (learningDays != null) data['learningDays'] = learningDays;
    if (streakDays != null) data['streakDays'] = streakDays;
    if (lastLoginTime != null) data['lastLoginTime'] = lastLoginTime;
    if (attendanceDates != null) data['attendanceDates'] = attendanceDates;
    if (favourites != null) data['favourites'] = favourites;
    if (knowns != null) data['knowns'] = knowns;
    if (isNewUser != null) data['isNewUser'] = isNewUser;
    
    return data;
  }
  
  /// 复制对象
  BmobUserModel copyWith({
    String? objectId,
    String? createdAt,
    String? updatedAt,
    String? username,
    String? password,
    String? email,
    String? nickname,
    String? avatarUrl,
    int? points,
    int? gold,
    int? level,
    int? learningDays,
    int? streakDays,
    String? lastLoginTime,
    List<String>? attendanceDates,
    List<String>? favourites,
    List<String>? knowns,
    bool? isNewUser,
  }) {
    return BmobUserModel(
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      points: points ?? this.points,
      gold: gold ?? this.gold,
      level: level ?? this.level,
      learningDays: learningDays ?? this.learningDays,
      streakDays: streakDays ?? this.streakDays,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      attendanceDates: attendanceDates ?? this.attendanceDates,
      favourites: favourites ?? this.favourites,
      knowns: knowns ?? this.knowns,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
} 