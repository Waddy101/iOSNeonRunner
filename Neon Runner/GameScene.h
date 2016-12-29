//
//  NeonRunnerGameScene.h
//  Neon Runner
//
//  Created by Darren Vong on 21/12/2016.
//  Copyright © 2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NRGameModel.h"
#import "NREnums.h"

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property (weak) NRGameModel* gameModel; //Controller already has a strong copy, so weak is fine here?
@property (assign) NSTimeInterval lastUpdatedTime;

// "Constant" values that's only known at run time since these depend on user's phone screen size
@property (assign) float trapSize;
@property (assign) float laneSwitchDistance;

@end
