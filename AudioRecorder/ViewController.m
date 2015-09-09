//
//  ViewController.m
//  AudioRecorder
//
//  Created by Rajendrasinh Parmar on 09/09/15.
//  Copyright (c) 2015 Rajendrasinh Parmar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    AVAudioRecorder *audioRecorder;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"pelluAudio.wav", nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    //set audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:nil error:nil];
    audioRecorder.delegate = self;
    audioRecorder.meteringEnabled = YES;
    [audioRecorder prepareToRecord];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordAudio:(UIButton *)sender {
    if (!audioRecorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        //start recording
        [audioRecorder record];
    }
}

- (IBAction)stopRecording:(UIButton *)sender {
    [audioRecorder stop];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
}


#pragma mark -
#pragma mark AVAudioRecorderDelegate

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"File successfully written at path : %@",[recorder.url absoluteString]);
        //NSDictionary *fileDictionary = [[NSFileManager defaultManager] fileAttributesAtPath:[recorder.url absoluteString] traverseLink:YES];
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[recorder.url absoluteString] error:nil];
        NSNumber *fileSizeNumber = [fileDictionary objectForKey:NSFileSize];
        unsigned long long fileSize = [fileSizeNumber longLongValue];
        NSLog(@"File Size is %llu",fileSize);
    }else{
        NSLog(@"File not written");
    }
}

@end
