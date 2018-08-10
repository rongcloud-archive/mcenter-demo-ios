//
//  RCMCDMeDetailsCell.m
//  RCMCenterDemo
//
//  Created by Jue on 2018/6/5.
//  Copyright © 2018年 Jue. All rights reserved.
//

#import "RCMCDMeDetailsCell.h"

@interface RCMCDMeDetailsCell ()

@property(nonatomic, strong) NSDictionary *cellSubViews;

@end

@implementation RCMCDMeDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.leftImageView = [[UIImageView alloc] init];
    self.leftImageView.layer.cornerRadius = 5.0f;
    self.leftImageView.layer.masksToBounds = YES;
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    
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
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftImageView(65)]"
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
    
    [self.contentView
     addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                     @"H:|-10-[_leftImageView(65)]-8-[_leftLabel]-10-|"
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
