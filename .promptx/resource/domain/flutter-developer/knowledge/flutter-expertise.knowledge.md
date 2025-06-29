## Flutter核心技术栈

### Dart语言精通
- **语言特性掌握**：空安全、异步编程、泛型、扩展方法、Mixin
- **面向对象编程**：类、继承、多态、抽象类、接口实现
- **函数式编程**：高阶函数、闭包、Stream操作、函数组合
- **异步编程模式**：Future、async/await、Stream、Isolate并发

### Flutter框架深度理解
- **Widget体系架构**：StatelessWidget、StatefulWidget、InheritedWidget
- **渲染机制原理**：Widget树、Element树、RenderObject树的三树结构
- **生命周期管理**：Widget生命周期、State生命周期、App生命周期
- **布局系统精通**：Flex布局、Stack布局、自定义布局、约束传递机制

### 状态管理方案精通
- **Provider生态**：Provider、Consumer、Selector、ChangeNotifier
- **BLoC模式**：Bloc、Cubit、BlocBuilder、BlocListener、BlocConsumer
- **Riverpod框架**：StateProvider、FutureProvider、StreamProvider、StateNotifier
- **GetX框架**：GetxController、Obx、GetBuilder、依赖注入、路由管理

## 架构设计与最佳实践

### Clean Architecture实现
- **分层架构设计**：表现层、领域层、数据层的职责分离
- **依赖注入原则**：get_it、injectable的使用和配置
- **仓储模式应用**：Repository模式、数据源抽象、缓存策略
- **用例驱动开发**：UseCase设计、业务逻辑封装、错误处理

### 项目结构最佳实践
```
lib/
├── core/                    # 核心基础设施
│   ├── constants/          # 常量定义
│   ├── extensions/         # 扩展方法
│   ├── utils/              # 工具类
│   ├── errors/             # 错误处理
│   └── usecases/           # 基础用例
├── features/               # 功能模块
│   └── feature_name/
│       ├── data/           # 数据层
│       │   ├── datasources/ # 数据源
│       │   ├── models/     # 数据模型
│       │   └── repositories/ # 仓储实现
│       ├── domain/         # 领域层
│       │   ├── entities/   # 实体
│       │   ├── repositories/ # 仓储接口
│       │   └── usecases/   # 用例
│       └── presentation/   # 表现层
│           ├── bloc/       # 状态管理
│           ├── pages/      # 页面
│           └── widgets/    # 组件
└── shared/                 # 共享资源
    ├── widgets/            # 通用组件
    ├── themes/             # 主题配置
    └── services/           # 服务层
```

### 代码质量保证
- **静态分析配置**：analysis_options.yaml的最佳配置
- **代码风格统一**：flutter_lints、effective_dart规范
- **测试策略完整**：单元测试、Widget测试、集成测试、Golden测试
- **CI/CD集成**：GitHub Actions、Codemagic、Bitrise的配置和使用

## 性能优化专业技能

### Widget性能优化
- **构建优化技巧**：const构造函数、Widget复用、Builder模式
- **渲染优化策略**：RepaintBoundary、避免不必要的重建、Key的正确使用
- **列表性能优化**：ListView.builder、Sliver系列、AutomaticKeepAlive
- **动画性能调优**：AnimationController优化、硬件加速、帧率监控

### 内存管理与优化
- **内存泄漏预防**：StreamSubscription管理、AnimationController释放、Timer清理
- **图片资源优化**：缓存策略、压缩技术、延迟加载、内存占用控制
- **大数据处理**：分页加载、虚拟滚动、数据缓存、后台处理
- **原生内存管理**：Platform Channel内存管理、原生资源释放

### 启动性能优化
- **冷启动优化**：启动画面优化、预加载策略、依赖延迟初始化
- **热启动提升**：状态保持、缓存利用、预热机制
- **包大小控制**：资源优化、代码分割、无用代码消除、混淆配置
- **网络性能优化**：HTTP缓存、连接复用、数据压缩、离线策略

## 平台集成与原生开发

### Platform Channel精通
- **方法通道使用**：MethodChannel的双向通信、参数序列化
- **事件通道应用**：EventChannel的流式数据传输、生命周期管理
- **基础消息通道**：BasicMessageChannel的自定义协议通信
- **错误处理机制**：平台异常捕获、错误码定义、降级策略

### iOS集成开发
- **Xcode项目配置**：Build Settings、Info.plist、权限配置
- **Swift/Objective-C集成**：原生模块开发、CocoaPods依赖管理
- **iOS特性适配**：安全区域、Dark Mode、Haptic Feedback、推送通知
- **App Store发布**：证书管理、构建配置、审核规范遵循

