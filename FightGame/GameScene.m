//
//  GameScene.m
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    //SKShapeNode *_spinnyNode;
    //SKLabelNode *_label;
    SKSpriteNode *_opponentSprite;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    self.backgroundColor = [SKColor whiteColor];
    
    //Opponent
    CGSize opponentSize = CGSizeMake(view.bounds.size.width/4, view.bounds.size.height/2);
    SKSpriteNode *opponent = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:opponentSize];
    opponent.anchorPoint = CGPointMake(0.5,0.5);
    opponent.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    opponent.zPosition = 9;
    [self addChild:opponent];
    
    //ShapeNodes
    CGSize rectSize = CGSizeMake(view.bounds.size.width/2, view.bounds.size.height/2);
    
    //upperLeft
    SKShapeNode *upperLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperLeftScreen.strokeColor = [SKColor grayColor];
    upperLeftScreen.position = CGPointMake(view.bounds.size.width/4, view.bounds.size.height - view.bounds.size.height/4);
    upperLeftScreen.zPosition = 10;
    [self addChild:upperLeftScreen];
    
    //upperRight
    SKShapeNode *upperRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperRightScreen.strokeColor = [SKColor grayColor];
    upperRightScreen.position = CGPointMake(view.bounds.size.width - view.bounds.size.width/4 , view.bounds.size.height - view.bounds.size.height/4);
    upperRightScreen.zPosition = 10;
    [self addChild:upperRightScreen];
    
    //lowerLeft
    SKShapeNode *lowerLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerLeftScreen.strokeColor = [SKColor grayColor];
    lowerLeftScreen.position = CGPointMake(view.bounds.size.width/4 , view.bounds.size.height/4);
    lowerLeftScreen.zPosition = 10;
    [self addChild:lowerLeftScreen];
    
    //lowerRight
    SKShapeNode *lowerRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerRightScreen.strokeColor = [SKColor grayColor];
    lowerRightScreen.position = CGPointMake(view.bounds.size.width - view.bounds.size.width/4 , view.bounds.size.height/4);
    lowerRightScreen.zPosition = 10;
    [self addChild:lowerRightScreen];
    
    /*
    //CGFloat w = (self.size.width + self.size.height) * 0.05;
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
     */
}

- (void)touchDownAtPoint:(CGPoint)pos {
    /*
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
     */
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
