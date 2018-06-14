//
//  ViewController.m
//  UCNetworkingDemo
//
//  Created by 范杨 on 2018/6/12.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "ViewController.h"
#import "UCNetworking.h"
#import <AdSupport/AdSupport.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UCNetworkingManager shareManager] postUrl:@"" cacheUrl:@"" params:nil completion:^(NSDictionary *responseObject, UCAPIManagerResponseStatesType responseStates) {
        
    } failure:^(NSError *error) {
        
    } cacheDictCallBackBlock:^(NSDictionary *cacheDict) {
        
    }];
   
}
- (IBAction)didClickNextButton:(id)sender {
    
}

@end
