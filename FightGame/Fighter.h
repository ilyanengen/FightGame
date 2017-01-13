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

@property (strong, nonatomic) NSString *firstAction;
@property (strong, nonatomic) NSString *secondAction;

@property (assign, nonatomic) BOOL firstTurnIsOver;
@property (assign, nonatomic) BOOL secondTurnIsOver;

@property (assign, nonatomic) BOOL firstTimeIsOver;
@property (assign, nonatomic) BOOL secondTimeIsOver;

@property (assign, nonatomic) BOOL readyForGesture;

@property (assign, nonatomic) int hp;
@property (assign, nonatomic) int stamina;

//leftUp
@property (strong, nonatomic) FighterAction *leftStraightPunch;
@property (strong, nonatomic) FighterAction *leftSwingPunch;
@property (strong, nonatomic) FighterAction *leftUppercutPunch;
@property (strong, nonatomic) FighterAction *leftUpBlock;

//rightUp
@property (strong, nonatomic) FighterAction *rightStraightPunch;
@property (strong, nonatomic) FighterAction *rightSwingPunch;
@property (strong, nonatomic) FighterAction *rightUppercutPunch;
@property (strong, nonatomic) FighterAction *rightUpBlock;

//leftDown
@property (strong, nonatomic) FighterAction *leftStraightKick;
@property (strong, nonatomic) FighterAction *leftSwingKick;
@property (strong, nonatomic) FighterAction *leftHighKick;
@property (strong, nonatomic) FighterAction *leftDownBlock;

//rightDown
@property (strong, nonatomic) FighterAction *rightStraightKick;
@property (strong, nonatomic) FighterAction *rightSwingKick;
@property (strong, nonatomic) FighterAction *rightHighKick;
@property (strong, nonatomic) FighterAction *rightDownBlock;

@end
