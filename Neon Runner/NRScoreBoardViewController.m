//
//  
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRScoreBoardViewController.h"

@interface NRScoreBoardViewController ()

@end

@implementation NRScoreBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* cell11Text = [self getContents:1 y:1];
    NSString* cell12Text = [self getContents:1 y:2];
    NSString* cell21Text = [self getContents:2 y:1];
    NSString* cell22Text = [self getContents:2 y:2];
    NSString* cell31Text = [self getContents:3 y:1];
    NSString* cell32Text = [self getContents:3 y:2];
    NSString* cell41Text = [self getContents:4 y:1];
    NSString* cell42Text = [self getContents:4 y:2];
    NSString* cell51Text = [self getContents:5 y:1];
    NSString* cell52Text = [self getContents:5 y:2];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float leftStart = width/2.0 - width/2.2;
    UILabel* headerLeft = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0, width/2.2, height/7.5)];
    headerLeft.layer.borderWidth = 1.0;
    headerLeft.layer.borderColor = [UIColor whiteColor].CGColor;
    headerLeft.text = @"Username";
    headerLeft.textColor = [UIColor whiteColor];
    headerLeft.textAlignment = NSTextAlignmentCenter;
    headerLeft.font = [UIFont boldSystemFontOfSize:
                       26];
    [self.view addSubview:headerLeft];
    
    UILabel* headerRight = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0,width/2.2,height/7.5)];
    headerRight.layer.borderWidth = 1.0;
    headerRight.layer.borderColor = [UIColor whiteColor].CGColor;
    headerRight.text = @"Score";
    headerRight.textColor = [UIColor whiteColor];
    headerRight.textAlignment = NSTextAlignmentCenter;
    headerRight.font = [UIFont boldSystemFontOfSize:
                       26];
    [self.view addSubview:headerRight];
    
    UILabel* cell11 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0 + height/7.5,width/2.2,height/7.5)];
    cell11.layer.borderWidth = 1.0;
    cell11.layer.borderColor = [UIColor whiteColor].CGColor;
    cell11.text = cell11Text;
    cell11.textColor = [UIColor whiteColor];
    cell11.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell11];
    
    UILabel* cell12 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0 + height/7.5,width/2.2,height/7.5)];
    cell12.layer.borderWidth = 1.0;
    cell12.layer.borderColor = [UIColor whiteColor].CGColor;
    cell12.text = cell12Text;
    cell12.textColor = [UIColor whiteColor];
    cell12.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell12];
    
    UILabel* cell21 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0 + (height/7.5)*2,width/2.2,height/7.5)];
    cell21.layer.borderWidth = 1.0;
    cell21.layer.borderColor = [UIColor whiteColor].CGColor;
    cell21.text = cell21Text;
    cell21.textColor = [UIColor whiteColor];
    cell21.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell21];
    
    UILabel* cell22 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0 + (height/7.5)*2,width/2.2,height/7.5)];
    cell22.layer.borderWidth = 1.0;
    cell22.layer.borderColor = [UIColor whiteColor].CGColor;
    cell22.text = cell22Text;
    cell22.textColor = [UIColor whiteColor];
    cell22.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell22];
    
    UILabel* cell31 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0 + (height/7.5)*3,width/2.2,height/7.5)];
    cell31.layer.borderWidth = 1.0;
    cell31.layer.borderColor = [UIColor whiteColor].CGColor;
    cell31.text = cell31Text;
    cell31.textColor = [UIColor whiteColor];
    cell31.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell31];
    
    UILabel* cell32 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0 + (height/7.5)*3,width/2.2,height/7.5)];
    cell32.layer.borderWidth = 1.0;
    cell32.layer.borderColor = [UIColor whiteColor].CGColor;
    cell32.text = cell32Text;
    cell32.textColor = [UIColor whiteColor];
    cell32.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell32];
    
    UILabel* cell41 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0 + (height/7.5)*4,width/2.2,height/7.5)];
    cell41.layer.borderWidth = 1.0;
    cell41.layer.borderColor = [UIColor whiteColor].CGColor;
    cell41.text = cell41Text;
    cell41.textColor = [UIColor whiteColor];
    cell41.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell41];
    
    UILabel* cell42 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0 + (height/7.5)*4,width/2.2,height/7.5)];
    cell42.layer.borderWidth = 1.0;
    cell42.layer.borderColor = [UIColor whiteColor].CGColor;
    cell42.text = cell42Text;
    cell42.textColor = [UIColor whiteColor];
    cell42.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell42];
    
    UILabel* cell51 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart, 75.0 + (height/7.5)*5,width/2.2,height/7.5)];
    cell51.layer.borderWidth = 1.0;
    cell51.layer.borderColor = [UIColor whiteColor].CGColor;
    cell51.text = cell51Text;
    cell51.textColor = [UIColor whiteColor];
    cell51.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell51];
    
    UILabel* cell52 = [[UILabel alloc]initWithFrame:CGRectMake(leftStart + width/2.2, 75.0 + (height/7.5)*5,width/2.2,height/7.5)];
    cell52.layer.borderWidth = 1.0;
    cell52.layer.borderColor = [UIColor whiteColor].CGColor;
    cell52.text = cell52Text;
    cell52.textColor = [UIColor whiteColor];
    cell52.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:cell52];
    
    [self.view setNeedsDisplay];
    
}

-(NSString*)getContents:(int)x y:(int)y {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"scores.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]) {
        NSArray* scores = [[NSArray alloc] initWithContentsOfFile:path];
        NSInteger max = [scores count];
        if (x <= max) {
            NSString* value = [scores[x-1] componentsSeparatedByString:@","][y-1];
            return value;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

-(IBAction)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
