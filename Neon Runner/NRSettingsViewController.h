//
//  
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NRSettingsViewController : UIViewController

@property (weak) IBOutlet UISlider* soundFXVolume;
@property (weak) IBOutlet UISlider* musicVolume;

-(IBAction)goBack;
-(IBAction)resetData;

@end
