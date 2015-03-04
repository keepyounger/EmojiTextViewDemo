//
//  MainViewController.m
//  EmojiTextViewDemo
//
//  Created by lixy on 15/3/4.
//  Copyright (c) 2015年 lixy. All rights reserved.
//

#import "MainViewController.h"
#import "BaseInputBar.h"
#import "UIKit+BaseExtension.h"

@interface MainViewController ()
@property (nonatomic, strong) BaseInputBar *inputBar;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _inputBar = [[BaseInputBar alloc] init];
    _inputBar.top = 200;
    [self.view addSubview:_inputBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
