//
//  NRGameOverViewController.h
//  Neon Runner
//
//  Created by aca13amw on 16/01/2017.
//  Copyright © 2017 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRGameOverViewController : UIViewController

@property (strong) IBOutlet UILabel* scoreLabel;
@property (assign) int score;

-(IBAction)goBack;

@end