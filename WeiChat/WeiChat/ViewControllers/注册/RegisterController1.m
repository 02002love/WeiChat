//
//  RegisterController1.m
//  WeiChat
//
//  Created by JinWei on 15/8/12.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "RegisterController1.h"

@interface RegisterController1 ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
- (IBAction)retryButton;

- (IBAction)detailButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@end

@implementation RegisterController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2"]];
    self.numberLabel.text = [NSString stringWithFormat:@"您的账号是:%ld",DTAETIME];
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

- (IBAction)retryButton {
     self.numberLabel.text = [NSString stringWithFormat:@"您的账号是:%ld",DTAETIME];
}

- (IBAction)detailButton {
}
@end
