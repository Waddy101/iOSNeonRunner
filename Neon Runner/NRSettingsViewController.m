//
//  
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRSettingsViewController.h"

@interface NRSettingsViewController ()

@end

@implementation NRSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)goBack {
    NSString* valueToSave = [NSString stringWithFormat:@"%f", self.soundFXVolume.value];
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"fxVolume"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    valueToSave = [NSString stringWithFormat:@"%f", self.musicVolume.value];
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"bkgVolume"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)resetData {
    NSArray* empty = [[NSArray alloc] init];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"scores.plist"];
    BOOL didWriteToFile = [empty writeToFile:path atomically:YES];
    if (didWriteToFile) {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Success" message:@"The scoreboard data has been successfully reset." preferredStyle:UIAlertControllerStyleAlert];
        [confirmation addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
