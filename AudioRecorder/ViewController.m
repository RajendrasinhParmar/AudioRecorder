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
    
    NSError *error;
    //Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"pelluAudio.m4a", nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    //set audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    //Recording settings
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    [settings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [settings setValue:[NSNumber numberWithFloat:12000.0] forKey:AVSampleRateKey];
    [settings setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
//    [settings setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//    [settings setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&error];
    if(!audioRecorder){
        NSLog(@"Error establishing recorder: %@",error.localizedFailureReason);
    }
    audioRecorder.delegate = self;
    audioRecorder.meteringEnabled = YES;
    if(![audioRecorder prepareToRecord]){
        NSLog(@"Error: Record failed");
    }
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
//        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[recorder.url absoluteString] error:nil];
//        NSNumber *fileSizeNumber = [fileDictionary objectForKey:NSFileSize];
//        long long fileSize = [fileSizeNumber longLongValue];
//        NSLog(@"File Size is %lld",fileSize);
        NSNumber *thesize;
        NSInteger fileSize = 0;
        if([recorder.url getResourceValue:&thesize forKey:NSURLFileSizeKey error:nil]){
            fileSize = [thesize integerValue];
        }
        NSLog(@"File size is %ld",(long)fileSize);
    }else{
        NSLog(@"File not written");
    }
}

@end
