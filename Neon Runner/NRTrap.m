//
//  
//  Neon Runner
//
//  Created by Darren Vong on 29/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRTrap.h"

@implementation NRTrap

-(instancetype)initWithSceneWidth:(float)width {
    self = [super init];
    if (self) {
        // lane in which the trap appears is random
        _lane = (NRLane)(arc4random() % (int)NRLaneMax);
        _sceneWidth = width;
        _x = width - 50;
    }
    return self;
}

@end
