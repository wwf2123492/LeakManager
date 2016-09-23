//
//  LeakManager.h
//  jd
//
//  Created by cdyjy-cdwutao3 on 16/1/23.
//  Copyright © 2016年 LogDebug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LeakManager : NSObject


+ (void)viewControllerWillDisAppear:(UIViewController*)viewController;

+ (void)viewControllerDidDisAppear:(UIViewController*)viewController;
@end
