//
//  VHPay.m
//  VhallIphone
//
//  Created by vhall on 15/10/30.
//  Copyright © 2015年 www.vhall.com. All rights reserved.
//

#import "VHPay.h"

static VHPay * _sharedInstance = nil;
@implementation VHPay

+ (VHPay *)shareInstance {
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[VHPay alloc]init];
        }
        return _sharedInstance;
    }
}

#pragma  mark 阿里支付宝
- (void)aliPayWithPayModel:(VHOrderItem*)orderItem
{
    /*============================================================================*/
    NSString *partner = orderItem.partner;
    NSString *seller = orderItem.seller;
    NSString *privateKey = orderItem.privateKey;
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"支付失败，不能购买"
                                                       delegate:self
                                              cancelButtonTitle:VHMSG_OK
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderItem.order_id; //订单ID（由商家自行制定）
    order.productName = orderItem.subject; //商品标题
    order.productDescription = orderItem.subject; //商品描述
    order.amount = orderItem.amount; //商品价格
    order.notifyURL =  orderItem.callback; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"vhalliphone";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        NSLog(@"the ordersetring is %@",orderString);
        
        //此处很关键 使用block将支付结果返回
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:AliPayAppScheme callback:^(NSDictionary *resultDic) {
            
            [self aliResponDict:resultDic];
            
                   }];
    }
}

- (void)aliKillAppWithURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             //结果处理
             // AlixPayResult* result = [AlixPayResult itemWithDictory:resultDic];
             [self aliResponDict:resultDic];
//             [self returnPaySuccessFalg:2 msg:@"支付失败1"];
             
         }];
    }


}

- (void)aliResponDict:(NSDictionary * )resultDic
{
    NSLog(@"reslut = %@",resultDic);
//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//    });
    
    NSString * retBuy;
    NSString *code = [resultDic objectForKey:@"resultStatus"];
    if ([code integerValue] == 9000)
    {
        //支付成功
        [self returnPaySuccessFalg:1 msg:(self.type == 0)?@"支付成功":nil];
        retBuy = @"支付成功";
    }
    else
    {
     
        NSString* ret = resultDic[@"memo"];
        if(ret && ret.length>0)
        {
            ret = @"未完成支付，请重新打赏";//支付宝点击取消订单
           
            retBuy=@"支付未完成,请继续支付";
        }
        else
        {
            
            
            ret = @"打赏失败，再来一次";//打赏支付宝返回失败
            retBuy=@"支付失败，请重新支付";//购买
            
        }
        [self returnPaySuccessFalg:2 msg:(self.type == 0)?retBuy:ret];

//        
//        NSString * result ;
//        if (self.type == 0) {
//            result = retBuy;
//        }
//        else{
//            result = ret;
//        }
//        
//       
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil /*@"支付信息"*/
//                                                        message:result delegate:nil
//                                              cancelButtonTitle:@"知道了"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
    }

}


#pragma  mark 微信支付
- (void)wxPayWithPayModel:(VHOrderItem*)orderItem
{
    //微信是否本地客户端
    BOOL isInstalled=[WXApi isWXAppInstalled];
    if (!isInstalled) {
        NSString * msg = @"手机未安装微信，请使用支付宝";
        if (self.type == 0) {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"请安装微信客户端" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alertView show];
        }
        else {
         [self returnPaySuccessFalg:4 msg:msg];
        
        }
       
        return;
    }
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = orderItem.appid;
    req.partnerId           = orderItem.partnerid;
    req.prepayId            = orderItem.prepayid;
    req.nonceStr            = orderItem.noncestr;
    req.timeStamp           = orderItem.timestamp.intValue;
    req.package             = orderItem.package;
    req.sign                = orderItem.sign;
    [WXApi sendReq:req];
}

//微信支付回调
- (void)onWXResp:(BaseResp *)resp {
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        NSString * retBuy;
        NSString * ret;
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付信息"];
        switch (resp.errCode) {
            case WXSuccess:
                retBuy = @"支付成功";
                [self returnPaySuccessFalg:1 msg:(self.type == 0)?retBuy:nil];
                break;
                
            default:
                retBuy = @"支付未完成,请继续支付";
                ret = @"未完成支付，请重新打赏";//微信只有两种区分不开
                [self returnPaySuccessFalg:2 msg:(self.type == 0)?retBuy:ret];
                break;
        }
        
      
    }
    
}


- (void)returnPaySuccessFalg:(int)type msg:(NSString*)msg
{
//    if(type == 2 && msg)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(payResult:msg:)])
    {

        [self.delegate payResult:type msg:msg];
    }

}


@end
