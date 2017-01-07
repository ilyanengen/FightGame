//
//  GameScene.m
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "GameScene.h"
#import "Fighter.h"

@implementation GameScene {
    
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    SKSpriteNode *_upperHUD;
    SKSpriteNode *_lowerHUD;
    
    SKSpriteNode *_mainActionScreen;
    SKShapeNode *_upperLeftScreen;
    SKShapeNode *_upperRightScreen;
    SKShapeNode *_lowerLeftScreen;
    SKShapeNode *_lowerRightScreen;
    
    SKSpriteNode *_player;
    SKSpriteNode *_opponent;
    
    //Gameplay variables
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    self.backgroundColor = [SKColor whiteColor];
    
    //Get screen size to use later
    screenWidth = view.bounds.size.width;
    screenHeight = view.bounds.size.height;
    
    //HUD
    [self addHUD];
    
    //Action Screens
    [self addActionScreens];
    
    //UIGestureRecognizer
    [self addGestureRecognizers];
    
    //Add player
    [self addPlayer];
    
    //Opponent
    [self addOpponent];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

#pragma mark - Addition of main nodes to Game Scene
- (void)addHUD {
    
    //HUD
    CGSize hudSize = CGSizeMake(screenWidth, screenHeight/10);
    
    //Upper HUD
    SKSpriteNode *upperHUD = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:hudSize];
    upperHUD.anchorPoint = CGPointMake(0, 1);
    upperHUD.position = CGPointMake(0, screenHeight);
    upperHUD.zPosition = 10;
    _upperHUD = upperHUD;
    [self addChild:_upperHUD];
    
    //PLAYER's HP AND STAMINA BARS
    //HP bars
    CGSize barSize = CGSizeMake(upperHUD.size.width / 3, upperHUD.size.height / 5);
    
    SKSpriteNode *hpBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    hpBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    hpBarBackgroundNode.zPosition = 11;
    hpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 2);
    [_upperHUD addChild:hpBarBackgroundNode];
    
    SKSpriteNode *hpBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:barSize];
    hpBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    hpBarNode.zPosition = 12;
    [hpBarBackgroundNode addChild:hpBarNode];
    
    //Stamina Bars
    SKSpriteNode *staminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    staminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    staminaBarBackgroundNode.zPosition = 11;
    staminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 4);
    [_upperHUD addChild:staminaBarBackgroundNode];
    
    SKSpriteNode *staminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    staminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    staminaBarNode.zPosition = 12;
    [staminaBarBackgroundNode addChild:staminaBarNode];
    
    //OPPONENT's HP AND STAMINA BARS
    //HP bars
    
    SKSpriteNode *opponentHpBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    opponentHpBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    opponentHpBarBackgroundNode.zPosition = 11;
    opponentHpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width - (_upperHUD.size.width * 0.05 + barSize.width), - barSize.height * 2);
    [_upperHUD addChild:opponentHpBarBackgroundNode];
    
    SKSpriteNode *opponentHpBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:barSize];
    opponentHpBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    opponentHpBarNode.zPosition = 12;
    [opponentHpBarBackgroundNode addChild:opponentHpBarNode];
    
    //Stamina Bars
    SKSpriteNode *opponentStaminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    opponentStaminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    opponentStaminaBarBackgroundNode.zPosition = 11;
    opponentStaminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width - (_upperHUD.size.width * 0.05 + barSize.width), - barSize.height * 4);
    [_upperHUD addChild:opponentStaminaBarBackgroundNode];
    
    SKSpriteNode *opponentStaminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    opponentStaminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    opponentStaminaBarNode.zPosition = 12;
    [opponentStaminaBarBackgroundNode addChild:opponentStaminaBarNode];
    
    //Lower HUD
    SKSpriteNode *lowerHUD = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:hudSize];
    lowerHUD.anchorPoint = CGPointMake(0, 0);
    lowerHUD.position = CGPointMake(0, 0);
    lowerHUD.zPosition = 10;
    _lowerHUD = lowerHUD;
    [self addChild:_lowerHUD];
    
    //Timer bar
    CGSize timerBarSize = CGSizeMake(upperHUD.size.width / 3 * 2, upperHUD.size.height / 3);
    SKSpriteNode *timerBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:timerBarSize];
    timerBarNode.anchorPoint = CGPointMake(0.5, 0.5); // May be need to change to (0, 0.5) to perform better reductuion of time;
    timerBarNode.position = CGPointMake(_lowerHUD.size.width / 2, _lowerHUD.size.height / 2);
    timerBarNode.zPosition = 11;
    [_lowerHUD addChild:timerBarNode];
}

