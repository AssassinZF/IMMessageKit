//
//  ChaViewController.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConversationModel;

@interface ChatViewController : UIViewController
@property (nonatomic, strong)ConversationModel *conversationModel;//传入会话模型
@property (nonatomic, strong)UITableView *tableview;
@end
