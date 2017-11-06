//
//  ViewController.m
//  VCreditNetworkDemo
//
//  Created by SkyHarute on 2017/7/31.
//  Copyright © 2017年 SkyHarute. All rights reserved.
//

#import "ViewController.h"
#import "VCPostController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
    
//    [self setSuccessBlock:^(id obj){
//        NSLog(@"1");
//    }];
//    NSDictionary *dict = [NSDictionary dictionary];
//    [[VCNetworkingManager shareManager] postUrl:@"/getShareInfo" params:dict class:[VCBaseModel class] completion:self.successBlock];
}

#pragma mark UI
- (void)initView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"VCreditNetworkDemo"];
}

#pragma mark delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
            vc = [[VCPostController alloc] init];
            break;
            
        default:
            vc = [UIViewController new];
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VCreditNetworkDemo" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"POST";
            break;
            
        default:
            break;
    }
    return cell;
}

@end
