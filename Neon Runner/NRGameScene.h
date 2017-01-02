//
//  
//  Neon Runner
//
//  Created by Darren Vong on 21/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NRGameModel.h"
#import "NREnums.h"

@interface NRGameScene : SKScene<SKPhysicsContactDelegate>

// The presenting controller already has a strong copy, so only need a weak reference here
@property (weak) NRGameModel* gameModel;

// "Constant" values that's only known at run time since these depend on user's phone screen size
@property (assign) float trapSize;
@property (assign) float laneSwitchDistance;
@property (assign) float trackBorderHeight; // number of pixels to offset a trap's y position

-(instancetype)initWithSize:(CGSize)size model:(NRGameModel*)model;

@end
