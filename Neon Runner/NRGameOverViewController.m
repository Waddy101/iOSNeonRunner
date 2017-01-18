//
//  NRGameOverViewController.m
//  Neon Runner
//
//  Created by aca13amw on 16/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameOverViewController.h"

@implementation NRGameOverViewController

-(void)viewDidLoad {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.score];
}

-(IBAction)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(BOOL)didPresentShareController:(NSString*)serviceType {
    SLComposeViewController* socialController = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    [socialController setInitialText:[NSString stringWithFormat:@"I have scored %i points on Neon Runner!", self.score]];
    
    // Check if service is available first before presenting the controller for user to post
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        socialController.completionHandler = ^(SLComposeViewControllerResult result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:socialController animated:YES completion:nil];
        return YES;
    }
    return NO;
}

-(void)showNoAccountsAvailableAlert:(NSString*)accountType {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"No %@ Accounts Available", accountType]
                                                    message:[NSString stringWithFormat:@"There are no %@ Accounts configured. You can create or log into your %@ account in Settings.", accountType, accountType]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction* goToSettingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"prefs:root=%@", accountType.uppercaseString]]];
    }];
    [alert addAction:goToSettingsAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)shareToFacebook:(id)sender {
    if (![self didPresentShareController:SLServiceTypeFacebook]) {
        [self showNoAccountsAvailableAlert:@"Facebook"];
    }
}

-(IBAction)shareToTwitter:(id)sender {
    if (![self didPresentShareController:SLServiceTypeTwitter]) {
        [self showNoAccountsAvailableAlert:@"Twitter"];
    }
}

-(void)returnHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NRScoreSubmissionViewController* submitController = [segue destinationViewController];
    submitController.score = self.score;
    submitController.delegate = self;
}

@end
