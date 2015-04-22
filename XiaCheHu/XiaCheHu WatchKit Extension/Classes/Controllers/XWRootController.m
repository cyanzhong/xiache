//
//  XWRootController.m
//  XiaCheHu WatchKit Extension
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "XWRootController.h"
#import "XCNewsManager.h"
#import "SDWebImageDownloader.h"

@interface XWNewsCell : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *questionLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *avatarImage;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *authorLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *answerLabel;

@end

@implementation XWNewsCell

@end

@interface XWRootController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation XWRootController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
    [self updateUI];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)updateUI {
    [[XCNewsManager manager] getLatest:^(XCNewsModel *newsModel) {
        [[XCNewsManager manager] getContent:newsModel success:^(NSArray *contents) {
            [self.table setNumberOfRows:contents.count withRowType:@"NewsCell"];
            for (int i=0; i<contents.count; ++i) {
                XCContentModel *model = contents[i];
                XWNewsCell *cell = [self.table rowControllerAtIndex:i];
                [cell.questionLabel setText:model.question];
                [cell.authorLabel setText:model.author];
                [cell.answerLabel setText:model.answer];
                // image
                SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                [downloader downloadImageWithURL:[NSURL URLWithString:model.avatarUrl] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    [cell.avatarImage setImage:image];
                }];
            }
        }];
    }];
}

@end



