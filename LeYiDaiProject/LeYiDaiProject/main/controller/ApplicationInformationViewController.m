//
//  ApplicationInformationViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "ApplicationInformationViewController.h"
#import "FinishAuthenViewController.h"

#import "ApplyInfoTableViewCell.h"
#import "BRPickerView.h"

#import "CustInfoUpModel.h"
@interface ApplicationInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *applyTable;

@property (nonatomic,strong)NSArray *leftArray;

@property (nonatomic,strong)NSArray *placehodelArray;

@property (nonatomic,strong)FSCustomButton *nextBut;

@property (nonatomic,strong)UITextField *houseAddressTextFile; // 住宅详细t地址
@property (nonatomic,strong)UITextField *workAddressTextFile; // 工作详细地址

@property (nonatomic,strong)NSArray *custSexArray; //性别数组
@property (nonatomic,strong)NSArray *custNationArray; //民族    数组
@property (nonatomic,strong)NSArray *custMarrsignArray; //婚姻状况    数组
@property (nonatomic,strong)NSArray *custEducationArray; //最高学历    数组
@property (nonatomic,strong)NSArray *custIncomeArray; //税后月收入    数组
@property (nonatomic,strong)NSArray *houseDescArray; //住房情况    数组
@property (nonatomic,strong)NSArray *custCorpkindArray; //单位性质    数组

@property (nonatomic,strong)CustInfoUpModel *custInfoModel;

@property (nonatomic,strong)NSMutableArray *selectArray; // 选择的数组
@end

