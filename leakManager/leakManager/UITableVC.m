//
//  UITableVC.m
//  leakManager
//
//  Created by cdyjy-cdwutao3 on 16/9/23.
//  Copyright © 2016年 horace. All rights reserved.
//

#import "UITableVC.h"
#import "TestLeakViewController.h"

@interface UITableVC ()

@end

@implementation UITableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellStr = @"cellStr";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    if(indexPath.row == 0){
        cell.textLabel.text = @"nomal push";
    }
    else if(indexPath.row == 1){
        cell.textLabel.text = @"Leak push";
    }
    else if(indexPath.row == 2){
        cell.textLabel.text = @"nomal present";
    }
    else if(indexPath.row == 3){
        cell.textLabel.text = @"Leak present";
    }
    
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TestLeakViewController* testViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TestLeakViewController"];
    if(indexPath.row == 0){
        testViewController.isPush = YES;
        testViewController.isLeak = NO;
    }
    else if(indexPath.row == 1){
        testViewController.isPush = YES;
        testViewController.isLeak = YES;
    }
    else if(indexPath.row == 2){
        testViewController.isPush = NO;
        testViewController.isLeak = NO;
    }
    else if(indexPath.row == 3){
        testViewController.isPush = NO;
        testViewController.isLeak = YES;
    }
    
    if(testViewController.isPush){
        [self.navigationController pushViewController:testViewController animated:YES];
    }
    else{
        [self presentViewController:testViewController   animated:YES completion:nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