- (void)addActionScreens {

    CGSize mainActionScreenSize = CGSizeMake(screenWidth, screenHeight - (_upperHUD.size.height + _lowerHUD.size.height));
    SKSpriteNode *mainActionScreen = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:mainActionScreenSize];
    mainActionScreen.anchorPoint = CGPointMake(0, 0);
    mainActionScreen.position = CGPointMake(0, _lowerHUD.size.height);
    mainActionScreen.zPosition = 1;
    
    _mainActionScreen = mainActionScreen;
    [self addChild:_mainActionScreen];
    
    //ShapeNodes
    CGSize rectSize = CGSizeMake(_mainActionScreen.size.width / 2, _mainActionScreen.size.height / 2);
    
    //upperLeft
    SKShapeNode *upperLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperLeftScreen.name = @"upperLeftScreen";
    upperLeftScreen.fillColor = [SKColor clearColor];
    upperLeftScreen.strokeColor = [SKColor grayColor];
    upperLeftScreen.position = CGPointMake(rectSize.width / 2, rectSize.height * 1.5);
    upperLeftScreen.zPosition = 10;
    upperLeftScreen.alpha = 0.3;
    _upperLeftScreen = upperLeftScreen;
    [_mainActionScreen addChild:_upperLeftScreen];
    
    //upperRight
    SKShapeNode *upperRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    upperRightScreen.name = @"upperRightScreen";
    upperRightScreen.fillColor = [SKColor clearColor];
    upperRightScreen.strokeColor = [SKColor grayColor];
    upperRightScreen.position = CGPointMake(rectSize.width * 1.5, rectSize.height * 1.5);
    upperRightScreen.zPosition = 10;
    upperRightScreen.alpha = 0.3;
    _upperRightScreen = upperRightScreen;
    [_mainActionScreen addChild:_upperRightScreen];
    
    //lowerLeft
    SKShapeNode *lowerLeftScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerLeftScreen.name = @"lowerLeftScreen";
    lowerLeftScreen.fillColor = [SKColor clearColor];
    lowerLeftScreen.strokeColor = [SKColor grayColor];
    lowerLeftScreen.position = CGPointMake(rectSize.width / 2, rectSize.height / 2);
    lowerLeftScreen.zPosition = 10;
    lowerLeftScreen.alpha = 0.3;
    _lowerLeftScreen = lowerLeftScreen;
    [_mainActionScreen addChild:_lowerLeftScreen];
    
    //lowerRight
    SKShapeNode *lowerRightScreen = [SKShapeNode shapeNodeWithRectOfSize:rectSize];
    lowerRightScreen.name = @"lowerRightScreen";
    lowerRightScreen.fillColor = [SKColor clearColor];
    lowerRightScreen.strokeColor = [SKColor grayColor];
    lowerRightScreen.position = CGPointMake(rectSize.width * 1.5, rectSize.height / 2);
    lowerRightScreen.zPosition = 10;
    lowerRightScreen.alpha = 0.3;
    _lowerRightScreen = lowerRightScreen;
    [_mainActionScreen addChild:_lowerRightScreen];
}

