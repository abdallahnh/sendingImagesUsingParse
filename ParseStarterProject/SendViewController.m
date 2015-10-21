//
//  SendViewController.m
//  ParseStarterProject
//
//  Created by MBP on 10/21/15.
//
//

#import "SendViewController.h"
#import <Parse/Parse.h>

@interface SendViewController () <FDTakeDelegate>


@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = self;
    self.takeController.allowsEditingPhoto = YES;
    self.sendImageButton.enabled=NO;
    [self performSelector:@selector(openPicker) withObject:nil afterDelay:0.4];
}
-(void)openPicker
{
    [self.takeController takePhotoOrChooseFromLibrary];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendImage:(id)sender {
    //call cloud function
    UIImage * img =self.imageView.image;
    NSData * data = UIImageJPEGRepresentation(img, 0.8);
    NSString * dtoken=[[NSUserDefaults standardUserDefaults] valueForKey:@"dtoken"];
    
    [PFCloud callFunctionInBackground:@"uploadImage" withParameters:@{@"BCImage":data,@"dToken":dtoken} block:^(id  _Nullable object, NSError * _Nullable error) {
        //
    }];
}

#pragma mark - FDTakeDelegate

- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    UIAlertView *alertView;
    if (madeAttempt)
        alertView = [[UIAlertView alloc] initWithTitle:@"Example app" message:@"The take was cancelled after selecting media" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    else
        alertView = [[UIAlertView alloc] initWithTitle:@"Example app" message:@"The take was cancelled without selecting media" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [self.imageView setImage:photo];
    self.sendImageButton.enabled=YES;
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
