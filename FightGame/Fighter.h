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

@property (strong, nonatomic) NSString *firstAction;
@property (strong, nonatomic) NSString *secondAction;

@property (assign, nonatomic) BOOL firstTurnIsOver;
@property (assign, nonatomic) BOOL secondTurnIsOver;

@property (assign, nonatomic) BOOL firstTimeIsOver;
@property (assign, nonatomic) BOOL secondTimeIsOver;

@property (assign, nonatomic) BOOL readyForGesture;

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

//////////////////////////////////////////////////////////////////

//leftUp stamina
@property (assign, nonatomic) int leftStraightPunchStamina;
@property (assign, nonatomic) int leftSwingPunchStamina;
@property (assign, nonatomic) int leftUppercutPunchStamina;
@property (assign, nonatomic) int leftUpBlockStamina;

//rightUp stamina
@property (assign, nonatomic) int rightStraightPunchStamina;
@property (assign, nonatomic) int rightSwingPunchStamina;
@property (assign, nonatomic) int rightUppercutPunchStamina;
@property (assign, nonatomic) int rightUpBlockStamina;

//leftDown stamina
@property (assign, nonatomic) int leftStraightKickStamina;
@property (assign, nonatomic) int leftSwingKickStamina;
@property (assign, nonatomic) int leftHighKickStamina;
@property (assign, nonatomic) int leftDownBlockStamina;

//rightDown stamina
@property (assign, nonatomic) int rightStraightKickStamina;
@property (assign, nonatomic) int rightSwingKickStamina;
@property (assign, nonatomic) int rightHighKickStamina;
@property (assign, nonatomic) int rightDownBlockStamina;

@end
