//
//  ReceiveViewController.m
//  ParseStarterProject
//
//  Created by MBP on 10/21/15.
//
//

#import "ReceiveViewController.h"
#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>
@interface ReceiveViewController ()

@end

@implementation ReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
-(void)setReceivedImage:(NSString*)oId{
    self.title = @"Start Receiving";
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CollectionImages"];
    [query whereKey:@"objectId" equalTo:oId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
             if(objects.count>0)
             {
                 PFObject * object = (PFObject*)objects[0];
                 PFFile * file = [(PFFile*)object valueForKey:@"image"];
                 NSURL * nsurl = [NSURL URLWithString:file.url];
                  NSURLRequest * req= [NSURLRequest requestWithURL:nsurl];
                  __weak  ReceiveViewController * __self=self;
                  [self.imageView setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                  //
                  __self.imageView.image = image;
                      self.title=@"Done";
                  
                  } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                  //
                  [[[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                  }];
                 
             }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [[[UIAlertView alloc] initWithTitle:nil message:[error userInfo] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }
    }];
    
}
@end
