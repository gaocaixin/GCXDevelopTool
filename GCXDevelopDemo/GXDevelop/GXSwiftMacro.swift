//
//  LCSwiftMacro.swift
//  LOCO
//
//  Created by Gordon on 2017/2/9.
//  Copyright © 2017年 AlphaMobile. All rights reserved.
//

import UIKit

//  宽度，高度适配
func kFitWid(_ wid: CGFloat) -> CGFloat {
    return GXDevelopExtern.shared().gxScreenWidthRatio * wid
}
func kFitHei(_ height: CGFloat) -> CGFloat {
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



func kESLightFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-Light", size: fontSize)!
}
func kESMediumFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-Medium", size: fontSize)!
}
func kESRegularFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-Regular", size: fontSize)!
}
func kESSemiBoldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-SemiBold", size: fontSize)!
}
func kSWBoldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-Bold", size: fontSize)!
}
func kSWHeavyFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.init(name: "SFUIText-Heavy", size: fontSize)!
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
    return UIColor.gxColor(with: 119.313, green: 53.2, blue: 255)
}
