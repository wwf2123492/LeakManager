//
//  LeakManager.m
//  jd
//
//  Created by cdyjy-cdwutao3 on 16/1/23.
//  Copyright © 2016年 LogDebug. All rights reserved.
//

#import "LeakManager.h"
#import "objc/runtime.h"

static char GuidKey;

typedef NS_ENUM(NSInteger, LeakStatus)
{
    status_No =0,
    status_Nav = 1,
    status_Pre = 2,
    status_Nav_Pre = 3
};

@interface LeakManager()
@property (nonatomic,strong) NSMutableDictionary * statusDic;

+ (instancetype)sharedManager;
@end;

@implementation LeakManager
+ (instancetype)sharedManager {
    static LeakManager *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[LeakManager alloc] init];
    });
    return service;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        self.statusDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return self;
}

- (NSString*)createGuid
{
    CFUUIDRef guidref = CFUUIDCreate(kCFAllocatorDefault);
    NSString * guid = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, guidref));
    CFRelease(guidref);
    return guid;
}

- (LeakStatus)checkStatus :(UIViewController*)viewControll {
    LeakStatus Nav = viewControll.navigationController?status_Nav:status_No;
    LeakStatus Pre = viewControll.presentingViewController?status_Pre:status_No;
    return Nav+Pre;
}

+ (void)viewControllerWillDisAppear:(UIViewController*)viewController {
    NSString * uuid = objc_getAssociatedObject(viewController, &GuidKey);
    if (!uuid) {
        uuid = [[LeakManager sharedManager] createGuid];
        objc_setAssociatedObject(viewController, &GuidKey , uuid, OBJC_ASSOCIATION_COPY);
    }
    [LeakManager sharedManager].statusDic[uuid] = @([[LeakManager sharedManager] checkStatus:viewController]);

}

+ (void)viewControllerDidDisAppear:(UIViewController*)viewController {
    NSString * uuid = objc_getAssociatedObject(viewController, &GuidKey);
    if (uuid) {
        LeakStatus currentStatus = [[LeakManager sharedManager] checkStatus:viewController];
        if (currentStatus == status_No) {
            [[LeakManager sharedManager] checkLeak:viewController];

        }
        else if(currentStatus == status_Nav) {
            NSNumber* status = [LeakManager sharedManager].statusDic[uuid];
            if ([status integerValue] == status_Nav_Pre) {
                [[LeakManager sharedManager] checkLeak:viewController];
            }
        }
    }
}

-(void)checkLeak:(UIViewController*)viewController {
    NSString * name = NSStringFromClass([viewController class]);
    __weak UIViewController * weakVC = viewController;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakVC) {
            NSLog(@"%@ leak,please check",name);
            NSAssert(0,@"leak");
        }
    });
}
@end
