//
//  SelectionObject.swift
//  CustomPresentation
//
//  Created by santosh on 27/12/2019.
//  Copyright © 2019 Fresh App Factory. All rights reserved.
//

import UIKit

class SelectionObject {
  
  var originalCellPosition: CGRect
  var country: Country
  var selectedCellIndexPath: IndexPath
  
  init(country: Country, selectedCellIndexPath: IndexPath, originalCellPosition: CGRect) {
    self.country = country
    self.selectedCellIndexPath = selectedCellIndexPath
    self.originalCellPosition = originalCellPosition
  }
  
  
}
