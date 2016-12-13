//
//  SelectTermViewController.m
//  GlassessBiz
//
//  Created by Guibin on 14-5-22.
//  Copyright (c) 2014年 深圳呱呱网络科技有限公司. All rights reserved.
//

#import "SelectTermViewController.h"
#import "ResultViewController.h"
#import "ReferSal.h"
@interface SelectTermViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    
    IBOutlet UIButton *_btnServeType;
//    IBOutlet UITextField *_textField;
    
    IBOutlet UIView *_showPickViewBg;
    IBOutlet UIPickerView *_pickView;
    
    
    
    NSInteger    _selectType;
//    NSInteger    _serciceSort;
    
}
@end

@implementation SelectTermViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.labTitle.text = IsEnglish ? @"Condition selection": @"条件选择";
    
    _selectType = 0;

    [DataStorer sharedInstance].backQuery = 1;
}

- (IBAction)queryServeTypeAction:(UIButton *)sender {
    [[self.view viewWithTag:100] resignFirstResponder];
    
    [self productSelectIndex];
    
}

- (IBAction)didSelectQueryAction:(UIButton *)sender {
//    NSString *cdkey = @"";
//    if (![self isTextContentBlank:_textField.text]) {
//        cdkey = _textField.text;
//    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"ids":[_arrLds componentsJoinedByString:@","],@"serviceSort":@(_selectType),@"uid":USERID}];
    ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:isPad ?@"ResultViewController-ipad":@"ResultViewController"  bundle:nil dicInfo:dic];
    resultVC.serveType = _btnServeType.titleLabel.text;
    resultVC.resultType = 0;
    
//    if ([DataStorer sharedInstance].backQuery == 1) {
        //进入查询结果页面，并缓存查看过的数据
        [self addReferFileData:dic];
//    }
    
    [self.navigationController pushViewController:resultVC animated:YES];
}
- (void)addReferFileData:(NSDictionary *)dic
{
    NSString *fieldsStr2 = [dic JSONString];
    
    __block BOOL isQuery = NO;
    
     [_arrScanList enumerateObjectsUsingBlock:^(NSDictionary *dicInfo , NSUInteger index, BOOL *stop){
         
         NSMutableDictionary *refDic = [NSMutableDictionary dictionaryWithDictionary:dicInfo];
         [refDic setObject:fieldsStr2 forKey:@"fields"];
         [ReferSal readReferFileData:refDic andUid:USERID];
         
         isQuery = YES;
     }];
    
    if (!isQuery) {
        return;
    }
    NSMutableArray *arrQueryLds = [NSMutableArray arrayWithArray:[SavaData parseArrFromFile:QUERY_LDS_ITEMS]];
    
    NSString *ldsSelect = [[arrQueryLds componentsJoinedByString:@","] JSONString];
    if (arrQueryLds.count) {
        __block BOOL isCollectLDS = NO;
        
        [arrQueryLds enumerateObjectsUsingBlock:^(NSArray *arrLDS, NSUInteger idx, BOOL *stop) {
            NSString *strLDS = [[arrLDS componentsJoinedByString:@","] JSONString];
            if ([ldsSelect isEqualToString:strLDS]) {
                isCollectLDS = YES;
            }
        }];
        if (!isCollectLDS) {
            [arrQueryLds addObject:_arrLds];
            [SavaData writeArrToFile:arrQueryLds FileName:QUERY_LDS_ITEMS];
        }
    }else{
        [arrQueryLds addObject:_arrLds];
        [SavaData writeArrToFile:arrQueryLds FileName:QUERY_LDS_ITEMS];
    }
    
    [DataStorer sharedInstance].backQuery = 2;

    _arrScanList = nil;
    
//    NSMutableArray *arrData = [ReferSal getReferFileData:USERID];
//    
//    __block BOOL isExist = NO;
//    if (arrData.count >0) {
//        [_arrScanList enumerateObjectsUsingBlock:^(NSDictionary *dicInfo , NSUInteger index, BOOL *stop){
//            
//           NSInteger collectID2 = [dicInfo[@"id"] integerValue];
//            
//            [arrData enumerateObjectsUsingBlock:^(NSDictionary *dicInfo2, NSUInteger index2, BOOL *stop2 )
//             {
//                NSInteger collectID = [dicInfo2[@"id"] integerValue];
//                 NSString *fieldsStr = dicInfo2[@"fields"];
//                 LOG(@"collectId = %d-- coll2 = %d",collectID,collectID2);
//                 if ( collectID == collectID2 && [fieldsStr isEqualToString:fieldsStr2] )
//                 {
//                     isExist = YES;
//                    //不做处理
//                 }else{
//
//                 }
//             }];
//            
//            if (!isExist) {
//                NSMutableDictionary *refDic = [NSMutableDictionary dictionaryWithDictionary:dicInfo];
//                [refDic setObject:fieldsStr2 forKey:@"fields"];
//                [ReferSal readReferFileData:refDic andUid:USERID];
//            }
//            isExist = NO;
//            
//        }];
//    }else{
//        [_arrScanList enumerateObjectsUsingBlock:^(NSDictionary *dicInfo2, NSUInteger index2, BOOL *stop2 )
//         {
//             NSMutableDictionary *refDic = [NSMutableDictionary dictionaryWithDictionary:dicInfo2];
//             [refDic setObject:fieldsStr2 forKey:@"fields"];
//             [ReferSal readReferFileData:refDic andUid:USERID];
//             
//         }];
//    }
    
}
//确定服务类型操作
- (IBAction)didSelectPickTitleViewAction:(UIBarButtonItem *)sender {
    [_btnServeType setTitle:[DataStorer sharedInstance].arrDefiner[_selectType] forState:UIControlStateNormal];
    [self didHiddenPickerView];
}

