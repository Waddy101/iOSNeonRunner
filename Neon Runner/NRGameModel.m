//
//  
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 Darren Vong, Adam Wadsworth. All rights reserved.
//

#import "NRGameModel.h"

@implementation NRGameModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _score = 0;
        _player = [[NRPlayer alloc]init];
        _lastUpdatedTime = 0.0; //arbitrary value to initialise the variable
    }
    return self;
}

-(void)update:(float)sceneWidth {
    self.score += 30;
}

-(BOOL)movePlayer:(NRDirection)direction {
    return [self.player movePlayer:direction];
}

@end
