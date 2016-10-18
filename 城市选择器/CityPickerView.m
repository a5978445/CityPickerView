//
//  CityPeickerViewDataModel.m
//  城市选择器
//
//  Created by 李腾芳 on 16/10/17.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "CityPickerView.h"

@interface CityPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(strong,nonatomic) UIPickerView *cityPickerView;
@property(strong,nonatomic) NSArray *rootArray;

@end

@implementation CityPickerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cityPickerView = [[UIPickerView alloc]initWithFrame:frame];
        [self addSubview:_cityPickerView];
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
        [self readLocalPlist];
    }
    return self;
}

#pragma mark - public Method
- (NSDictionary *)areaInfo {
    NSString *zipCodeString = [self selectCityDic][@"zipcode"];
    NSString *provinceName = [self selectProvinceDic][@"name"];
    NSString *cityName = [self selectCityDic][@"name"];
    NSString *areaName = [self slectAreaName];
    NSString *name = [[provinceName stringByAppendingString:cityName] stringByAppendingString:areaName];
    NSDictionary *dic = @{@"areaCode":zipCodeString,
                          @"name":name};
    return dic;
}


#pragma mark - private method
- (NSUInteger)selectProvince {
    NSUInteger select =  [_cityPickerView selectedRowInComponent:0];
    return select == -1 ? 0 : select;
}

- (NSUInteger)selectCity {
    NSUInteger select =  [_cityPickerView selectedRowInComponent:1];
    return select == -1 ? 0 : select;
}

- (NSUInteger)selectArea {
    NSUInteger select =  [_cityPickerView selectedRowInComponent:2];
    return select == -1 ? 0 : select;
}

- (void)readLocalPlist {
    NSURL *url = [[NSBundle mainBundle].resourceURL URLByAppendingPathComponent:@"address.plist"];
    _rootArray = [NSDictionary dictionaryWithContentsOfURL:url][@"address"];
  //  NSLog(@"%@",_rootArray);
}

- (NSDictionary *)selectProvinceDic {
    return _rootArray[self.selectProvince];
}

- (NSArray *)citys {
    return self.selectProvinceDic[@"sub"];
}

- (NSDictionary *)selectCityDic {
    return self.citys[self.selectCity];
}

- (NSArray *)areas {
    return self.selectCityDic[@"sub"];
}

- (NSString *)slectAreaName {
    return self.areas[self.selectArea];
}



#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger count = 0;
    switch (component) {
        case 0: {
            count = _rootArray.count;
            break;
        }
        case 1: {
            count = self.citys.count;
            break;
        }
        case 2: {
            count = self.areas.count;
            break;
        }
            
    }
    return count;
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _rootArray[row][@"name"];
            break;
        case 1:
            return [self citys][row][@"name"];
            break;
        case 2:
            return [self areas][row];
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [pickerView reloadAllComponents];
  
  //  NSLog(@"%@",self.areaInfo);
}


@end
