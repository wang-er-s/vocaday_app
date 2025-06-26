/// Bmob 配置文件
/// 用于初始化 Bmob SDK
class BmobConfig {
  /// Bmob Application Key (Secret Key)
  /// 从 Bmob 控制台获取：控制台 -> 设置 -> 应用密钥 -> Secret Key
  static const String secretKey = 'YOUR_SECRET_KEY';
  
  /// Bmob API 安全码
  /// 从 Bmob 控制台获取：控制台 -> 设置 -> 应用密钥 -> API安全码
  static const String apiSafe = 'YOUR_API_SAFE_CODE';
  
  /// Master Key (可选，一般情况下不建议使用)
  /// 从 Bmob 控制台获取：控制台 -> 设置 -> 应用密钥 -> Master Key
  static const String? masterKey = null;
  
  /// 自定义域名（可选）
  /// 如果有备案域名，可以在这里配置
  static const String? customDomain = null;
  
  /// 是否开启调试模式
  static const bool debugMode = true;
} 