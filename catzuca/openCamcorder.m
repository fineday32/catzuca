////
////  photoCVCCell.m
////  catzuca
////
////  Created by Thomas on 2013/10/28.
////  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
////
//
//#import "photoCVCCell.h"
//
//@implementation photoCVCCell
//
//
//- (void) openCamcorder:(id)sender{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    //    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    //    //original type
//    //    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    //    //
//    //    //not to use this method
//    //    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
//    //    //
//    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
//    picker.videoMaximumDuration = 10;
//    picker.delegate = self;
//    [self presentViewController:picker animated:NO completion:nil];
//    
//}
//
//
//
//
//
//// For responding to the user tapping Cancel.
//- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
//    
//    [[picker parentViewController] dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"Video recording canceled");
//    }];
//    
//}
//
//
//// For responding to the user accepting a newly-captured picture or movie
//- (void) imagePickerController: (UIImagePickerController *) picker
// didFinishPickingMediaWithInfo: (NSDictionary *) info {
//    
//    //    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//    //    UIImage *originalImage, *editedImage, *imageToSave;
//    //
//    //    // Handle a still image capture
//    //    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
//    //        == kCFCompareEqualTo) {
//    //
//    //        editedImage = (UIImage *) [info objectForKey:
//    //                                   UIImagePickerControllerEditedImage];
//    //        originalImage = (UIImage *) [info objectForKey:
//    //                                     UIImagePickerControllerOriginalImage];
//    //
//    //        if (editedImage) {
//    //            imageToSave = editedImage;
//    //        } else {
//    //            imageToSave = originalImage;
//    //        }
//    //
//    //        // Save the new image (original or edited) to the Camera Roll
//    //        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
//    //    }
//    //
//    //    // Handle a movie capture
//    //    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
//    //        == kCFCompareEqualTo) {
//    //
//    //
//    //        NSString *moviePath = [info objectForKey:[UIImagePickerControllerMediaURL]];
//    //
//    ////        [[info objectForKey:
//    ////                                UIImagePickerControllerMediaURL] path];
//    //
//    //        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//    //            UISaveVideoAtPathToSavedPhotosAlbum (
//    //                                                 moviePath, nil, nil, nil);
//    //        }
//    //    }
//    //
//    
//    
//    NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
//    UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);
//    
//    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
//    
//}
//
//
//
//@end
