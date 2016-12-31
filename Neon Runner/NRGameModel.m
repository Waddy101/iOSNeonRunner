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
    }
    return self;
}

-(void)update {
    self.score += 30;
}

-(BOOL)movePlayer:(NRDirection)direction {
    return [self.player movePlayer:direction];
}

// only add a trap after some time since the last one or via some random criteria?
-(void)maybeAddTrap:(NSTimeInterval*)currentTime {
    
}

@end
