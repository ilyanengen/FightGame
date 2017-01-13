//
//  FighterAction.m
//  FightGame
//
//  Created by Илья on 13.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "FighterAction.h"

@implementation FighterAction

- (instancetype)initWithActionName:(NSString *)actionName
                          stamina:(int)staminaValue
                           damage:(int)damageValue
{
    self = [super init];
    
    if (self) {
        _actionName = actionName;
        _stamina = staminaValue;
        _damage = damageValue;
    }
    return self;
}


@end
