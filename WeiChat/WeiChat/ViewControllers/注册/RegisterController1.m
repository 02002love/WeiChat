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

- (IBAction)nextBtnClick;


- (IBAction)backClick; 

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   
    
}


- (IBAction)retryButton {
     self.numberLabel.text = [NSString stringWithFormat:@"您的账号是:%ld",DTAETIME];
}

- (IBAction)nextBtnClick {
    
    if (self.nickNameTextField.text.length==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message: @"请填写昵称" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    RegisterManager * manager = [RegisterManager sharedManager];
    manager.nickName = self.nickNameTextField.text;
    manager.userName = [self.numberLabel.text substringFromIndex:6];
    [self performSegueWithIdentifier:@"one2two" sender:nil];
  
    
    
    
}

- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)detailButton {
    

}
@end
