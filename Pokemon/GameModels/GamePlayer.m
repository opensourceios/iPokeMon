//
//  GamePlayer.m
//  Pokemon
//
//  Created by Kaijie Yu on 3/8/12.
//  Copyright 2012 Kjuly. All rights reserved.
//

#import "GamePlayer.h"

#import "GlobalNotificationConstants.h"
#import "GameStatusMachine.h"
#import "GameSystemProcess.h"
#import "TrainerTamedPokemon.h"


@interface GamePlayer () {
 @private
  BOOL complete_;
}

- (void)sendMessageToPlayer;

@end


@implementation GamePlayer

- (void)dealloc
{
  [super dealloc];
}

- (id)init
{
  if (self = [super init]) {
    complete_ = NO;
  }
  return self;
}

- (void)update:(ccTime)dt
{
  // Player will control the turn and send
  //   |[[GameStatusMachine sharedInstance] endStatus:kGameStatusPlayerTurn];|,
  // so jsut pass here if completed.
  if (complete_)
    return;
  else [self sendMessageToPlayer];
}

- (void)reset {
  complete_ = NO;
}

- (void)endTurn {
  complete_ = YES;
}

#pragma mark - Private Methods

- (void)sendMessageToPlayer
{
  TrainerTamedPokemon * playerPokemon = [GameSystemProcess sharedInstance].playerPokemon;
  NSString * message = [NSString stringWithFormat:@"%@ %@ %@",
                        NSLocalizedString(@"PMSMessageWhatWillXXXDoPart1", nil),
                        NSLocalizedString(([NSString stringWithFormat:@"PMSName%.3d",
                                            [playerPokemon.sid intValue]]), nil),
                        NSLocalizedString(@"PMSMessageWhatWillXXXDoPart3", nil)];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kPMNUpdateGameBattleMessage
                                                      object:self
                                                    userInfo:[NSDictionary dictionaryWithObject:message
                                                                                         forKey:@"message"]];
  playerPokemon = nil;
  [self endTurn];
}

@end
