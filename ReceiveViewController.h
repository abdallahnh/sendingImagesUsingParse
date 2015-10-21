//
//  ReceiveViewController.h
//  ParseStarterProject
//
//  Created by MBP on 10/21/15.
//
//

#import <UIKit/UIKit.h>

@interface ReceiveViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
-(void)setReceivedImage:(NSString*)oId;
@end
