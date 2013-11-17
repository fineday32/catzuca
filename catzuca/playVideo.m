//
//  playVideo.m
//  catzuca
//
//  Created by Thomas on 2013/11/16.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "playVideo.h"
#import <MediaPlayer/MediaPlayer.h>
#import "catzucaIO.h"

@implementation playVideo

- (void)viewDidLoad{
    if ([[catzucaIO sharedData] getShouldPlayMergeVideo])
    {
        
        [[catzucaIO sharedData] minusVideoGalleryVCCount];
        // Handle a movie capture
        NSURL *url = [[catzucaIO sharedData] getURLForPlayingMergeVideo];
        MPMoviePlayerViewController* theMovie =
        [[MPMoviePlayerViewController alloc] initWithContentURL: url];
        
        // Register for the playback finished notification
        [[NSNotificationCenter defaultCenter]
         addObserver: self
         selector: @selector(myMovieFinishedCallback:)
         name: MPMoviePlayerPlaybackDidFinishNotification
         object: theMovie];
        theMovie.view.frame = CGRectMake(100, 100, 50, 50);
        
        
        theMovie.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        
        
    }
}

@end
