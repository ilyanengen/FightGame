//
//  FighterAction.h
//  FightGame
//
//  Created by Илья on 13.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FighterAction : NSObject

@property (strong, nonatomic) NSString *actionName;
@property (assign, nonatomic) int damage;
@property (assign, nonatomic) int stamina;

- (instancetype)initWithActionName:(NSString *)actionName
                  stamina:(int)staminaValue
                    damage:(int)damageValue;

@end
