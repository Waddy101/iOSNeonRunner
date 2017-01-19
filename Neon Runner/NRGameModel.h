//
//  
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NREnums.h"
#import "NRPlayer.h"
#import "NRTrap.h"

@interface NRGameModel : NSObject

@property (assign) int score;
@property (strong) NRPlayer* player;
@property (assign) float trapMovementSpeed;

@property (assign) NSTimeInterval lastUpdatedTime;

-(void)update:(float)sceneWidth;
-(BOOL)movePlayer:(NRDirection)direction;

@end
