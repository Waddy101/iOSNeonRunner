//
//  
//  Neon Runner
//
//  Created by Darren Vong on 29/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NREnums.h"

@interface NRTrap : NSObject

// The x (horizontal) position of the trap
@property (assign) float x;
@property (assign) NRLane lane;

-(instancetype)initWithSceneWidth:(float)width;

@end