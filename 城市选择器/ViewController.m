//
//  ViewController.m
//  城市选择器
//
//  Created by 李腾芳 on 16/10/17.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "ViewController.h"
#import "CityPickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *selectCityTextField;
@property (weak, nonatomic) IBOutlet UILabel *showCityLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation ViewController {
    CityPickerView *_cityPickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectButton.enabled = NO;
    _showCityLabel.text = @"当前未选择城市";
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    _cityPickerView = [[CityPickerView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    _selectCityTextField.inputView = _cityPickerView;
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(makeSure)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = @[spaceItem,item];
    _selectCityTextField.inputAccessoryView = toolBar;
    
   
}



//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (void)textDidChange:(NSNotification *)textDidChangeNotification {
//    _selectButton.enabled = ((UITextField *)textDidChangeNotification.object).text.length > 0 ;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAction:(id)sender {
    _showCityLabel.text = _selectCityTextField.text;
}



- (void)makeSure {
    _selectCityTextField.text = _cityPickerView.areaInfo[@"name"];
    _selectButton.enabled = YES;
    [_selectCityTextField endEditing:YES];
}


@end
