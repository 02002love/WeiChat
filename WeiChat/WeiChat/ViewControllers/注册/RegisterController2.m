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
@property (weak, nonatomic) IBOutlet UIView *birthdayView;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
- (IBAction)birthdayClick;
- (IBAction)sexClick;

@property (nonatomic,strong)UIDatePicker * birthPicker;

@end

@implementation RegisterController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_bg_2"]];
    
}


- (IBAction)imageButton:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
    
    
}

#pragma mark  UIActionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==2) {
        return;
    }
    if (actionSheet.tag==100) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate =self;
        if (buttonIndex==0) {
            //判断相机是否可用
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            
            
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if(actionSheet.tag==200)
    {
        
        if (buttonIndex) {
            [self.sexButton setTitle:@"女" forState: UIControlStateNormal];
            self.sexImage.image = [UIImage imageNamed:@"icon_register_woman"];
        }else{
            [self.sexButton setTitle:@"男" forState: UIControlStateNormal];
            self.sexImage.image = [UIImage imageNamed:@"icon_register_man"];
            
        }
        
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


- (IBAction)birthdayClick {
    if (self.birthPicker) {
        [UIView animateWithDuration:0.3 animations:^{
            self.birthPicker.frame = CGRectMake(0, HEIGHT-216, WIDTH, 216);
            
        }];
    }else {
        
        self.birthPicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 216)];
        self.birthPicker.maximumDate = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        self.birthPicker.minimumDate = [formatter dateFromString:@"1900-0101"];
        self.birthPicker.datePickerMode = UIDatePickerModeDate;
        
        [self.birthPicker addTarget:self action:@selector(birthPickerClick:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:self.birthPicker];
        [UIView animateWithDuration:0.3 animations:^{
            self.birthPicker.frame = CGRectMake(0, HEIGHT-216, WIDTH, 216);
            
        }];
        
    }
    
    
}

-(void)birthPickerClick:(UIDatePicker *)picker
{
    NSDate * date = picker.date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [self.birthdayButton setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
    
    
}
- (IBAction)sexClick {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"请选择性别,不可修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    sheet.tag = 200;
    [sheet showInView:self.view];
    
}
//隐藏 datePicker

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{


    if (self.birthPicker.frame.origin.y !=HEIGHT) {
        self.birthPicker.frame = CGRectMake(0, HEIGHT, WIDTH, 216);
    }

}
@end
