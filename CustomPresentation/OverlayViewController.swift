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

class OverlayViewController: UIViewController {
  
  var contentContainerView: UIView = UIView()
  var countryNameLabel: UILabel = UILabel()
  var languageLabel: UILabel = UILabel()
  var populationLabel: UILabel = UILabel()
  var currencyLabel: UILabel = UILabel()
  var factLabel: UILabel = UILabel()
  var closeButton: UIButton = UIButton()
  
  var country: Country?
  
  init(country: Country) {
    super.init(nibName: nil, bundle: nil)
    
    self.country = country
    modalPresentationStyle = UIModalPresentationStyle.custom
    configureUIElements()
  }
  
  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    countryNameLabel.text = country!.countryName
    languageLabel.text = "Language: " + country!.language
    populationLabel.text = "Population: " + country!.population
    currencyLabel.text = "Currency: " + country!.currency
    factLabel.text = "Fact: \n" + country!.fact
  }
  
  func configureUIElements() {
    contentContainerView.translatesAutoresizingMaskIntoConstraints = false
    contentContainerView.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
    contentContainerView.layer.cornerRadius = 5.0
    view.addSubview(contentContainerView)
    
    // Set default values for font sizes
    // and constraints for a smaller screen.
    var titleFontSize: CGFloat = 24.0
    var labelFontSize: CGFloat = 10.0
    var horizontalSpacing: NSNumber = 10
    var containerHeight: NSNumber = 160
    var containerTopSpacing: NSNumber = 5
    var containerBottomSpacing: NSNumber = 40
    var itemSpacing: NSNumber = 5
    var maxSpacing: NSNumber = 5
    
    // If there is more screen space available,
    // then increase the values to use the space.
    if view.bounds.size.width > 568.0 {
      titleFontSize = 42.0
      labelFontSize = 18.0
      horizontalSpacing = 60
      containerHeight = 350
      containerTopSpacing = 20
      containerBottomSpacing = 60
      itemSpacing = 20
      maxSpacing = 200
    }
    
    // Use convience method to configure and add labels.
    addToViewAndApplyStylingAndFontSize(fontSize: titleFontSize, label: countryNameLabel)
    addToViewAndApplyStylingAndFontSize(fontSize: labelFontSize, label: languageLabel)
    addToViewAndApplyStylingAndFontSize(fontSize: labelFontSize, label: populationLabel)
    addToViewAndApplyStylingAndFontSize(fontSize: labelFontSize, label: currencyLabel)
    addToViewAndApplyStylingAndFontSize(fontSize: labelFontSize, label: factLabel)
    
    factLabel.numberOfLines = 0
    
    closeButton.setTitle("Close", for: UIControl.State.normal)
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.tintColor = UIColor.white
    closeButton.titleLabel!.font = UIFont.systemFont(ofSize: labelFontSize)
    closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)),
                          for: UIControl.Event.touchUpInside)
    
    contentContainerView.addSubview(closeButton)
    
    
    let views = [
      "contentContainerView": contentContainerView,
      "countryNameLabel": countryNameLabel,
      "languageLabel": languageLabel,
      "populationLabel": populationLabel,
      "currencyLabel": currencyLabel,
      "factLabel": factLabel,
      "closeButton": closeButton]
    
    view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-(spacing)-[contentContainerView]-(spacing)-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: ["spacing": horizontalSpacing],
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[countryNameLabel]-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[languageLabel]-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[populationLabel]-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[currencyLabel]-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-[closeButton]-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: nil,
        views: views))
    
    view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-(>=containerTopSpacing)-[contentContainerView(containerHeight)]" +
        "-(containerBottomSpacing)-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: ["containerHeight": containerHeight,
          "containerTopSpacing": containerTopSpacing,
          "containerBottomSpacing": containerBottomSpacing],
        views: views))
    
    contentContainerView.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-(itemSpacing)-[countryNameLabel]-(itemSpacing)-" +
          "[languageLabel]-(itemSpacing)-[populationLabel]-(itemSpacing)" +
        "-[currencyLabel]-(<=maxSpacing)-[closeButton]-(itemSpacing)-|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: ["itemSpacing": itemSpacing,
          "maxSpacing": maxSpacing],
        views: views))
    
    contentContainerView.addConstraint(
      NSLayoutConstraint(item: factLabel,
                         attribute: NSLayoutConstraint.Attribute.top,
                         relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: languageLabel,
        attribute: NSLayoutConstraint.Attribute.top,
        multiplier: 1.0,
        constant: 0))
    
    contentContainerView.addConstraint(
      NSLayoutConstraint(item: factLabel,
                         attribute: NSLayoutConstraint.Attribute.left,
                         relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: contentContainerView,
        attribute: NSLayoutConstraint.Attribute.centerX,
        multiplier: 1.0,
        constant: 0))
    
    contentContainerView.addConstraint(
      NSLayoutConstraint(item: factLabel,
                         attribute: NSLayoutConstraint.Attribute.trailing,
                         relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: contentContainerView,
        attribute: NSLayoutConstraint.Attribute.trailing,
        multiplier: 1.0,
        constant: 0))
    
  }
  
  func addToViewAndApplyStylingAndFontSize(fontSize: CGFloat,
    label: UILabel) {
      
      // Helper method to configure label and add to view.
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = UIColor.clear
    label.font = UIFont.boldSystemFont(ofSize: fontSize)
    label.textColor = UIColor.white
      
      contentContainerView.addSubview(label)
  }
  
  @objc func closeButtonPressed(_ sender: UIButton) {
    presentingViewController!.dismiss(animated: true,
      completion: nil)
  }
}
