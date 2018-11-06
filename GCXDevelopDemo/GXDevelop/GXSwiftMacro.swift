//
//  LCSwiftMacro.swift
//  LOCO
//
//  Created by Gordon on 2017/2/9.
//  Copyright © 2017年 AlphaMobile. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
import Firebase

func kPTHei(_ num : CGFloat) -> CGFloat {
    return kFitHei(num)
}
func kPTWid(_ num : CGFloat) -> CGFloat {
    return kFitWid(num)
}
func kPTFontSemiBoldWithSize(_ size : CGFloat) -> UIFont {
    return kESSemiBoldFont(size)
}
func kPTFontRegularWithSize(_ size : CGFloat) -> UIFont {
    return kESRegularFont(size)
}
func kPTFontHeavyWithSize(_ size : CGFloat) -> UIFont {
    return kSWHeavyFont(size)
}

let GXIsIPhoneX  = UIDevice.gxIsIphoneX()
let GXiPoneXTop : CGFloat  = UIDevice.gxIsIphoneX() == true ? 44 : 0

func UIColorFromRGB_dec(_ r : CGFloat,_ g : CGFloat,_ b : CGFloat) -> UIColor {
    return UIColor.gxColor(with: r, green: g, blue: b, alpha: 1)
}
func GXColorFromRGBA(_ r : CGFloat,_ g : CGFloat,_ b : CGFloat,_ a : CGFloat) -> UIColor {
    return UIColor.gxColor(with: r, green: g, blue: b, alpha: a)
}

func Localized(_ r : String) -> String {
    return NSString.gxLocalizedString(r)
}
//  宽度，高度适配
func kFitWid(_ wid: CGFloat) -> CGFloat {
    return GXDevelopExtern.shared().gxScreenWidthRatio * wid
}
// for 完美适配 subHeight当前屏幕的差值 designSubHeight设计稿的差值
func kFitHei(_ height: CGFloat, subHeight:CGFloat = 0, designSubHeight:CGFloat = 0) -> CGFloat {
    if subHeight != 0 && designSubHeight != 0 {
        return GXDevelopExtern.shared().gxScreenHeightRatio(withSubHeight: subHeight, designSubHeight: designSubHeight) * height
    }
    return GXDevelopExtern.shared().gxScreenHeightRatio * height
}

func kFitFloorWid(_ wid: CGFloat) -> CGFloat {
    return CGFloat(floorf(Float(GXDevelopExtern.shared().gxScreenWidthRatio * wid)))
}
func kFitCeilWid(_ wid: CGFloat) -> CGFloat {
    return CGFloat(ceilf(Float(GXDevelopExtern.shared().gxScreenWidthRatio * wid)))
}

func kFitMid(_ wid: CGFloat) -> CGFloat {
    return GXDevelopExtern.shared().gxScreenWHminRatio * wid
}

func kFitDevice(xMax: CGFloat, x: CGFloat, other: CGFloat) -> CGFloat {
    return UIDevice.gxIsIphoneXMax() ? xMax : (UIDevice.gxIsIphoneX() ? x : other)
}

func gxSafeAreaInsets() -> UIEdgeInsets {
    
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.keyWindow {
            return window.safeAreaInsets
        }
    } 
    return .zero
    
}
/* SFUIText-Light  SFUIText-Medium SFUIText-Regular  SFUIText-SemiBold SFUIText-Bold SFUIText-Heavy */


func kESLightFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Light", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Light", size: fontSize)!
}
func kESMediumFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Medium", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Medium", size: fontSize)!
}
func kESRegularFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Regular", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Regular", size: fontSize)!
}
func kESSemiBoldFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Semibold", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Semibold", size: fontSize)!
}
func kESBoldFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Bold", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Bold", size: fontSize)!

}
func kSWBoldFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Bold", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Bold", size: fontSize)!
}
func kSWHeavyFont(_ fontSize: CGFloat) -> UIFont {
    if fontSize >= 20.0 {
        return UIFont.init(name: "SFProDisplay-Heavy", size: fontSize)!
    }
    return UIFont.init(name: "SFProText-Heavy", size: fontSize)!
}
func kScreenWidth() ->CGFloat{
    return UIScreen.main.bounds.width
}
func kScreenHeight() ->CGFloat{
    return UIScreen.main.bounds.height
}
func kScreenBounds() ->CGRect{
    return UIScreen.main.bounds
}
//颜色
func kThemeColor() ->UIColor{  //app主题色
//    return UIColor.gxColor(with: 119.313, green: 53.2, blue: 255)
//    return UIColor.gxColor(with: 0, green: 158, blue: 255)
    return UIColor.gxGirlyBase()
}

//统计
func logFBEvent(_ event:String, _ param:[String : Any]? = nil){
     #if !DEBUG
    var param = param
    if param == nil {
        param = [String: Any]()
    }
    if LPInAppPurchaseManager.share().isVIP {
        param!["facey_pro"] = NSNumber.init(value: 1)
    }else {
        param!["facey_pro"] = NSNumber.init(value: 0)
    }
    FBSDKAppEvents.logEvent(event, parameters: param)
    Analytics.logEvent(event, parameters: param!)
    #endif
}

func logAjustEvent(_ event: String) {
    
    #if !DEBUG
    let doneEvent = ADJEvent.init(eventToken: event)
    Adjust.trackEvent(doneEvent)
    #endif
}

func logAjustEventOnce(_ event: String) {
    #if !DEBUG
    let hasSave = UserDefaults.standard.bool(forKey: event)
    if hasSave == true {return}
    logAjustEvent(event)
    UserDefaults.standard.set(true, forKey: event)
    UserDefaults.standard.synchronize()
    #endif
}
//只统计一次
func logFBEventOnce(_ event:String, _ param:[String : Any]? = nil){
    #if !DEBUG
    let hasSave = UserDefaults.standard.bool(forKey: event)
    if hasSave == true {return}
    if param == nil {
        FBSDKAppEvents.logEvent(event);
        Analytics.logEvent(event, parameters: nil)
    } else {
        FBSDKAppEvents.logEvent(event, parameters: param)
        Analytics.logEvent(event, parameters: param!)
    }
    UserDefaults.standard.set(true, forKey: event)
    UserDefaults.standard.synchronize()
    #endif
}
func logCamEvent(_ event:String, _ param:[AnyHashable : Any]? = nil){
//    if param == nil {
//        UXCam.addTag(event)
//    } else {
//        UXCam.addTag(event, withProperties: param)
//    }
}