### Android集成开发
- **Gradle配置精通**：构建脚本、依赖管理、多渠道打包、签名配置
- **Kotlin/Java集成**：原生模块开发、AAR依赖、ProGuard配置
- **Android特性适配**：Material Design、权限系统、后台限制、通知渠道
- **Google Play发布**：Bundle格式、动态交付、审核流程、元数据配置

## UI/UX设计实现

### Material Design实现
- **组件库精通**：Material Components的正确使用和定制
- **主题系统掌握**：ThemeData配置、ColorScheme设计、Typography设置
- **响应式设计**：LayoutBuilder、MediaQuery、屏幕适配、方向处理
- **无障碍功能**：Semantics配置、屏幕阅读器支持、键盘导航

### 自定义UI开发
- **自定义Widget开发**：RenderObject自定义、CustomPainter绘制
- **动画系统精通**：隐式动画、显式动画、Hero动画、页面转场
- **手势识别处理**：GestureDetector、GestureRecognizer、多点触控
- **图形绘制能力**：Canvas绘制、Path操作、渐变效果、阴影处理

### 交互体验优化
- **微交互设计**：按钮反馈、加载动画、状态转换、视觉提示
- **页面导航设计**：Navigator 2.0、路由管理、深度链接、状态恢复
- **用户反馈机制**：SnackBar、Dialog、BottomSheet、Toast消息
- **加载与错误状态**：骨架屏、空状态、错误页面、网络状态处理

## 测试与调试技能

### 测试框架精通
- **单元测试**：test包使用、Mock对象、测试覆盖率、TDD实践
- **Widget测试**：flutter_test、Widget交互测试、查找器使用
- **集成测试**：integration_test、端到端测试、设备测试、性能测试
- **Golden测试**：UI回归测试、视觉一致性验证、多平台对比

### 调试工具使用
- **Flutter Inspector**：Widget树分析、属性检查、布局调试
- **DevTools套件**：性能分析、内存监控、网络调试、日志查看
- **断点调试**：IDE调试器、条件断点、表达式求值、调用栈分析
- **日志系统**：Logger配置、日志级别、远程日志、崩溃收集

### 性能分析能力
- **性能指标监控**：FPS监控、内存使用、CPU占用、网络延迟
- **性能瓶颈识别**：Timeline分析、Frame渲染分析、热点代码定位
- **优化效果验证**：A/B测试、性能对比、用户体验指标、业务指标关联
- **监控系统集成**：Firebase Performance、Sentry、自定义埋点

## 工具链与生态系统

### 开发工具精通
- **IDE配置优化**：VS Code、Android Studio、IntelliJ的插件和配置
- **命令行工具**：Flutter CLI、Dart CLI、fvm版本管理、melos多包管理
- **构建工具**：flutter build、自定义构建脚本、环境配置、版本管理
- **包管理器**：pub.dev、私有仓库、版本约束、依赖冲突解决

### 第三方生态精通
- **网络请求**：dio、http、GraphQL客户端、WebSocket、gRPC
- **数据存储**：SharedPreferences、Hive、SQLite、Firebase、Isar
- **图片处理**：cached_network_image、image_picker、photo_view、flutter_svg
- **地图与定位**：google_maps_flutter、location、geolocator、geocoding

### 云服务集成
- **Firebase生态**：Authentication、Firestore、Cloud Functions、Analytics
- **推送通知**：FCM、本地通知、通知策略、用户画像
- **分析与监控**：Google Analytics、Crashlytics、自定义埋点、用户行为分析
- **云存储服务**：Firebase Storage、AWS S3、阿里云OSS、CDN集成

## 项目管理与团队协作

### 版本控制精通
- **Git工作流**：GitFlow、GitHub Flow、分支策略、合并策略
- **代码审查**：Pull Request流程、代码质量检查、团队规范
- **版本发布**：语义化版本、Release Notes、标签管理、回滚策略
- **协作工具**：GitHub、GitLab、Bitbucket、代码托管最佳实践

### 持续集成/部署
- **CI/CD流程**：自动化测试、构建流水线、部署策略、环境管理
- **自动化测试**：单元测试自动化、UI测试自动化、性能测试集成
- **发布自动化**：应用商店自动发布、Beta测试分发、版本回滚
- **监控告警**：构建状态监控、性能指标告警、错误率监控

### 团队开发规范
- **代码规范**：团队编码标准、命名约定、注释规范、文档要求
- **架构决策**：技术选型流程、架构评审、重构计划、技术债务管理
- **知识分享**：技术分享、代码Review、最佳实践总结、新人培训
- **项目管理**：敏捷开发、Sprint规划、需求管理、风险评估 