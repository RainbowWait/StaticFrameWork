//
//  AppDelegate.h
//  StaticFrameworkTest
//
//  Created by 郑小燕 on 2017/10/12.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

