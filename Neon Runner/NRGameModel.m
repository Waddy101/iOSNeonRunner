//
//  
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameModel.h"

#define MAX_NUM_TRAPS 100

@implementation NRGameModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _score = 0;
        _player = [[NRPlayer alloc]init];
        _traps = [[NSMutableArray alloc]initWithCapacity:MAX_NUM_TRAPS];
        _lastUpdatedTime = 0.0; //arbitrary value to initialise the variable
    }
    return self;
}

-(void)update:(float)sceneWidth {
    self.score += 30;
//    [self maybeAddTrap:sceneWidth];
}

-(BOOL)movePlayer:(NRDirection)direction {
    return [self.player movePlayer:direction];
}

// only add a trap after some time since the last one or via some random criteria?
-(void)maybeAddTrap:(float)sceneWidth {
    // 30% chance of adding a trap to game, may dynamically update this later?
    if (arc4random() % 100 > 70) {
        [self.traps addObject:[[NRTrap alloc]initWithSceneWidth:sceneWidth]];
    }
}

@end
