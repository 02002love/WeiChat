//
//  RegisterController3.m
//  WeiChat
//
//  Created by JinWei on 15/8/13.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "RegisterController3.h"

@interface RegisterController3 ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFiled;
- (IBAction)nextBtnClick;

@end

@implementation RegisterController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2"]];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.phoneNumField) {
        [self.passwordFiled resignFirstResponder];
    }else{
    
        if (self.passwordFiled.text.length&&self.phoneNumField.text.length) {
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message: nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
    
        
        
        }
    
    
    }


    return YES;
}

- (IBAction)nextBtnClick {
    [self.view endEditing:YES];

    if (self.phoneNumField.text.length&&self.passwordFiled.text.length) {
        RegisterManager * manager = [RegisterManager sharedManager];
        manager.phoneNum = self.phoneNumField.text;
        manager.password = self.passwordFiled.text;
        
        [self performSegueWithIdentifier:@"three2four" sender:nil];
    }else{
    
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message: @"请填写资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    
    }
}
@end
