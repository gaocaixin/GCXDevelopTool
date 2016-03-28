//
//  ViewController.m
//  GXDevelopDemo
//
//  Created by 高才新 on 16/1/29.
//  Copyright © 2016年 高才新. All rights reserved.
//

#import "ViewController.h"
#import "GXDevelop.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100,100)];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    btn.backgroundColor = [UIColor grayColor];
    btn.gxTitlesNHSD = @[@"tap",[NSNull null],@"tap-s"];
    btn.layer.cornerRadius = 50;
    [btn setBackgroundImage:[UIImage gxImageWithColor:[UIColor grayColor] size:CGSizeMake(100, 100) cornerRadius:50] forState:UIControlStateNormal];
    [btn gxAddTapRippleEffectWithColor:[UIColor grayColor] scaleMaxValue:2 duration:0.6];
    
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

@end
