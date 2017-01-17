//
//  GameScene.m
//  FightGame
//
//  Created by Илья on 03.01.17.
//  Copyright © 2017 Ilya Biltuev. All rights reserved.
//

#import "GameScene.h"
#import "Fighter.h"
#import "FighterAction.h"

@implementation GameScene {
    
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    SKSpriteNode *_upperHUD;
    SKSpriteNode *_lowerHUD;
    
    CGSize _defaultBarSize;
    
    SKSpriteNode *_playerHpBar;
    SKSpriteNode *_opponentHpBar;
    
    SKSpriteNode *_playerStaminaBar;
    SKSpriteNode *_opponentStaminaBar;
    
    SKSpriteNode *_mainActionScreen;
    SKShapeNode *_upperLeftScreen;
    SKShapeNode *_upperRightScreen;
    SKShapeNode *_lowerLeftScreen;
    SKShapeNode *_lowerRightScreen;
    
    Fighter *_player;
    Fighter *_opponent;
    
    //Gameplay variables
    
    BOOL _firstAndSecondActionsAreAlreadySet;
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
    _defaultBarSize = barSize;
    
    SKSpriteNode *hpBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    hpBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    hpBarBackgroundNode.zPosition = 11;
    hpBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 2);
    [_upperHUD addChild:hpBarBackgroundNode];
    
    SKSpriteNode *hpBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:barSize];
    hpBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    hpBarNode.zPosition = 12;
    _playerHpBar = hpBarNode;
    [hpBarBackgroundNode addChild:_playerHpBar];
    
    //Stamina Bars
    SKSpriteNode *staminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    staminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    staminaBarBackgroundNode.zPosition = 11;
    staminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width * 0.05, - barSize.height * 4);
    [_upperHUD addChild:staminaBarBackgroundNode];
    
    SKSpriteNode *staminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    staminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    staminaBarNode.zPosition = 12;
    _playerStaminaBar = staminaBarNode;
    [staminaBarBackgroundNode addChild:_playerStaminaBar];
    
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
    _opponentHpBar = opponentHpBarNode;
    [opponentHpBarBackgroundNode addChild:_opponentHpBar];
    
    //Stamina Bars
    SKSpriteNode *opponentStaminaBarBackgroundNode = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:barSize];
    opponentStaminaBarBackgroundNode.anchorPoint = CGPointMake(0, 0);
    opponentStaminaBarBackgroundNode.zPosition = 11;
    opponentStaminaBarBackgroundNode.position = CGPointMake(_upperHUD.size.width - (_upperHUD.size.width * 0.05 + barSize.width), - barSize.height * 4);
    [_upperHUD addChild:opponentStaminaBarBackgroundNode];
    
    SKSpriteNode *opponentStaminaBarNode = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:barSize];
    opponentStaminaBarNode.anchorPoint = CGPointMake(0, 0); // May be need to change to (0, 0.5) to perform better reductuion of hp;
    opponentStaminaBarNode.zPosition = 12;
    _opponentStaminaBar = opponentStaminaBarNode;
    [opponentStaminaBarBackgroundNode addChild:_opponentStaminaBar];
    
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

    //создаем игрока, но не добавляем его на сцену
    CGSize playerSize = CGSizeMake(screenWidth/4, screenHeight/2);
    Fighter *player = [Fighter spriteNodeWithColor:[SKColor greenColor] size:playerSize];
    player.anchorPoint = CGPointMake(0.5,0.5);
    player.position = CGPointMake(screenWidth/2, screenHeight/2);
    player.zPosition = 2;
    player.name = @"playerNode";
    
    player.fighterName = @"playerName";
    player.hp = 100;
    player.stamina = 10;
    
    //leftUp
    player.leftStraightPunch = [[FighterAction alloc]initWithActionName:@"leftStraightPunch" stamina:1 damage:1];
    player.leftSwingPunch = [[FighterAction alloc]initWithActionName:@"leftSwingPunch" stamina:3 damage:3];
    player.leftUppercutPunch = [[FighterAction alloc]initWithActionName:@"leftUppercutPunch" stamina:4 damage:4];
    player.leftUpBlock = [[FighterAction alloc]initWithActionName:@"leftUpBlock" stamina:1 damage:0];
    
    //rightUp
    player.rightStraightPunch = [[FighterAction alloc]initWithActionName:@"rightStraightPunch" stamina:1 damage:1];
    player.rightSwingPunch = [[FighterAction alloc]initWithActionName:@"rightSwingPunch" stamina:3 damage:3];
    player.rightUppercutPunch = [[FighterAction alloc]initWithActionName:@"rightUppercutPunch" stamina:4 damage:4];
    player.rightUpBlock = [[FighterAction alloc]initWithActionName:@"rightUpBlock" stamina:1 damage:0];
    
    //leftDown
    player.leftStraightKick = [[FighterAction alloc]initWithActionName:@"leftStraightKick" stamina:2 damage:2];
    player.leftSwingKick = [[FighterAction alloc]initWithActionName:@"leftSwingKick" stamina:3 damage:3];
    player.leftHighKick = [[FighterAction alloc]initWithActionName:@"leftHighKick" stamina:5 damage:5];
    player.leftDownBlock = [[FighterAction alloc]initWithActionName:@"leftDownBlock" stamina:1 damage:0];
    
    //rightDown
    player.rightStraightKick = [[FighterAction alloc]initWithActionName:@"rightStraightKick" stamina:2 damage:2];
    player.rightSwingKick = [[FighterAction alloc]initWithActionName:@"rightSwingKick" stamina:3 damage:3];
    player.rightHighKick = [[FighterAction alloc]initWithActionName:@"rightHighKick" stamina:5 damage:5];
    player.rightDownBlock = [[FighterAction alloc]initWithActionName:@"rightDownBlock" stamina:1 damage:0];

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
    
    opponent.hp = 100;
    opponent.stamina = 10;
    
    //leftUp
    opponent.leftStraightPunch = [[FighterAction alloc]initWithActionName:@"leftStraightPunch" stamina:1 damage:1];
    opponent.leftSwingPunch = [[FighterAction alloc]initWithActionName:@"leftSwingPunch" stamina:3 damage:3];
    opponent.leftUppercutPunch = [[FighterAction alloc]initWithActionName:@"leftUppercutPunch" stamina:4 damage:4];
    opponent.leftUpBlock = [[FighterAction alloc]initWithActionName:@"leftUpBlock" stamina:1 damage:0];
    
    //rightUp
    opponent.rightStraightPunch = [[FighterAction alloc]initWithActionName:@"rightStraightPunch" stamina:1 damage:1];
    opponent.rightSwingPunch = [[FighterAction alloc]initWithActionName:@"rightSwingPunch" stamina:3 damage:3];
    opponent.rightUppercutPunch = [[FighterAction alloc]initWithActionName:@"rightUppercutPunch" stamina:4 damage:4];
    opponent.rightUpBlock = [[FighterAction alloc]initWithActionName:@"rightUpBlock" stamina:1 damage:0];
    
    //leftDown
    opponent.leftStraightKick = [[FighterAction alloc]initWithActionName:@"leftStraightKick" stamina:2 damage:2];
    opponent.leftSwingKick = [[FighterAction alloc]initWithActionName:@"leftSwingKick" stamina:3 damage:3];
    opponent.leftHighKick = [[FighterAction alloc]initWithActionName:@"leftHighKick" stamina:5 damage:5];
    opponent.leftDownBlock = [[FighterAction alloc]initWithActionName:@"leftDownBlock" stamina:1 damage:0];
    
    //rightDown
    opponent.rightStraightKick = [[FighterAction alloc]initWithActionName:@"rightStraightKick" stamina:2 damage:2];
    opponent.rightSwingKick = [[FighterAction alloc]initWithActionName:@"rightSwingKick" stamina:3 damage:3];
    opponent.rightHighKick = [[FighterAction alloc]initWithActionName:@"rightHighKick" stamina:5 damage:5];
    opponent.rightDownBlock = [[FighterAction alloc]initWithActionName:@"rightDownBlock" stamina:1 damage:0];

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
            [self handleLeftStraightPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightStraightPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftStraightKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightStraightKick];
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
            [self handleLeftSwingPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftSwingKick];
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
            [self handleRightSwingPunch];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightSwingKick];
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
            [self handleLeftUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightUppercutPunch];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftHighKick];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightHighKick];
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
            [self handleLeftUpBlock];
        } else if([touchedNode.name isEqualToString:@"upperRightScreen"]) {
            [self handleRightUpBlock];
        } else if([touchedNode.name isEqualToString:@"lowerLeftScreen"]) {
            [self handleLeftDownBlock];
        } else if ([touchedNode.name isEqualToString:@"lowerRightScreen"]) {
            [self handleRightDownBlock];
        } else {
            NSLog(@"Incorrect node was tapped - no action is executed");
        }
    }
}

