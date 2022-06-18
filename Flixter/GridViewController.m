//
//  GridViewController.m
//  Flixter
//
//  Created by Christina Li on 6/17/22.
//

#import "GridViewController.h"
#import "GridViewCell.h"

@interface GridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *movieArray;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=d1df56c0ce66b8c88c4d0cf53ca88ea0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
//            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
//                                           message:@"The internet connection appears to be offline."
//                                           preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//               handler:^(UIAlertAction * action) {}];
//
//            [alert addAction:defaultAction];
//            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            [self.activityIndicator stopAnimating];
            
            NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
            
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            strongSelf.movieArray = dataDictionary[@"results"];
            strongSelf.collectionView.dataSource = strongSelf;
            strongSelf.collectionView.delegate = strongSelf;
            
            [strongSelf.collectionView reloadData];
            
//            [strongSelf.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier]; // order?
//            strongSelf.tableView.rowHeight = 200;
        
            
        }
//        [self.refreshControl endRefreshing];
    }];
    [task resume];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridViewCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movieArray[indexPath.row];

    NSString *posterURLString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:movie[@"poster_path"]];
    cell.posterImage.image = nil;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: posterURLString]];
    cell.posterImage.image = [UIImage imageWithData: imageData];
    
    return cell;
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
