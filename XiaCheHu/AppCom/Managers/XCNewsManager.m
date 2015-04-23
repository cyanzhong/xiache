
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

- (void)getIndexes:(void (^)(XCNewsModel *))success {
    [[XCNetworkManager manager] get:kAPIURL success:^(NSString *response) {
        XCNewsModel *newsModel = [self parseIndexes:response];
        success(newsModel);
    } failure:^(NSString *errMsg) {
        
    }];
}

- (XCNewsModel *)parseIndexes:(NSString *)jsonString {
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

- (void)getQuestions:(XCNewsModel *)newsModel success:(void (^)(NSArray *contents))success {
    NSString *url = [NSString stringWithFormat:@"%@%@", kNewsURL, newsModel.newsId];
    [[XCNetworkManager manager] get:url success:^(NSString *response) {
        NSArray *list = [self parseQuestions:response];
        success(list);
    } failure:^(NSString *errMsg) {
        NSLog(@"err: %@", errMsg);
    }];
}

- (NSArray *)parseQuestions:(NSString *)jsonString {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSDictionary *json = [jsonString objectFromJSONString];
    HTMLDocument *doc = [HTMLDocument documentWithString:json[@"body"]];
    NSArray *questions = [doc nodesMatchingSelector:@"div[class='question']"];
    for (HTMLElement *node in questions) {
        NSArray *answers = [node nodesMatchingSelector:@"div[class='answer']"];
        for (HTMLElement *answer in answers) {
            XCQuestionModel *questionModel = [[XCQuestionModel alloc] init];
            questionModel.question_title = [[[node firstNodeMatchingSelector:@"h2[class='question-title']"] textContent] trim];
            questionModel.author = [[[answer firstNodeMatchingSelector:@"div[class='meta']"] textContent] trim];
            questionModel.avatar = [answer firstNodeMatchingSelector:@"img[class='avatar']"].attributes[@"src"];
            questionModel.content = [[[answer firstNodeMatchingSelector:@"div[class='content']"] textContent] trim];
            [list addObject:questionModel];
        }
    }
    return list;
}

@end
