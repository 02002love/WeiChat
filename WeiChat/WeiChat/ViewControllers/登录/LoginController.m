//
//  LoginController.m
//  WeiChat
//
//  Created by JinWei on 15/8/11.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)registerButton;
- (IBAction)loginButton;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建通知
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


-(void)keyboardShow:(NSNotification *)noti{
    
    CGFloat keyBoardHeight = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0,-keyBoardHeight/2, WIDTH, HEIGHT);
        self.logoImage.transform = CGAffineTransformMakeScale(0, 0);
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

-(void)keyBoardHidden:(NSNotification *)noti{
    
    //    self.bgView.frame = self.view.bounds;
    self.bgView.frame = CGRectMake(0,0+30, WIDTH, HEIGHT);
    self.logoImage.transform = CGAffineTransformMakeScale(1,1);
    
}

//取消通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.usernameField) {
        [self.passwordField resignFirstResponder];
    }else{
    
        [self loginButton];
    
    }
    
    return YES;
    
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

- (IBAction)registerButton {
}

- (IBAction)loginButton {
    
    if (self.usernameField.text.length&&self.passwordField.text.length) {
        //判定正确性,执行登录
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        //保存账号密码
        [user setObject:self.usernameField.text forKey:kXMPPmyJID];
        [user setObject:self.passwordField.text forKey:kXMPPmyPassword];
        //同步数据
        [user synchronize];
        
        //这行 xmpp 的登录
        [[ZCXMPPManager sharedInstance] connectLogin:^(BOOL isSucceed) {
            if (isSucceed) {
                SKLog(@"登录成功");
            }else{
                
                SKLog(@"登录失败");
            }
        }];
    }else{
        
        [MBProgressHUD showError:@"账号或者密码不正确"];
    
    }
    
}
@end
