//
//  StaticFramework.h
//  StaticFramework
//
//  Created by 郑小燕 on 2017/10/12.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticFramework : NSObject

/**
 求和

 @param theFirst 第一个参数
 @param theSecond 第二个参数
 @return 整型
 */
+ (int)addMethodByFirst:(int)theFirst andSecond: (int)theSecond;

/**
 求差

 @param theFirst 第一个参数
 @param theSecond 第二个参数
 @return 整型
 */
+ (int) subMethodByFirst: (int)theFirst andSecon: (int)theSecond;
@end
