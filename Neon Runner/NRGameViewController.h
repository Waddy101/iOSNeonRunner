//
//  
//  Neon Runner
//
//  Created by aca13kcv on 15/11/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "NRGameScene.h"
#import "NRGameModel.h"
#import "NRGameOverViewController.h"

@interface NRGameViewController : UIViewController

@property (strong) NRGameModel* gameModel;
@property (strong) NRGameScene* scene;
@property (strong) NRGameOverViewController* gameOverView;

@end