- (IBAction)didHiddenPickViewAction:(UIBarButtonItem *)sender {
    [self didHiddenPickerView];
}

- (void)productSelectIndex
{
    [self.view addHUDActivityView:Loading];
    NSString *ldsID = [_arrLds componentsJoinedByString:@","];
    NSURL *url = [NSURL URLWithString:[BASE_REQUEST_URL stringByAppendingString:Api_ProductIndex]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:ldsID forKey:@"ids"];
    [request setDelegate:self];
    [request setPostValue:language forKey:langType];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:15];
    [request startAsynchronous];


    
//    [[Connection shareInstance] requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"ids":ldsID}] withURL:Api_ProductIndex  withType:POST completed:^(id content, ResponseType responseType) {
//       
//         LOG(@"data = %@",content);
//        if (responseType == SUCCESS)
//        {
//           
//            [DataStorer sharedInstance].arrDefiner = [content[@"data"][@"serviceAry"] copy];
//            _serciceSort = [content[@"data"][@"serviceSort"] integerValue];
//            [self showPickerViewBg];
//             [_pickView reloadAllComponents];
//        } else if (responseType == FAIL) {
//            [self.view addHUDLabelView:content Image:nil afterDelay:2.0f];
//        }
//        
//    }];

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.view removeHUDActivityView];
    NSData *responseData = [request responseData];
    NSDictionary *dic = [responseData objectFromJSONData];
    
//    NSInteger starus = [dic[@"status"] integerValue];
    LOG(@"data = %@",dic[@"data"]);
    [[DataStorer sharedInstance].arrDefiner setArray:dic[@"data"][@"serviceAry"] ];
    [self showPickerViewBg];
    [_pickView reloadAllComponents];
//    
//    if (starus == 1) {
//        
//    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.view removeHUDActivityView];
    [self.view addHUDLabelView:NetworkFail Image:nil afterDelay:2.0f];
}
#pragma mark UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [DataStorer sharedInstance].arrDefiner.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [DataStorer sharedInstance].arrDefiner[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectType = row;
    
}
- (void)showPickerViewBg
{
    CGRect rect = _showPickViewBg.frame;
    rect.origin.x = 0;
    rect.origin.y = HEIGHT(self.view);
    _showPickViewBg.frame = rect;
    if (!_showPickViewBg.superview) {
        [self.view addSubview:_showPickViewBg];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _showPickViewBg.frame;
        frame.origin.x = 0;
        frame.origin.y = HEIGHT(self.view) - _showPickViewBg.frame.size.height;
        _showPickViewBg.frame = frame;
    }];
}
- (void)didHiddenPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _showPickViewBg.frame;
        rect.origin.x = 0;
        rect.origin.y = HEIGHT(self.view);
        _showPickViewBg.frame = rect;
        
        
    } completion:^(BOOL finished) {
        [_showPickViewBg removeFromSuperview];
    }];
    
}
#pragma mark textField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self didHiddenPickerView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated
{
    [[self.view viewWithTag:100] resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
