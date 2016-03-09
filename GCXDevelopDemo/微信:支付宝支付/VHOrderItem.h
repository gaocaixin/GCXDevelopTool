//
//  VHOrderModel.h
//  VhallIphone
//
//  Created by vhall on 15/8/6.
//  Copyright (c) 2015年 www.vhall.com. All rights reserved.
//

#import "VHBaseNetModel.h"

@interface VHOrderItem : VHBaseNetModel
@property (strong,nonatomic)NSString* amount;// = "0.01";
@property (strong,nonatomic)NSString* body;// = 123456;
@property (strong,nonatomic)NSString* callback;// = "http://e.vhall.com/pay/app";
@property (strong,nonatomic)NSString* order_id;// = 14388404595127;
@property (strong,nonatomic)NSString* partner;// = 2088011508184288;
@property (strong,nonatomic)NSString* privateKey;//
@property (strong,nonatomic)NSString* seller;// = "yanting.lin@vhall.com";
@property (strong,nonatomic)NSString* subject;// = 123456;

@property (strong,nonatomic)NSString* appid;// = wxe318f9021d5df149;
@property (strong,nonatomic)NSString* noncestr;//  = a6eyHFbcTBk2AG6D;
@property (strong,nonatomic)NSString* package;//  = "Sign=WXPay";
@property (strong,nonatomic)NSString* partnerid;//  = 1234602402;
@property (strong,nonatomic)NSString* prepayid;//  = wx20151029184918169fb9d7ab0706784195;
@property (strong,nonatomic)NSString* sign;//  = FBB500BA734F597DE62F73DE0765C9A9;
@property (strong,nonatomic)NSString* timestamp;//  = 1446115758;
@end
