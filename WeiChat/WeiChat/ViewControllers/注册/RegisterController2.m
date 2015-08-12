//
//  RegisterController2.m
//  WeiChat
//
//  Created by JinWei on 15/8/12.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "RegisterController2.h"

@interface RegisterController2 ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)imageButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation RegisterController2

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)imageButton:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
    
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==2) {
        return;
    }
    if (actionSheet.tag==100) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate =self;
        if (buttonIndex==1) {
            //判断相机是否可用
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    
}

#pragma mark UIImagePickerController 代理

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    获取 image
    UIImage * image =[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
 
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
