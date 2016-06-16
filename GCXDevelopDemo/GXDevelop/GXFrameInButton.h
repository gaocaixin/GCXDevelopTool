//
//  GXFrameInButton.h
//  LOCO
//
//  Created by 高才新 on 16/2/26.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface GXFrameInButton : UIButton

@property (nonatomic) CGRect gxTitleLabelFrame;
@property (nonatomic) CGRect gxImageViewFrame;

@property (nonatomic) BOOL isExchangePosition;

@property (nonatomic) BOOL isAnimationClick;
@end
