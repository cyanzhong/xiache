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


@property (weak, nonatomic) IBOutlet WKInterfaceGroup *titleGroup;
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
    
    [[XCNewsManager manager] getIndexes:^(XCNewsModel *newsModel) {
        [[XCNewsManager manager] getQuestions:newsModel success:^(NSArray *questions) {
            [self.table setNumberOfRows:questions.count withRowType:@"NewsCell"];
            
            NSString *prevTitle = @"";
            
            for (int i=0; i<questions.count; ++i) {
                XCQuestionModel *model = questions[i];
                XWNewsCell *cell = [self.table rowControllerAtIndex:i];
                [cell.questionLabel setText:model.question_title];
                [cell.authorLabel setText:model.author];
                [cell.answerLabel setText:model.content];
                [cell.titleGroup setHidden:[prevTitle isEqualToString:model.question_title]];
                prevTitle = model.question_title;
                // image
                SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                [downloader downloadImageWithURL:[NSURL URLWithString:model.avatar] options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    [cell.avatarImage setImage:image];
                }];
            }
        }];
    }];
}

@end



