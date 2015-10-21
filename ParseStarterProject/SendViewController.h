//
//  SendViewController.h
//  ParseStarterProject
//
//  Created by MBP on 10/21/15.
//
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"

@interface SendViewController : UIViewController

@property FDTakeController *takeController;

- (IBAction)sendImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendImageButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
 
@end
