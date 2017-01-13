//
//  FighterAction.h
//  FightGame
//
//  Created by Илья on 13.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FighterAction : NSObject {
    
    NSString *_actionName;
    int _damage;
    int _stamina;

}

- (instancetype)initWithActionName:(NSString *)actionName
                  stamina:(int)staminaValue
                    damage:(int)damageValue;

@end
