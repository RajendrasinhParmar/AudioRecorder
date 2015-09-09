//
//  ViewController.h
//  AudioRecorder
//
//  Created by Rajendrasinh Parmar on 09/09/15.
//  Copyright (c) 2015 Rajendrasinh Parmar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController < AVAudioRecorderDelegate>

- (IBAction)recordAudio:(UIButton *)sender;

- (IBAction)stopRecording:(UIButton *)sender;
@end

