//
//  GXTool.m
//  LOCO
//
//  Created by 高才新 on 15/10/28.
//  Copyright © 2015年 IU-Apps. All rights reserved.
//

#import "GXTool.h"
#import "LCAlbumManager.h"

@implementation GXTool

+ (NSString *)timeToDescStr:(NSString *)time
{
    NSDateFormatter *fm  = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"YYYY-MM-dd|HH.mm.ss"];
    
    NSDate *date = [fm dateFromString:time];
    NSDate *newDate = [NSDate date];
    
    NSTimeInterval time1 = [date timeIntervalSince1970];
    NSTimeInterval time2 = [newDate timeIntervalSince1970];
    
    NSTimeInterval timeIntv = time2-time1;
    long timeInt = (long)timeIntv;
    
    if (timeInt < 60) {
        return [NSString stringWithFormat:Localized(@"%ld Seconds Ago"), timeInt];
    } else if (timeInt < 60*60) {
        return [NSString stringWithFormat:Localized(@"%ld Minutes Ago"), timeInt/60];
    } else if (timeInt < 60*60*24) {
        return [NSString stringWithFormat:Localized(@"%ld Hours Ago"), timeInt/60/60];
    } else if (timeInt < 60*60*24*30) {
         return [NSString stringWithFormat:Localized(@"%ld Days Ago"), timeInt/60/60/24];
    } else if (timeInt < 60*60*24*30*12) {
        return [NSString stringWithFormat:Localized(@"%ld Months Ago"), timeInt/60/60/24/30];
    } else {
        return  [NSString stringWithFormat:Localized(@"%ld Years Ago"), timeInt/60/60/24/30/12];
    }
    
    
//    return time;
}

+ (BOOL)isValidName:(NSString *)albumName {
    if (!albumName) return FALSE;
    if ([albumName isEqualToString:@""])   return FALSE;
    if ([albumName isEqualToString:@"."])  return FALSE; // iOS reserved .
    if ([albumName isEqualToString:@".."]) return FALSE; // iOS reserved ..
    if ([[albumName substringToIndex:1] isEqualToString:@" "]) return FALSE; // check if the first characters
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"/\\:*?\""];
    if ([albumName rangeOfCharacterFromSet:set].location != NSNotFound) {
        NSLog(@"This string contains illegal characters");
        return FALSE;
    }
    
    //check if folder existed
    if ([LCAlbumManager getAlbum:albumName])
        return FALSE;
    return TRUE;
}
+ (BOOL)GCXIsValidName:(NSString *)albumName
{
    if ([GXTool isValidName:albumName]) {
        return YES;
    }
    [[ShareManager sharedInstance] showErrorNote:@"Invalid Name! Try Again!"];
    return NO;
}

+ (CGSize )sizeWithText:(NSString*)text limitSize:(CGSize )limitSize  font:(UIFont *)font
{
    CGSize size;
    if([[UIDevice currentDevice].systemVersion doubleValue] >=7.0)
    {
        NSDictionary * attributes = @{NSFontAttributeName:font};
        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:text attributes:attributes];
        CGRect rect = [attributedText boundingRectWithSize:limitSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        size = rect.size;
    }
    else
    {
        //设置label的最大行数
        CGRect rect = [text boundingRectWithSize: limitSize
                                  options: (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                               attributes: @{NSFontAttributeName:font}
                                  context: nil];
        size = rect.size;
    }
    return size;
    
}

+ (NSTimeInterval)timerStrToTimeInt:(NSString *)timerStr
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    fm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"UTC"];
    NSDate *date = [fm dateFromString:timerStr];
    return [date timeIntervalSince1970];
}

@end
