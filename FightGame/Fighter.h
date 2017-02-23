//
//  Fighter.h
//  FightGame
//
//  Created by Илья on 07.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FighterAction.h"

@interface Fighter : SKSpriteNode

@property (strong, nonatomic) NSString *fighterName;

@property (strong, nonatomic) FighterAction *firstAction;
@property (strong, nonatomic) FighterAction *secondAction;

@property (assign, nonatomic) int hp;
@property (assign, nonatomic) int stamina;

//UP
@property (strong, nonatomic) FighterAction *upBlock;

//leftUp
@property (strong, nonatomic) FighterAction *leftStraightPunch;
@property (strong, nonatomic) FighterAction *leftSwingPunch;
@property (strong, nonatomic) FighterAction *leftUppercutPunch;

//rightUp
@property (strong, nonatomic) FighterAction *rightStraightPunch;
@property (strong, nonatomic) FighterAction *rightSwingPunch;
@property (strong, nonatomic) FighterAction *rightUppercutPunch;

//DOWN
@property (strong, nonatomic) FighterAction *downBlock;
//leftDown
@property (strong, nonatomic) FighterAction *leftStraightKick;
@property (strong, nonatomic) FighterAction *leftSwingKick;
@property (strong, nonatomic) FighterAction *leftHighKick;

//rightDown
@property (strong, nonatomic) FighterAction *rightStraightKick;
@property (strong, nonatomic) FighterAction *rightSwingKick;
@property (strong, nonatomic) FighterAction *rightHighKick;

@end
