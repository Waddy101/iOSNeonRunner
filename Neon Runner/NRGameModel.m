//
//  
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameModel.h"

#define SPEED_UP_POINT 500 // Number of points player scored before the trap speed multiplier is increased
#define POINT_INCREMENT_PER_UPDATE 1

@implementation NRGameModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _score = 0;
        _player = [[NRPlayer alloc]init];
        _trapMovementSpeed = 5.0;
        _isPaused = NO;
    }
    return self;
}

-(void)update:(float)sceneWidth {
    self.score += POINT_INCREMENT_PER_UPDATE;
    if (self.score > 0 && (self.score % SPEED_UP_POINT == 0)) {
        self.trapMovementSpeed *= 1.01;
        NSLog(@"Speed updated!");
    }
    
}

-(BOOL)movePlayer:(NRDirection)direction {
    return [self.player movePlayer:direction];
}

@end
