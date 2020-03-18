//
//  LayoutWeatherTile.swift
//  ParisHappnWeather
//
//  Created by Clément Martin on 18/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import UIKit

protocol LayoutWeatherTileDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
    func numberOfColumn() -> Int
}

class LayoutWeatherTile: UICollectionViewLayout {

    weak var delegate: LayoutWeatherTileDelegate!

    fileprivate var numberOfColumns: Int {
        return (delegate?.numberOfColumn())!
    }
    
    fileprivate var cellPadding: CGFloat = 10

        fileprivate var cache = [UICollectionViewLayoutAttributes]()
        fileprivate var contentHeight: CGFloat = 10
        fileprivate var interitemSpace: CGFloat {
            return 5
        }
        
        fileprivate var width: CGFloat {
            guard let collectionView = collectionView else {
                return 0
            }
            _ = collectionView.contentInset
            return collectionView.bounds.width
        }
        
        fileprivate var sectionInsets: UIEdgeInsets {
            return .zero
        }
        
        fileprivate var itemsPerRow: CGFloat {
            return 2    }
        
     

        override var collectionViewContentSize: CGSize {
            return CGSize(width: width, height: contentHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }

        override func prepare() {
            // 1
            guard cache.isEmpty == true, let collectionView = collectionView else {
                return
            }
            // 2
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            // 3
            for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                // 4
                let photoHeight = delegate?.collectionView(
                collectionView,
                heightForPhotoAtIndexPath: indexPath) ?? 180
                let height = cellPadding * 2 + photoHeight
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : (column + 1)
            }
        }

        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
            var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
            // Loop through the cache and look for items in the rect
            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            return visibleLayoutAttributes
        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
        }
}