#pragma mark --- Player's Punches and Kicks
//leftUp
- (void)handleLeftStraightPunch {
    
    NSLog(@"leftStraightPunch");
    
    NSString *playerActionName = @"leftStraightPunch";
    
    FighterAction *leftStraightPunch =  _player.leftStraightPunch;
    
    //CHECK STAMINA
    if (_player.stamina > 0) {
    
    //CHECK whether TIME is Out or Not --- Таймер еще не добавлен!
        
    //set first or second action
    [self checkPlayerFirstAndSecondActions:leftStraightPunch];
        
        //Check whether First and Second actions are already set or not
        if (!_firstAndSecondActionsAreAlreadySet) {
        
    /************ LET'S CHECK FIRST ACTION *****************/
        
        //1.check if this left punch is First action
        if ([_player.firstAction.actionName isEqualToString:playerActionName]) {
    
            //2.reduce player's stamina and player's stamina bar
            [self reduceStaminaOfFighter: _player
                   reduceStaminaBarWidth: _playerStaminaBar
                      usingFighterAction:_player.leftStraightPunch];
             
            //3.check if this left punch (First action) is NOT blocked by opponent
            if (![_opponent.firstAction.actionName isEqualToString:@"rightUpBlock"]) {
            
                //4.reduce opponent's hp and size of opponent's hp bar
                if (_opponent.hp > 0) {
    
                   [self reduceHpOfFighter:_opponent
                          reduceHpBarWidth:_opponentHpBar
                usingOpponentFighterAction:_player.leftStraightPunch];
            }
                
        } else {
            
            NSLog(@"leftStraightPunch was blocked by opponent");
            }}
    
    /************ LET'S CHECK SECOND ACTION *****************/
    
        //1.check if this left punch is Second action /*/
       else if ([_player.secondAction.actionName isEqualToString:playerActionName]) {
            
           //2.reduce player's stamina and player's stamina bar
           [self reduceStaminaOfFighter: _player
                  reduceStaminaBarWidth: _playerStaminaBar
                     usingFighterAction:_player.leftStraightPunch];
           
            //3.check if this left punch (First action) is NOT blocked by opponent /*/
            if (![_opponent.secondAction.actionName isEqualToString:@"rightUpBlock"]) {
                
                //4.reduce opponent's hp and size of opponent's hp bar
                if (_opponent.hp > 0) {
                    
                    [self reduceHpOfFighter:_opponent
                           reduceHpBarWidth:_opponentHpBar
                 usingOpponentFighterAction:_player.leftStraightPunch];
                }
            } else {
                
                NSLog(@"leftStraightPunch was blocked by opponent");
            
            }}else {
                NSLog(@"FIRST AND SECOND ACTIONS ARE ALREADY SET!");
            }
        
        }} else {
        
    NSLog(@"NOT ENOUGH STAMINA!");
}}

