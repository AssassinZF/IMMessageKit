//
//  TabbarViewController.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "TabbarViewController.h"
#import "MessageListViewController.h"
#import "ChaViewController.h"
#import "BaseNavViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MessageListViewController *messageVc = [[MessageListViewController alloc] init];
    [self addChildVc:messageVc title:@"消息" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    
    UIViewController *applicationVc = [[UIViewController alloc] init];
    applicationVc.view.backgroundColor = [UIColor whiteColor];
    [self addChildVc:applicationVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = XZColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = XZColor(26, 178, 10);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    
}



@end
