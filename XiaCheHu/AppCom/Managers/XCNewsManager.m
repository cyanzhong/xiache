
//
//  XCNewsManager.m
//  XiaCheHu
//
//  Created by cyan on 15/4/23.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "XCNewsManager.h"
#import "JSONKit.h"
#import "AppComHeaders.h"
#import "XCNetworkManager.h"
#import "HTMLReader.h"
#import "NSString+Extension.h"

@implementation XCNewsManager

+ (instancetype)manager {
    DEF_SINGLETON(^{
        return [[self alloc] init];
    });
}

- (void)getLatest:(void (^)(XCNewsModel *))success {
    [[XCNetworkManager manager] get:kAPIURL success:^(NSString *response) {
        XCNewsModel *newsModel = [self parseNews:response];
        success(newsModel);
    } failure:^(NSString *errMsg) {
        
    }];
}

- (XCNewsModel *)parseNews:(NSString *)jsonString {
    NSDictionary *json = [jsonString objectFromJSONString];
    NSArray *stories = json[@"stories"];
    for (NSDictionary *item in stories) {
        XCNewsModel *model = [[XCNewsModel alloc] initWithJSON:item];
        if ([model.title containsString:@"瞎扯"]) {
            return model;
        }
    }
    return nil;
}

- (void)getContent:(XCNewsModel *)newsModel success:(void (^)(NSArray *contents))success {
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/3/news/%@", newsModel.newsId];
    [[XCNetworkManager manager] get:url success:^(NSString *response) {
        NSArray *list = [self parseContent:response];
        success(list);
    } failure:^(NSString *errMsg) {
        NSLog(@"err: %@", errMsg);
    }];
}

- (NSArray *)parseContent:(NSString *)jsonString {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSDictionary *json = [jsonString objectFromJSONString];
    HTMLDocument *doc = [HTMLDocument documentWithString:json[@"body"]];
    NSArray *questions = [doc nodesMatchingSelector:@"div[class='question']"];
    for (HTMLElement *node in questions) {
        HTMLElement *answerNode = [node firstNodeMatchingSelector:@"div[class='answer']"];
        XCContentModel *contentModel = [[XCContentModel alloc] init];
        contentModel.question = [[[node firstNodeMatchingSelector:@"h2[class='question-title']"] textContent] trim];
        contentModel.author = [[[answerNode firstNodeMatchingSelector:@"div[class='meta']"] textContent] trim];
        contentModel.avatarUrl = [answerNode firstNodeMatchingSelector:@"img[class='avatar']"].attributes[@"src"];
        contentModel.answer = [[[answerNode firstNodeMatchingSelector:@"div[class='content']"] textContent] trim];
        [list addObject:contentModel];
    }
    return list;
}

@end
