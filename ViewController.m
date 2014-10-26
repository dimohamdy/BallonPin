//
//  ViewController.m
//  BallonPin
//
//  Created by binaryboy on 10/26/14.
//  Copyright (c) 2014 AhmedHamdy. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface ViewController ()

@end

@implementation ViewController
{
    float count;
}
@synthesize ballon;
@synthesize pin;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    count=0.1;
    
    [ballon  addTarget:self action:@selector(wasDragged:withEvent:)
       forControlEvents:UIControlEventTouchDragInside];
    ballon.tag=1;
    [pin  addTarget:self action:@selector(wasDragged:withEvent:)
       forControlEvents:UIControlEventTouchDragInside];
    pin.tag=1;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAir:(id)sender
{
    count+=.1;
    
    [UIView animateWithDuration: 1
                          delay: 0
                        options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         ballon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1+count, 1.1+count);}
                     completion:^(BOOL finished) { }
     ];

}
- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    // get the touch
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    // get delta
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;
    
    // move button
    button.center = CGPointMake(button.center.x + delta_x,
                                button.center.y + delta_y);

    [self did:pin inRangeOf:ballon];
        
    
    
}

- (void)did:(UIButton*)btn_1 inRangeOf:(UIButton*)btn_2
{
    CGPoint point = btn_1.center;
    
    if (CGRectContainsPoint(btn_2.frame, point) && btn_1.tag==btn_2.tag) {

        [self playSoundEffect];
        
        
        
        [UIView animateWithDuration: 1
                              delay: 0
                            options: (UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             ballon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1+count);}
                         completion:^(BOOL finished) { }
         ];
        
        
    }else
    {
        
    }
}
-(void)playSoundEffect
{
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"BalloonPopping" ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    SystemSoundID audioEffect;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
    
    // call the following function when the sound is no longer used
    // (must be done AFTER the sound is done playing)
    AudioServicesDisposeSystemSoundID(audioEffect);
}
@end