@implementation ApplicationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-申请资料";
    self.leftArray = @[@[@"*最高学历",@"*婚姻状况",@"*住宅地址",@"*紧急联系人1",@"*紧急联系人2"],@[@"*单位名称",@"*单位地址",@"*从事职业",@"*职务级别",@"*月收入"]] ;
    self.placehodelArray = @[@[@"本科",@"未婚",@"请选择地址",@"通讯录添加",@"通讯录添加"],@[@"南京XXX科技公司",@"请选择地址",@"请选择",@"普通员工",@"请选择"]];
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
    self.selectArray = [NSMutableArray array];
    [self.selectArray addObject:arr1];
    [self.selectArray addObject:arr2];

    
    self.custSexArray = @[@"男",@"女"];
    self.custNationArray = @[@"汉族",@"壮族",@"回族",@"满族",@"其他"];
    self.custMarrsignArray = @[@"未婚",@"已婚",@"离异"];
    self.custEducationArray = @[@"大专以下",@"大专",@"本科",@"本科以上"];
    self.custIncomeArray = @[@"3000以下",@"3000-5000",@"5000-10000",@"1万以上"];
    self.houseDescArray = @[@"有自住房",@"租房"];
    self.custCorpkindArray = @[@"国企",@"私企",@"外企",@"其他"];
    
    
    [self.view addSubview:self.applyTable];
    [self.applyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.applyTable.tableFooterView = [self footerView];
    
}
-(void)nextButtonClick{
    
    NSDictionary *dataDic = @{@"userId":self.loginModel.userId,@"custEducation":self.custInfoModel.custEducation,@"custMarrsign":self.custInfoModel.custMarrsign,@"custAreacode":self.custInfoModel.custAreacode,@"custAddr":self.custInfoModel.custAddr,@"relation1Mobile":self.custInfoModel.relation1Mobile,@"relation1Name":self.custInfoModel.relation1Name,@"relation2Mobile":self.custInfoModel.relation2Mobile,@"relation2Name":self.custInfoModel.relation2Name,@"custCorpration":self.custInfoModel.custCorpration,@"workAreacode":self.custInfoModel.workAreacode,@"workAddr":self.custInfoModel.workAddr,@"custCorpkind":self.custInfoModel.custCorpkind,@"custJob":self.custInfoModel.custJob,@"custIncome":self.custInfoModel.custIncome};
    
    [[RequestAPI shareInstance] useCustAuthCustInfoUp:dataDic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if ([result[@"success"] intValue] == 1) {
            
            FinishAuthenViewController *finishVc = [[FinishAuthenViewController alloc] init];
            [self.navigationController pushViewController:finishVc animated:YES];
        }else{
            
            [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

        }
    }];

}
-(UIView *)footerView{
    
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    
    [footView addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.centerX.equalTo(footView);
        make.width.mas_equalTo(SCREEN_WIDTH-27*2);
        make.height.mas_equalTo(45);
        
    }];
    
    
    return footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40.f;
    }else{
        return 8.f;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"基本信息";
    }else{
        return @"";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ApplyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ApplyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    cell.leftLab.text = self.leftArray[indexPath.section][indexPath.row];
    cell.textFiled.placeholder = self.placehodelArray[indexPath.section][indexPath.row];
    cell.textFiled.enabled = NO;
    cell.textFiled.text = self.selectArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            cell.bottomTextFiled.placeholder = @"详细地址填写";
            cell.bottomTextFiled.hidden = NO;
            cell.botttomTextIsHide = NO;
            self.houseAddressTextFile = cell.bottomTextFiled;
        }else{
            cell.bottomTextFiled.hidden = YES;
            cell.botttomTextIsHide = YES;
        }
        
        
    }else{
        if (indexPath.row == 1) {
            cell.bottomTextFiled.placeholder = @"详细地址如: 道路、门牌号、小区、楼栋号";
            cell.bottomTextFiled.hidden = NO;
            cell.botttomTextIsHide = NO;
            self.workAddressTextFile = cell.bottomTextFiled;
        }else{
            cell.bottomTextFiled.hidden = YES;
            cell.botttomTextIsHide = YES;

        }
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.textFiled.enabled = YES;
        }
    }
    @weakify(self);
    cell.textBack = ^(NSString * _Nonnull textStr) {
        @strongify(self);
        if (indexPath.row == 0) {
            NSMutableArray *selectArr2 = self.selectArray[1];
            [selectArr2 replaceObjectAtIndex:0 withObject:textStr];
             [self.selectArray replaceObjectAtIndex:1 withObject:selectArr2];
             
             self.custInfoModel.custCorpration = textStr;
        }else if (indexPath.row == 3){
            NSMutableArray *selectArr2 = self.selectArray[1];
           [selectArr2 replaceObjectAtIndex:3 withObject:textStr];
            [self.selectArray replaceObjectAtIndex:1 withObject:selectArr2];
            
            self.custInfoModel.custJob = textStr;
        }
        
        [self checkButtonEnble];
    };
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    @weakify(self);
    if (indexPath.section == 0) {
        NSMutableArray *selectArr1 = self.selectArray[0];
        if (indexPath.row == 0) {
            
            [BRStringPickerView showStringPickerWithTitle:@"选择学历" dataSource:self.custEducationArray defaultSelValue:@"本科" isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(id selectValue) {
                @strongify(self);
                [selectArr1 replaceObjectAtIndex:0 withObject:selectValue];
                [self.selectArray replaceObjectAtIndex:0 withObject:selectArr1];
               NSUInteger tegerInde = [self.custEducationArray indexOfObject:selectValue];
                
                self.custInfoModel.custEducation = [NSString stringWithFormat:@"%ld",tegerInde];
                
                [self.applyTable reloadData];

                [self checkButtonEnble];

            }];
        }else if (indexPath.row == 1){
            [BRStringPickerView showStringPickerWithTitle:@"婚姻状况" dataSource:self.custMarrsignArray defaultSelValue:@"未婚" isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(id selectValue) {
                @strongify(self);
                  [selectArr1 replaceObjectAtIndex:1 withObject:selectValue];
                  [self.selectArray replaceObjectAtIndex:0 withObject:selectArr1];
                
                 NSUInteger tegerInde = [self.custMarrsignArray indexOfObject:selectValue];
                  
                  self.custInfoModel.custMarrsign = [NSString stringWithFormat:@"%ld",tegerInde];
                  
                  [self.applyTable reloadData];
                  [self checkButtonEnble];
            
            }];
        }else if (indexPath.row == 2){
            
            // 获取文件路径
               NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
               // 将文件数据化
               NSData *data = [[NSData alloc] initWithContentsOfFile:path];
               // 对数据进行JSON格式化并返回字典形式
               NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            NSArray *defaultSelArr = [@"江苏省 南京市 雨花台区" componentsSeparatedByString:@" "];
            
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataArr defaultSelected:defaultSelArr isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                
                    NSLog(@"选择了地址 %@   %@  %@",province.code,city.code,area.code);
                @strongify(self);
                 [selectArr1 replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name]];
                 [self.selectArray replaceObjectAtIndex:0 withObject:selectArr1];
                 
                self.custInfoModel.custAreacode = [NSString stringWithFormat:@"%@%@%@",province.code,city.code,area.code];
                 
                 [self.applyTable reloadData];
                [self checkButtonEnble];

            } cancelBlock:^{
                
            }];
            
                       
        }else if (indexPath.row == 3){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入联系人信息" preferredStyle:UIAlertControllerStyleAlert];
                //以下方法就可以实现在提示框中输入文本；
                
                //在AlertView中添加一个输入框
                [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                    textField.placeholder = @"请输入联系人姓名";
                }];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.placeholder = @"请输入联系人电话";
            }];
                
                //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                    UITextField *secondTextField = alertController.textFields.lastObject;

                  [selectArr1 replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@ %@",envirnmentNameTextField.text,secondTextField.text]];
                    [self.selectArray replaceObjectAtIndex:0 withObject:selectArr1];
                                  
                    self.custInfoModel.relation1Name = envirnmentNameTextField.text;
                    self.custInfoModel.relation1Mobile = secondTextField.text;
                    [self.applyTable reloadData];
                    //输出 检查是否正确无误
                    [self checkButtonEnble];
                    
                }]];
                
                //添加一个取消按钮
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                
                //present出AlertView
                [self presentViewController:alertController animated:true completion:nil];
           
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入联系人信息" preferredStyle:UIAlertControllerStyleAlert];
                           //以下方法就可以实现在提示框中输入文本；
                           
                           //在AlertView中添加一个输入框
                           [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                               
                               textField.placeholder = @"请输入联系人姓名";
                           }];
                       [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                           textField.keyboardType = UIKeyboardTypeNumberPad;
                           textField.placeholder = @"请输入联系人电话";
                       }];
                           
                           //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
                           [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                               UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                               UITextField *secondTextField = alertController.textFields.lastObject;

                            [selectArr1 replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@ %@",envirnmentNameTextField.text,secondTextField.text]];
                            [self.selectArray replaceObjectAtIndex:0 withObject:selectArr1];
                                                                
                            self.custInfoModel.relation2Name = envirnmentNameTextField.text;
                            self.custInfoModel.relation2Mobile = secondTextField.text;
                            [self.applyTable reloadData];
                             
                               //输出 检查是否正确无误
                               [self checkButtonEnble];
                           }]];
                           
                           //添加一个取消按钮
                           [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                           
                           //present出AlertView
                           [self presentViewController:alertController animated:true completion:nil];
            
        }
    }else{
        NSMutableArray *selectArr2 = self.selectArray[1];
        
        if (indexPath.row == 1) {
            // 获取文件路径
               NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
               // 将文件数据化
               NSData *data = [[NSData alloc] initWithContentsOfFile:path];
               // 对数据进行JSON格式化并返回字典形式
               NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            NSArray *defaultSelArr = [@"江苏省 南京市 雨花台区" componentsSeparatedByString:@" "];
            
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataArr defaultSelected:defaultSelArr isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                
                    NSLog(@"选择了地址 %@   %@  %@",province.code,city.code,area.code);
                @strongify(self);
                 [selectArr2 replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name]];
                 [self.selectArray replaceObjectAtIndex:1 withObject:selectArr2];
                 
                self.custInfoModel.workAreacode = [NSString stringWithFormat:@"%@%@%@",province.code,city.code,area.code];
                 
                 [self.applyTable reloadData];
                [self checkButtonEnble];

            } cancelBlock:^{
                
            }];
        }else if (indexPath.row == 2){
            [BRStringPickerView showStringPickerWithTitle:@"从事职业" dataSource:self.custCorpkindArray defaultSelValue:@"国企" isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(id selectValue) {
                @strongify(self);
                  [selectArr2 replaceObjectAtIndex:2 withObject:selectValue];
                  [self.selectArray replaceObjectAtIndex:1 withObject:selectArr2];
                 NSUInteger tegerInde = [self.custCorpkindArray indexOfObject:selectValue];
                  
                  self.custInfoModel.custCorpkind = [NSString stringWithFormat:@"%ld",tegerInde];
                  
                  [self.applyTable reloadData];
                [self checkButtonEnble];
            
            }];
        }else if (indexPath.row == 4){
            [BRStringPickerView showStringPickerWithTitle:@"月收入" dataSource:self.custIncomeArray defaultSelValue:@"1万以上" isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(id selectValue) {
                @strongify(self);
                  [selectArr2 replaceObjectAtIndex:4 withObject:selectValue];
                  [self.selectArray replaceObjectAtIndex:1 withObject:selectArr2];
                 NSUInteger tegerInde = [self.custIncomeArray indexOfObject:selectValue];
                  
                  self.custInfoModel.custIncome = [NSString stringWithFormat:@"%ld",tegerInde];
                  
                  [self.applyTable reloadData];
                [self checkButtonEnble];
            
            }];
        }

        
    }

}