- (void)addPlayer {

    CGSize playerSize = CGSizeMake(screenWidth/4, screenHeight/2);
    Fighter *player = [Fighter spriteNodeWithColor:[SKColor greenColor] size:playerSize];
    player.anchorPoint = CGPointMake(0.5,0.5);
    player.position = CGPointMake(screenWidth/2, screenHeight/2);
    player.zPosition = 2;
    player.name = @"playerNode";
    
    player.fighterName = @"playerName";
    player.hp = 10;
    player.stamina = 100;
    
    //DAMAGE
    
    //leftUp damage
    player.leftStraightPunchDamage = 1;
    player.leftSwingPunchDamage = 3;
    player.leftUppercutPunchDamage = 4;
    
    //rightUp damage
    player.rightStraightPunchDamage = 1;
    player.rightSwingPunchDamage = 3;
    player.rightUppercutPunchDamage = 4;
    
    //leftDown damage
    player.leftStraightKickDamage = 2;
    player.leftSwingKickDamage = 3;
    player.leftHighKickDamage = 5;
    
    //rightDown damage
    player.rightStraightKickDamage = 2;
    player.rightSwingKickDamage = 3;
    player.rightHighKickDamage = 5;
    
    //STAMINA
    
    //leftUp stamina
    player.leftStraightPunchStamina = 1;
    player.leftSwingPunchStamina = 3;
    player.leftUppercutPunchStamina = 4;
    player.leftUpBlockStamina = 1;
    
    //rightUp stamina
    player.rightStraightPunchStamina = 1;
    player.rightSwingPunchStamina = 3;
    player.rightUppercutPunchStamina = 4;
    player.rightUpBlockStamina = 1;
    
    //leftDown stamina
    player.leftStraightKickStamina = 2;
    player.leftSwingKickStamina = 3;
    player.leftHighKickStamina = 5;
    player.leftDownBlockStamina = 1;
    
    //rightDown stamina
    player.rightStraightKickStamina = 2;
    player.rightSwingKickStamina = 3;
    player.rightHighKickStamina = 5;
    player.rightDownBlockStamina = 1;

    _player = player;
    
    //[self addChild:_player];
}

- (void)addOpponent {

    CGSize opponentSize = CGSizeMake(screenWidth/4, screenHeight/2);
    Fighter *opponent = [Fighter spriteNodeWithColor:[SKColor greenColor] size:opponentSize];
    opponent.anchorPoint = CGPointMake(0.5,0.5);
    opponent.position = CGPointMake(screenWidth/2, screenHeight/2);
    opponent.zPosition = 2;
    opponent.fighterName = @"opponentName";
    opponent.name = @"opponentNode";
    
    opponent.hp = 10;
    opponent.stamina = 100;
    
    //DAMAGE
    
    //leftUp damage
    opponent.leftStraightPunchDamage = 1;
    opponent.leftSwingPunchDamage = 3;
    opponent.leftUppercutPunchDamage = 4;
    
    //rightUp damage
    opponent.rightStraightPunchDamage = 1;
    opponent.rightSwingPunchDamage = 3;
    opponent.rightUppercutPunchDamage = 4;
    
    //leftDown damage
    opponent.leftStraightKickDamage = 2;
    opponent.leftSwingKickDamage = 3;
    opponent.leftHighKickDamage = 5;
    
    //rightDown damage
    opponent.rightStraightKickDamage = 2;
    opponent.rightSwingKickDamage = 3;
    opponent.rightHighKickDamage = 5;
    
    //STAMINA
    
    //leftUp stamina
    opponent.leftStraightPunchStamina = 1;
    opponent.leftSwingPunchStamina = 3;
    opponent.leftUppercutPunchStamina = 4;
    opponent.leftUpBlockStamina = 1;
    
    //rightUp stamina
    opponent.rightStraightPunchStamina = 1;
    opponent.rightSwingPunchStamina = 3;
    opponent.rightUppercutPunchStamina = 4;
    opponent.rightUpBlockStamina = 1;
    
    //leftDown stamina
    opponent.leftStraightKickStamina = 2;
    opponent.leftSwingKickStamina = 3;
    opponent.leftHighKickStamina = 5;
    opponent.leftDownBlockStamina = 1;
    
    //rightDown stamina
    opponent.rightStraightKickStamina = 2;
    opponent.rightSwingKickStamina = 3;
    opponent.rightHighKickStamina = 5;
    opponent.rightDownBlockStamina = 1;

    _opponent = opponent;
    [self addChild:_opponent];
}

