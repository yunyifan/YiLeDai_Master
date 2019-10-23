//
//  RepayRecordDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepayRecordDetialViewController.h"
#import "RepayDetialTableViewCell.h"

@interface RepayRecordDetialViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *recordTable;
@end

@implementation RepayRecordDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];
    self.navigationItem.title = @"还款记录";
    [self.view addSubview:self.recordTable];
    [self.recordTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepayDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[RepayDetialTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    [cell setCellData:self.dataArray[indexPath.row]];
    return cell;
}
-(UITableView *)recordTable{
    if (!_recordTable) {
        _recordTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _recordTable.delegate = self;
        _recordTable.dataSource = self;
        _recordTable.rowHeight = 187;
        _recordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recordTable.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];
        [_recordTable registerClass:[RepayDetialTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _recordTable;
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