-(void)checkButtonEnble{
    self.custInfoModel.custAddr = self.houseAddressTextFile.text;
    self.custInfoModel.workAddr = self.workAddressTextFile.text;
    if (STRING_ISNIL(self.custInfoModel.custEducation) || STRING_ISNIL(self.custInfoModel.custMarrsign) ||STRING_ISNIL(self.custInfoModel.custAreacode) ||STRING_ISNIL(self.custInfoModel.custAddr) ||STRING_ISNIL(self.custInfoModel.relation1Mobile) ||STRING_ISNIL(self.custInfoModel.relation1Name) ||STRING_ISNIL(self.custInfoModel.relation2Mobile) ||STRING_ISNIL(self.custInfoModel.relation2Name) ||STRING_ISNIL(self.custInfoModel.custCorpration) ||STRING_ISNIL(self.custInfoModel.workAreacode) || STRING_ISNIL(self.custInfoModel.workAddr) ||STRING_ISNIL(self.custInfoModel.custCorpkind) ||STRING_ISNIL(self.custInfoModel.custJob) ||STRING_ISNIL(self.custInfoModel.custIncome)) {
        self.nextBut.enabled = NO;
    }else{
        self.nextBut.enabled = YES;
    }
}
-(UITableView *)applyTable{
    if (!_applyTable) {
        _applyTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _applyTable.estimatedRowHeight = 50;
        _applyTable.rowHeight = UITableViewAutomaticDimension;
        _applyTable.sectionFooterHeight = 0.1;

        _applyTable.dataSource = self;
        _applyTable.delegate = self;
    }
    return _applyTable;
}

-(FSCustomButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
       [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
       _nextBut.layer.shadowOpacity = 1;
       _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
       _nextBut.layer.shadowRadius = 9;
        _nextBut.enabled = NO;
        _nextBut.timeInterval = 3;
        _nextBut.titleLabel.font = BOLDFONT(18);
        [_nextBut setTitle:@"提交审核" forState:UIControlStateNormal];
        [_nextBut addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBut;
}
-(CustInfoUpModel *)custInfoModel{
    if (!_custInfoModel) {
        _custInfoModel = [[CustInfoUpModel alloc] init];
    }
    return _custInfoModel;
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
