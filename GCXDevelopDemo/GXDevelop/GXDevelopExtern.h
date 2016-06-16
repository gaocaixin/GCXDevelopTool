//
//  GXDevelopExtern.h
//  GXDevelopDemo
//
//  Created by 高才新 on 16/3/29.
//  Copyright © 2016年 高才新. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GXDevelopExtern : NSObject

// 全局单例 记录屏幕缩放比例
+ (instancetype)sharedExtern;

@property (nonatomic )  CGFloat  gxScreenWidth;
@property (nonatomic )  CGFloat  gxScreenHeight;
@property (nonatomic )  CGFloat  gxScreenWidthRatio;
@property (nonatomic )  CGFloat  gxScreenHeightRatio;
@property (nonatomic )  CGFloat  gxScreenMinRatio;
@property (nonatomic )  CGFloat  gxScreenMaxRatio;

- (void)refreshData;
- (void)refreshDataIfNeed;
@end