- (void)handleLeftSwingPunch {
    
    NSLog(@"leftSwingPunch");
    [self checkPlayerFirstAndSecondActions:@"leftSwingPunch"];
}
- (void)handleLeftUppercutPunch {
    
    NSLog(@"leftUppercutPunch");
    [self checkPlayerFirstAndSecondActions:@"leftUppercutPunch"];
}
- (void)handleLeftUpBlock {
    
    NSLog(@"leftUpBlock");
    [self checkPlayerFirstAndSecondActions:@"leftUpBlock"];
}

//rightUp
- (void)handleRightStraightPunch {
    
    NSLog(@"rightStraightPunch");
    [self checkPlayerFirstAndSecondActions:@"rightStraightPunch"];
}
- (void)handleRightSwingPunch {
    
    NSLog(@"rightSwingPunch");
    [self checkPlayerFirstAndSecondActions:@"rightSwingPunch"];
}
- (void)handleRightUppercutPunch {
    
    NSLog(@"rightUppercutPunch");
    [self checkPlayerFirstAndSecondActions:@"rightUppercutPunch"];
}
- (void)handleRightUpBlock {
    
    NSLog(@"rightUpBlock");
    [self checkPlayerFirstAndSecondActions:@"rightUpBlock"];
}

//leftDown
- (void)handleLeftStraightKick {
    
    NSLog(@"leftStraightKick");
    [self checkPlayerFirstAndSecondActions:@"leftStraightKick"];
}
- (void)handleLeftSwingKick {
    
    NSLog(@"leftSwingKick");
    [self checkPlayerFirstAndSecondActions:@"leftSwingKick"];
}
- (void)handleLeftHighKick {
    
    NSLog(@"leftHighKick");
    [self checkPlayerFirstAndSecondActions:@"leftHighKick"];
}
- (void)handleLeftDownBlock {
    
    NSLog(@"leftDownBlock");
    [self checkPlayerFirstAndSecondActions:@"leftDownBlock"];
}

