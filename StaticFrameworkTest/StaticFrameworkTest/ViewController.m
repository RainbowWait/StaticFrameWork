//
//  ViewController.m
//  StaticFrameworkTest
//
//  Created by 郑小燕 on 2017/10/12.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

#import "ViewController.h"
#import "StaticFramework.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int i = [StaticFramework addMethodByFirst:10 andSecond:10];
    NSLog(@"%ld",i);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
