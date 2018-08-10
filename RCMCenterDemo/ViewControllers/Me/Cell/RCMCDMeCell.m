//
//  RCMCDMeCell.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/5.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDMeCell.h"

@interface RCMCDMeCell ()

@property(nonatomic, strong) NSDictionary *cellSubViews;

@end

@implementation RCMCDMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.leftImageView = [[UIImageView alloc] init];
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.font = [UIFont systemFontOfSize:17.f];
    self.leftLabel.textColor = [UIColor blackColor];
    self.leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.leftLabel];
    
    self.cellSubViews = NSDictionaryOfVariableBindings(_leftImageView, _leftLabel);
    
    [self setLayout];
}

- (void)setLayout {
    // add
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftImageView(18)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:self.cellSubViews]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftImageView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftLabel(21)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:self.cellSubViews]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_leftLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"H:|-10-[_leftImageView(18)]-8-[_leftLabel]-(>=10)-|"
                                      options:0
                                      metrics:nil
                                      views:self.cellSubViews]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