//rightDown
- (void)handleRightStraightKick {
    
    NSLog(@"rightStraightKick");
    [self checkPlayerFirstAndSecondActions:@"rightStraightKick"];
}
- (void)handleRightSwingKick {
    
    NSLog(@"rightSwingKick");
    [self checkPlayerFirstAndSecondActions:@"rightSwingKick"];
}
- (void)handleRightHighKick {
    
    NSLog(@"rightHighKick");
    [self checkPlayerFirstAndSecondActions:@"rightHighKick"];
}
- (void)handleRightDownBlock {
    
    NSLog(@"rightDownBlock");
    [self checkPlayerFirstAndSecondActions:@"rightDownBlock"];
}

- (void)checkPlayerFirstAndSecondActions: (FighterAction *)fighterAction {
    
    if (!_player.firstAction) {
        _player.firstAction = fighterAction;
        NSLog(@"\n\nplayer's FIRST ACTION is : %@\n\n", _player.firstAction.actionName);
    } else if (!_player.secondAction) {
        _player.secondAction = fighterAction;
        NSLog(@"\n\nplayer's SECOND ACTION is : %@\n\n", _player.secondAction.actionName);
    }else {
        _firstAndSecondActionsAreAlreadySet = YES;
    }
}

- (void)reduceStaminaOfFighter: (Fighter *)fighter reduceStaminaBarWidth: (SKSpriteNode *)fighterStaminaBar usingFighterAction:(FighterAction *)fighterAction {

    //reduce stamina value of fighter
    fighter.stamina = fighter.stamina - fighter.leftStraightPunch.stamina;
    
    //reduce width of fighter's stamina bar
    CGFloat staminaBarNewWidth = fighterStaminaBar.size.width - _defaultBarSize.width * fighterAction.stamina / 10;
    fighterStaminaBar.size = CGSizeMake(staminaBarNewWidth, fighterStaminaBar.size.height);
    
    NSLog(@"player's stamina = %d, player's staminaBarWidth = %f", fighter.stamina, fighterStaminaBar.size.width);
}

- (void)reduceHpOfFighter: (Fighter *)fighter reduceHpBarWidth: (SKSpriteNode *)fighterHpBar usingOpponentFighterAction: (FighterAction *) fighterAction {

    //reduce hp
    fighter.hp = fighter.hp - fighterAction.damage;
    
    //reduce width of HpBar
    CGFloat hpBarNewWidth = fighterHpBar.size.width - _defaultBarSize.width * fighterAction.damage / 100;
    fighterHpBar.size = CGSizeMake(hpBarNewWidth, fighterHpBar.size.height);
    
    NSLog(@"fighter hp = %d, opponent's hpBarWidth = %f", fighter.hp, fighterHpBar.size.width);
}

@end
