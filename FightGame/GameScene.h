//
//  GameScene.h
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FighterAction.h"
#import "Fighter.h"

@interface GameScene : SKScene

//leftUp
- (void)handleLeftStraightPunch;
- (void)handleLeftSwingPunch;
- (void)handleLeftUppercutPunch;
- (void)handleUpBlock;
//rightUp
- (void)handleRightStraightPunch;
- (void)handleRightSwingPunch;
- (void)handleRightUppercutPunch;
//leftDown
- (void)handleLeftStraightKick;
- (void)handleLeftSwingKick;
- (void)handleLeftHighKick;
- (void)handleDownBlock;
//rightDown
- (void)handleRightStraightKick;
- (void)handleRightSwingKick;
- (void)handleRightHighKick;

- (void)checkPlayerFirstAndSecondActions: (FighterAction *)fighterAction;
- (void)addOpponentFirstAndSecondActions;

@end