#pragma mark - UIGestureRecognizer
- (void)addGestureRecognizers {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *leftToRightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftToRightSwipe:)];
    leftToRightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftToRightSwipeGesture];
    
    UISwipeGestureRecognizer *rightToLeftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleRightToLeftSwipe:)];
    rightToLeftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightToLeftSwipeGesture];
    
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleUpSwipe:)];
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipeGesture];
    
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleDownSwipe:)];
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipeGesture];
}

- (void)handleTap:(UITapGestureRecognizer *) tapGesture {
    
    //Detect which node was tapped
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [tapGesture locationInView:tapGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer

        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation];//Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self leftStraightPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self rightStraightPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self leftStraightKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self rightStraightKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleLeftToRightSwipe:(UITapGestureRecognizer *) leftToRightSwipeGesture {
    
    //Detect which node was swiped
    if (leftToRightSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [leftToRightSwipeGesture locationInView:leftToRightSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self leftSwingPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self leftSwingKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleRightToLeftSwipe:(UITapGestureRecognizer *) rightToLeftSwipeGesture {
    
    //Detect which node was swiped
    if (rightToLeftSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [rightToLeftSwipeGesture locationInView:rightToLeftSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation]; //конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self rightSwingPunch];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self rightSwingKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleUpSwipe: (UISwipeGestureRecognizer *) upSwipeGesture {

    if (upSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [upSwipeGesture locationInView:upSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self leftUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self rightUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self leftHighKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self rightHighKick];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

- (void)handleDownSwipe: (UISwipeGestureRecognizer *) downSwipeGesture {
    
    if (downSwipeGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint touchLocation = [downSwipeGesture locationInView:downSwipeGesture.view];//находим позицию тача на вьюхе, к которой прикреплен GestureRecognizer
        touchLocation = [self convertPointFromView:touchLocation];//конвертируем позицию тача из координат вьюхи в координаты GameScene
        SKNode *touchedNode = (SKNode *)[self nodeAtPoint:touchLocation]; //Находим нод, который соответствует позиции на GameScene
        
        if([touchedNode.name isEqualToString:@"upperLeftScreen"]) {
            [self leftUpBlock];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self rightUpBlock];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self leftDownBlock];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self rightDownBlock];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

#pragma mark --- Player's Punches and Kicks
//leftUp
- (void)leftStraightPunch {
    NSLog(@"leftStraightPunch");
}
- (void)leftSwingPunch {
    NSLog(@"leftSwingPunch");
}
- (void)leftUppercutPunch {
    NSLog(@"leftUppercutPunch");
}
- (void)leftUpBlock {
    NSLog(@"leftUpBlock");
}

//rightUp
- (void)rightStraightPunch {
    NSLog(@"rightStraightPunch");
}
- (void)rightSwingPunch {
    NSLog(@"rightSwingPunch");
}
- (void)rightUppercutPunch {
    NSLog(@"rightUppercutPunch");
}
- (void)rightUpBlock {
    NSLog(@"rightUpBlock");
}

//leftDown
- (void)leftStraightKick {
    NSLog(@"leftStraightKick");
}
- (void)leftSwingKick {
    NSLog(@"leftSwingKick");
}
- (void)leftHighKick {
    NSLog(@"leftHighKick");
}
- (void)leftDownBlock {
    NSLog(@"leftDownBlock");
}

//rightDown
- (void)rightStraightKick {
    NSLog(@"rightStraightKick");
}
- (void)rightSwingKick {
    NSLog(@"rightSwingKick");
}
- (void)rightHighKick {
    NSLog(@"rightHighKick");
}
- (void)rightDownBlock {
    NSLog(@"rightDownBlock");
}



@end
