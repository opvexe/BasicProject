//
//  BSBaseCollectionViewCell.h
//  BellService
//
//  Created by snowlu on 2018/10/4.
//  Copyright © 2018年 BellService. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSBaseCollectionCellProtocol.h"
@interface BSBaseCollectionViewCell : UICollectionViewCell<BaseCollectionCellProtocol>

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath;

@end
