//
//  MovieViewController.m
//  Flixter
//
//  Created by Christina Li on 6/15/22.
//

#import "MovieViewController.h"
#import "myCustomCell.h"

@interface MovieViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *movieArray;

@end

@implementation MovieViewController

NSString *CellIdentifier = @"com.codepath.myCustomCell";


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
        }
        else {
            typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
            
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            strongSelf.movieArray = dataDictionary[@"results"];
            strongSelf.tableView.dataSource = strongSelf;
            strongSelf.tableView.delegate = strongSelf;
            
            [strongSelf.tableView reloadData];
            
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier]; // order?
            
        }
    }];
    [task resume];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.textLabel.text = self.movieArray[indexPath.row][@"title"];
//    return cell;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    myCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCustomCell" forIndexPath:indexPath];

    NSDictionary *movie = self.movieArray[indexPath.row];
    cell.titleLabel.text = movie[@"title"];

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
