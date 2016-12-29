//
//  NRGameModel.h
//  Neon Runner
//
//  Created by Darren Vong on 28/12/2016.
//  Copyright © 2016 aca13amw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NREnums.h"
#import "NRPlayer.h"
#import "NRTrap.h"

@interface NRGameModel : NSObject

@property (assign) int score;
@property (strong) NRPlayer* player;
@property (strong) NSMutableArray<NRTrap*> *traps;

-(void)update;
-(BOOL)movePlayer:(NRDirection)direction;
-(void)maybeAddTrap:(NSTimeInterval*)currentTime;

@end
