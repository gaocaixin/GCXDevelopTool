//
//  NSAttributedString+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/1/19.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface NSAttributedString (GXDevelop)
/**
 *计算 size
 */
- (CGSize )gxSizeWithLimitSize:(CGSize )limitSize;

- (CGSize)gxPrefersizeWith:(CGSize)size;
@end
