/// Bmob 购物车模型
/// 对应 Bmob 后端的购物车数据表
class BmobCartModel {
  /// 数据唯一标志
  String? objectId;
  
  /// 数据创建时间
  String? createdAt;
  
  /// 数据更新时间
  String? updatedAt;
  
  /// 用户ID（关联到用户表）
  String? userId;
  
  /// 背包列表
  List<BmobCartBag>? bags;
  
  BmobCartModel({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.bags,
  });
  
  /// 从 JSON 创建对象
  factory BmobCartModel.fromJson(Map<String, dynamic> json) {
    return BmobCartModel(
      objectId: json['objectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
      bags: json['bags'] != null
          ? (json['bags'] as List)
              .map((bag) => BmobCartBag.fromJson(bag))
              .toList()
          : [],
    );
  }
  
  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (objectId != null) data['objectId'] = objectId;
    if (userId != null) data['userId'] = userId;
    if (bags != null) {
      data['bags'] = bags!.map((bag) => bag.toJson()).toList();
    }
    
    return data;
  }
}

/// 购物车背包项
class BmobCartBag {
  /// 背包ID
  String? id;
  
  /// 背包名称
  String? name;
  
  /// 背包描述
  String? description;
  
  /// 背包图标
  String? icon;
  
  /// 背包中的单词ID列表
  List<String>? wordIds;
  
  /// 创建时间
  String? createdAt;
  
  /// 是否已完成
  bool? completed;
  
  BmobCartBag({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.wordIds,
    this.createdAt,
    this.completed,
  });
  
  /// 从 JSON 创建对象
  factory BmobCartBag.fromJson(Map<String, dynamic> json) {
    return BmobCartBag(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      wordIds: json['wordIds'] != null
          ? List<String>.from(json['wordIds'])
          : [],
      createdAt: json['createdAt'],
      completed: json['completed'] ?? false,
    );
  }
  
  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (icon != null) data['icon'] = icon;
    if (wordIds != null) data['wordIds'] = wordIds;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (completed != null) data['completed'] = completed;
    
    return data;
  }
} 