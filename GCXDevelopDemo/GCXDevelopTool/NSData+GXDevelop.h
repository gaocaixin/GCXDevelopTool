//
//  NSData+GXDevelop.h
//  LOCO
//
//  Created by 高才新 on 16/3/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GXDevelop)

/**
 *AES 解密
 */
- (NSData *)gxAES256DecryptWithKey:(NSString *)key;
/**
 *AES 加密 
 */
- (NSData *)gxAES256EncryptWithKey:(NSString *)key;

@end
