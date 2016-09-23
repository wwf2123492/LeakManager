//
//  TestLeakViewController.m
//  leakManager
//
//  Created by cdyjy-cdwutao3 on 16/9/23.
//  Copyright © 2016年 horace. All rights reserved.
//

#import "TestLeakViewController.h"
#import "LeakManager.h"

@interface TestLeakViewController ()
@property (strong,nonatomic) NSObject* recycleSelf;
@end

@implementation TestLeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.isLeak){
        self.recycleSelf = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapBtn:(id)sender {
    if(self.isPush){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
    }

}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [LeakManager viewControllerWillDisAppear:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [LeakManager viewControllerDidDisAppear:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
