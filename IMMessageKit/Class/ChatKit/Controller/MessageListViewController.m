//
//  MessageListViewController.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "MessageListViewController.h"
#import "ConversationTableViewCell.h"
#import "ConversationModel.h"
#import "ChatViewController.h"

static CGFloat CELL_H = 67.0;

@interface MessageListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//加载假数据
-(void)loadData{
    for (NSInteger i = 0; i < 2; i ++) {
        ConversationModel *model = [[ConversationModel alloc] init];
        model.unReadCount = 20;
        model.conversationName = @"马云";
        model.lastMsgString = @"你好啊你好啊你好啊";
        [self.dataArray addObject:model];
    }
    [self.tableview reloadData];
}

#pragma mark ------------------------- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConversationTableViewCell *cell = [ConversationTableViewCell cellWithTableView:tableView];
    if (indexPath.row == self.dataArray.count - 1) {
        [cell setBottomLineStyle:CellLineStyleNone];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    cell.conversationModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *topTitle ,*readTitle;
    ConversationModel *group  = self.dataArray[indexPath.row];
    topTitle  = group.isTop ? @"取消置顶" : @"置顶";
    readTitle = group.unReadCount ? @"标为已读" : @"标为未读";
    //设置删除按钮
    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    //置顶
    UITableViewRowAction * topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:topTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    //标记已读
    UITableViewRowAction * collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:readTitle handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    collectRowAction.backgroundColor = [UIColor grayColor];
    topRowAction.backgroundColor     = [UIColor orangeColor];
    return  @[deleteRowAction,topRowAction,collectRowAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationModel *model = self.dataArray[indexPath.row];
    ChatViewController *chat = [[ChatViewController alloc] init];
    chat.conversationModel = model;
    [self.navigationController pushViewController:chat animated:YES];
}


#pragma mark ------------------------- Getr


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = XZRGB(0xf4f1f1);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = CELL_H;
        _tableview.tableFooterView = [UIView new];
        [self.view addSubview:_tableview];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
