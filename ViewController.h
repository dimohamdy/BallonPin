//
//  ViewController.h
//  BallonPin
//
//  Created by binaryboy on 10/26/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *ballon;
@property (strong, nonatomic) IBOutlet UIButton *pin;

- (IBAction)pushAir:(id)sender;
@end

