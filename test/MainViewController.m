//
//  MainViewController.m
//  test
//
//  Created by YjjTT on 2018/9/13.
//  Copyright © 2018年 YjjTT. All rights reserved.
//

#import "MainViewController.h"
#import "Tool.h"
#import "TurnViewToImage.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [TurnViewToImage turnToImageByScore:3.6];
    _imageView.image = image;
    _starScoreLbl.attributedText = [Tool replaceStringToAttributedString:@"小明今天的评分: [黄星][黄星][黄星][3.6][灰星]\n小红今天的评分: [黄星][黄星][2.3][灰星][灰星]\n小Y今天的评分: [黄星][黄星][黄星][黄星][灰星]"];
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
