//
//  ViewController.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/1/29.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "ViewController.h"
#import "GXDevelop.h"

#import "BezierPath.h"
#define UIColorFromRGBA_hex(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
@interface ViewController ()
@property (nonatomic, strong)UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, GXWidthFitFloat(100),GXHeightFitFloat(100))];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    btn.backgroundColor = [UIColor grayColor];
    btn.gxTitlesNHSD = @[@"tap",[NSNull null],@"tap-s"];
    btn.layer.cornerRadius = 50;
    [btn setBackgroundImage:[UIImage gxImageWithColor:[UIColor grayColor] size:CGSizeMake(100, 100) cornerRadius:50] forState:UIControlStateNormal];
    [btn gxAddTapRippleEffectWithColor:[UIColor grayColor] scaleMaxValue:2 duration:0.6];
    _btn = btn;
    
//    [btn gxAddSlideHighlightedEffect];
    
    BezierPath *path = [[BezierPath alloc] initWithFrame:CGRectMake(50, 400, 200, 150)];
    [self.view addSubview:path];
    path.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *layer = [CAGradientLayer gxGradientLayerWithColors:@[ (__bridge id)UIColorFromRGBA_hex(0x006AFF, 1).CGColor,(__bridge id)UIColorFromRGBA_hex(0x00A8FF, 1).CGColor] layerFrame:path.frame direction:GXGradientLayerDirectionTopToDown];
    [self.view.layer addSublayer:layer];
    layer.mask = path.layer;
    path.frame = layer.bounds;
}

- (void)tap:(UIButton *)btn
{
    btn.selected= !btn.selected;
    NSLog(@"tap");
    btn.gxTitleColorsNHSD = @[[UIColor redColor],[NSNull null],[UIColor blackColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

@end
