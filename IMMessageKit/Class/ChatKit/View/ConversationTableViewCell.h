//
//  ConversationTableViewCell.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZBaseTableViewCell.h"

@class ConversationModel;

@interface ConversationTableViewCell : XZBaseTableViewCell
@property (nonatomic, weak) UIButton *unreadLabel;//未读消息数目
@property (nonatomic, strong)ConversationModel *conversationModel;//会话数据

+ (instancetype)cellWithTableView:(UITableView *)tableView;//重用方法调用cell

@end
