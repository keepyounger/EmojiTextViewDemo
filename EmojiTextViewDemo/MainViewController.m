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

@interface MainViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, BaseInputBarDelegate>
@property (nonatomic, strong) BaseInputBar *inputBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic) CGRect keyboardRect;//键盘rect

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor colorWithR:240 G:240 B:240];
    
    self.dataSource = [NSMutableArray array];
    
    _inputBar = [[BaseInputBar alloc] init];
    _inputBar.delegage = self;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-NavBarHeight-StatusBarHeight-_inputBar.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    _inputBar.top = self.tableView.bottom;
    
    [self.view addSubview:_inputBar];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //如果不是手势引起的滚动就不执行跟随键盘
    if (scrollView.panGestureRecognizer.numberOfTouches == 0) {
        return;
    }
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:nil];
    
    if (point.y > MainScreenHeight-_inputBar.height || point.y < MainScreenHeight-self.keyboardRect.size.height) {
        return;
    }
    
    point.y = point.y - NavBarHeight - StatusBarHeight;
    
    _inputBar.top = point.y;
    self.tableView.height = point.y;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellname";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)sendMessageWithMsg:(NSString *)msg
{
    [self.dataSource addObject:msg];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    if (self.dataSource.count) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    _keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSLog(@"%@", [NSValue valueWithCGRect:_keyboardRect]);
    
    self.tableView.height = MainScreenHeight-NavBarHeight-StatusBarHeight-self.keyboardRect.size.height;
    _inputBar.top = MainScreenHeight-NavBarHeight-StatusBarHeight-self.keyboardRect.size.height;
    
    if (self.dataSource.count) {
        NSIndexPath *indexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    _keyboardRect = CGRectZero;
    
    self.tableView.height = MainScreenHeight-NavBarHeight-StatusBarHeight-_inputBar.height-self.keyboardRect.size.height;
    _inputBar.top = self.tableView.bottom;
    
}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addKeyboardNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeyboardNotification];
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
