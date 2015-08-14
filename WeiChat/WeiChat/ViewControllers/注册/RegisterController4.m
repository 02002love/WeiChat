//
//  RegisterController4.m
//  WeiChat
//
//  Created by JinWei on 15/8/13.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "RegisterController4.h"

@interface RegisterController4 ()<UITextFieldDelegate>
- (IBAction)completeButton;

@property (weak, nonatomic) IBOutlet UITextField *wordLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;

@end

@implementation RegisterController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2"]];
    // Do any additional setup after loading the view.
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField ==self.wordLabel) {
        [self.addressLabel resignFirstResponder];
    }else{
        
        
    }
    return YES;
}


- (IBAction)completeButton {
    SKLog(@"wangcheng");
    if (self.wordLabel.text.length&&self.addressLabel.text.length) {
        RegisterManager * manager = [RegisterManager sharedManager];
        manager.address = self.addressLabel.text;
        manager.signature = self.wordLabel.text;
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:manager.userName forKey:kXMPPmyJID];
        [user setObject:manager.password forKey:kXMPPmyPassword];
        [user synchronize];
        
        [MBProgressHUD showMessage:@"小聊正在为你努力加载..."];
        [[ZCXMPPManager sharedInstance] registerMothod:^(BOOL isSucceed) {
            [MBProgressHUD hideHUD];
            if (isSucceed) {
                //登录
                [[ZCXMPPManager sharedInstance]connectLogin:^(BOOL isOK) {
                    if (isOK) {
                        //成功,获取个人信息 Vcard 进行更新
                        [[ZCXMPPManager sharedInstance] getMyVcardBlock:^(BOOL succeed, XMPPvCardTemp *myVCard) {
                            if (succeed) {
                                //                                开始更新
                                if (manager.headImage) {
                                    myVCard.photo = UIImageJPEGRepresentation(manager.headImage, 0.1);
                                }
                                //vcard 不支持中文 需转码 否则无法成功
                                if (manager.nickName) {
                                    myVCard.nickname = CODE(manager.nickName);
                                }
                                //自定义的 vcard
                                
                                if (manager.phoneNum) {
                                    [[ZCXMPPManager sharedInstance] customVcardXML:CODE(manager.phoneNum) name:PHONENUM myVcard:myVCard];
                                }
                                if (manager.address) {
                                    [[ZCXMPPManager sharedInstance] customVcardXML:CODE(manager.address) name:ADDRESS myVcard:myVCard];
                                }
                                if (manager.birthday) {
                                    [[ZCXMPPManager sharedInstance] customVcardXML:CODE(manager.birthday) name:BYD myVcard:myVCard];
                                }
                                if (manager.sex) {
                                    [[ZCXMPPManager sharedInstance] customVcardXML:CODE(manager.sex) name:SEX myVcard:myVCard];
                                }
                                //签名档
                                if (manager.signature) {
                                    [[ZCXMPPManager sharedInstance] customVcardXML:CODE(manager.signature) name:QMD myVcard:myVCard];
                                }
                                [[ZCXMPPManager sharedInstance]upData:myVCard];
                                //进入主界面
                            }
                        }];
                    }else{
                        //失败
                        
                    }
                }];
            }
            
        }];
        
    }else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message: @"请填写资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
        
    }
    
    
}


@end
