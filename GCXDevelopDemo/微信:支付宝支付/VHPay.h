//
//  VHPay.h
//  VhallIphone
//
//  Created by vhall on 15/10/30.
//  Copyright © 2015年 www.vhall.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "VHOrderItem.h"

//支付宝
#import "DataSigner.h" // demo 有
#import "Order.h" // demo 有
#import <AlipaySDK/AlipaySDK.h>

@protocol VHPayDelegate <NSObject>

- (void)payResult:(int)type msg:(NSString*)msg;//type 1 成功  2 失败   4 未安装微信客户端

@end

@interface VHPay : NSObject<WXApiDelegate>

@property (nonatomic,assign) id <VHPayDelegate>delegate;
@property (assign,nonatomic) int type;//0表示购买，1表示打赏

+ (VHPay *)shareInstance;


- (void)aliKillAppWithURL:(NSURL *)url;
//阿里支付宝
- (void)aliPayWithPayModel:(VHOrderItem*)orderItem;

//阿里支付宝回调
- (void)aliResponDict:(NSDictionary * )resultDic;

//微信支付
- (void)wxPayWithPayModel:(VHOrderItem*)orderItem;

//微信支付回调
- (void)onWXResp:(BaseResp *)resp;

@end
