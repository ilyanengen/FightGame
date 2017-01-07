//
//  Fighter.h
//  FightGame
//
//  Created by Илья on 07.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Fighter : SKSpriteNode

@property (strong, nonatomic) NSString *fighterName;

@property (assign, nonatomic) int hp;
@property (assign, nonatomic) int stamina;

//leftUp damage
@property (assign, nonatomic) int leftStraightPunchDamage;
@property (assign, nonatomic) int leftSwingPunchDamage;
@property (assign, nonatomic) int leftUppercutPunchDamage;

//rightUp damage
@property (assign, nonatomic) int rightStraightPunchDamage;
@property (assign, nonatomic) int rightSwingPunchDamage;
@property (assign, nonatomic) int rightUppercutPunchDamage;

//leftDown damage
@property (assign, nonatomic) int leftStraightKickDamage;
@property (assign, nonatomic) int leftSwingKickDamage;
@property (assign, nonatomic) int leftHighKickDamage;

//rightDown damage
@property (assign, nonatomic) int rightStraightKickDamage;
@property (assign, nonatomic) int rightSwingKickDamage;
@property (assign, nonatomic) int rightHighKickDamage;

@end
