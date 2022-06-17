//
//  DetailsViewController.m
//  Flixter
//
//  Created by Christina Li on 6/17/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.movieInfo[@"title"];
    self.synopsisLabel.text = self.movieInfo[@"overview"];
    
    NSString *posterURLString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:self.movieInfo[@"poster_path"]];
    self.frontImage.image = nil;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: posterURLString]];
    self.frontImage.image = [UIImage imageWithData: imageData];
    
    NSString *backdropURLString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:self.movieInfo[@"backdrop_path"]];
    NSLog(@"%@", backdropURLString);
    self.backdropImage.image = nil;
    NSData * backdropImageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: backdropURLString]];
    self.backdropImage.image = [UIImage imageWithData: backdropImageData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
