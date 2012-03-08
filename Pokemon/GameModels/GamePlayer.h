//
//  GamePlayer.h
//  Pokemon
//
//  Created by Kaijie Yu on 3/8/12.
//  Copyright 2012 Kjuly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GamePlayer : CCNode {
}

- (void)update:(ccTime)dt;
- (void)reset;
- (void)endTurn;

@end
