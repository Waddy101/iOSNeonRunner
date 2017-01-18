//
//  NRScoreSubmissionViewController.h
//  Neon Runner
//
//  Created by Ka Chon Vong on 17/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRScoreSubmissionDelegate.h"

@interface NRScoreSubmissionViewController : UIViewController <UITextFieldDelegate>

@property (weak) IBOutlet UILabel* scoreLabel;
@property (weak) IBOutlet UILabel* nameLabel;
@property (weak) IBOutlet UITextField* nameField;
@property (weak) IBOutlet UIButton* submit;
@property (weak) IBOutlet UIButton* cancel;
@property (weak) id<NRScoreSubmissionDelegate> delegate;

@property (assign) int score;

-(IBAction)onSubmit;
-(IBAction)onCancel;


@end
