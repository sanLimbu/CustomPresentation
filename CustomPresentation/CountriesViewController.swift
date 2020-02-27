/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class CountriesViewController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var collectionViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet var collectionViewTrailingConstraint: NSLayoutConstraint!

  var countries = Country.countries()
  let simpleTransitioningDelegate = SimpleTransitioningDelegate()

  override func viewDidLoad() {
    super.viewDidLoad()

    imageView.image = UIImage(named: "BackgroundImage")

    let flowLayout = CollectionViewLayout(
      traitCollection: traitCollection)

    flowLayout.invalidateLayout()
    collectionView.setCollectionViewLayout(flowLayout,
      animated: false)

    collectionView.reloadData()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

    if collectionView.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone {

      // Increase leading and trailing constraints to center cells
      var padding: CGFloat = 0.0
      let viewWidth = view.frame.size.width

      if viewWidth > 320.0 {
        padding = (viewWidth - 320.0) / 2.0
      }

      collectionViewLeadingConstraint.constant = padding
      collectionViewTrailingConstraint.constant = padding
    }
  }

  func showSimpleOverlayForIndexPath(indexPath: IndexPath) {
    let country = countries[indexPath.row] as! Country

    transitioningDelegate = simpleTransitioningDelegate

    let overlay = OverlayViewController(country: country)
    overlay.transitioningDelegate = simpleTransitioningDelegate

    present(overlay, animated: true, completion: nil)
  }

  func hideImage(hidden: Bool, indexPath: IndexPath) {
    if indexPath.row < self.countries.count {
      collectionView.reloadItems(at: [indexPath as IndexPath])
    }
  }

  func indexPathsForAllItems() -> [IndexPath] { // NSMutableArray {
    let count = countries.count
    var indexPaths = [IndexPath]()
    
    for index in 0..<count {
      indexPaths.append(IndexPath(row: index, section: 0))
    }
    
    return indexPaths
  }

  func changeCellSpacingForPresentation(presentation: Bool) {
    if presentation {
      let indexPaths = indexPathsForAllItems()
      countries = NSArray()
      collectionView.deleteItems(at: indexPaths)
    } else {
      countries = Country.countries()
      let indexPaths = indexPathsForAllItems()
      collectionView.insertItems(at: indexPaths)
    }
  }

  func frameForCellAtIndexPath(indexPath: IndexPath) ->
  CGRect {
    let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
    return cell.frame
  }
}

extension CountriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CollectionViewCell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath)
        as! CollectionViewCell
    
    let country = countries[indexPath.row] as! Country
    let image: UIImage = UIImage(named: country.imageName)!
    cell.imageView.image = image
    cell.imageView.layer.cornerRadius = 4.0
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

extension CountriesViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showSimpleOverlayForIndexPath(indexPath: indexPath)
  }
}
