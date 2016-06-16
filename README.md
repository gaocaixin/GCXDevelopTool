#GCXDevelopTool          
###_For easy IOS Development_
----
###开发目的:  
#### 记录大量平时收集和写下的方法,方便查找调用.
---
###内容概要
####为了防止项目内方法冗余繁杂以及调用繁琐,项目内大部分方法采用分类区分,各个方法调用尽量简单易懂.如给一个按钮添加点击出现水波纹效果只要调用一行代码:(参数看内部注释)
    [button gcxAddTapRippleEffectWithColor:(UIColor *)color scaleMaxValue:(CGFloat)value duration:(CGFloat)duration];
---
###项目预期
####拥有此库不在需要其他助手类.目前此库已经完成:

<!--#ifndef GXDevelop_h-->
<!--#define GXDevelop_h-->
<!---->
<!--//辅助宏-->
<!--#import "GXDevelopKey.h" // 添加各种常用宏-->
<!--#import "GXDevelopExtern.h" // 屏幕适配 (不需要外部调用, 只需要调用宏GXWidthFitFloat(width)即可将 width 算成屏幕比例适配后的值(注意更改设计稿的尺寸))-->
<!--//辅助类方法-->
<!--// 非 UI-->
<!--#import "NSString+GXDevelop.h" // 正则 本地化等等-->
<!--#import "UIDevice+GXDevelop.h" // 强制转屏 获取设备信息等等-->
<!--#import "NSFileManager+GXDevelop.h"// 文件路径-->
<!--#import "UIImage+GXDevelop.h" // uiimge 的各类方法 渐变,拉伸,旋转,合成,组合,转gif, 从视频中获取 image-->
<!--#import "NSAttributedString+GXDevelop.h"-->
<!---->
<!--// UI -view //快速创建方法-->
<!--#import "UIButton+GXDevelop.h"-->
<!--#import "UIImageView+GXDevelop.h"-->
<!--#import "UILabel+GXDevelop.h"-->
<!--#import "UIPageControl+GXDevelop.h"-->
<!--#import "UIView+GXDevelopAnimation.h"-->
<!--#import "MBProgressHUD+GXDevelop.h"-->
<!--#import "UIView+GXDevelop.h"-->
<!--#import "GXFrameInButton.h" // 继承 uibutton 可随意定义内部 title 和 image 位置-->
<!--#import "UINavigationBar+GXDevelop.h"// 全透明及半透明设置-->
<!--#import "UIViewController+GXDevelop.h"-->
<!---->
<!--// UI - layer-->
<!--#import "CAGradientLayer+GXDevelop.h"-->
<!--#import "CALayer+GXDevelop.h"-->
<!---->
<!--// path-->
<!--#import "UIBezierPath+GXDevelop.h"-->
<!---->
<!--#endif /* GXDevelop_h */-->
---

###Just "#import "GXDevelop.h"":  
---
#谢谢
