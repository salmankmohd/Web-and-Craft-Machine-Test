//
//  Helper Class.swift
//  Machine Test
//
//  Created by salman on 5/11/22.
//

import UIKit
//import FirebaseAnalytics

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}

extension UIViewController{
    
    func SlideInAniamtion(speed:Float){
//        let transition: CATransition = CATransition()
//        transition.duration = 0.1
        self.view.window?.layer.speed = speed // or 0.1 to slow motion // `1` is defaul
//
//        self.view.window!.layer.add(transition, forKey: nil)
    }
    
}
struct ButtonClass {
     func buttonTitleSetup(regularText:String,boldText:String,button:UIButton){
        let test1Attributes:[NSAttributedString.Key: Any] = [.font : UIFont(name: "Poppins-Regular", size: 16)!]
        let test2Attributes:[NSAttributedString.Key: Any] = [.font : UIFont(name: "Poppins-Bold", size: 16)!]

        let test1 = NSAttributedString(string: regularText, attributes:test1Attributes)
        let test2 = NSAttributedString(string: boldText, attributes:test2Attributes)
        let text = NSMutableAttributedString()

        text.append(test1)
        text.append(test2)
        button.setAttributedTitle(text, for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 66/255, blue: 70/255, alpha: 1.0), for: .normal)
        }

}

struct fontChange{
    func fontUpdate(regularText:String,lightText:String)->NSMutableAttributedString{
        let test1Attributes:[NSAttributedString.Key: Any] = [.font : UIFont(name: "Poppins-Regular", size: 16)!]
        let test2Attributes:[NSAttributedString.Key: Any] = [.font : UIFont(name: "Poppins-Regular", size: 12)!]

        let test1 = NSAttributedString(string: regularText, attributes:test1Attributes)
        let test2 = NSAttributedString(string: lightText, attributes:test2Attributes)
        let text = NSMutableAttributedString()

        text.append(test1)
        text.append(test2)
        return text
    }
}
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
class MyTextField: UITextField {

    var backspaceCalled: (()->())?
      override func deleteBackward() {
        super.deleteBackward()
            backspaceCalled?()
        
      }
//    weak var myDelegate: MyTextFieldDelegate?
//
//    override func deleteBackward() {
//        super.deleteBackward()
//        myDelegate?.textFieldDidDelete()
//    }

}
class TableViewButton: UIButton {

    
    var myRow: Int = 0
    var mySection: Int = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
func getFormattedDate(strDate: String , currentFomat:String, expectedFromat: String,locale:String = "en") -> String{
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = currentFomat

    let date : Date = dateFormatterGet.date(from: strDate) ?? Date()

    dateFormatterGet.dateFormat = expectedFromat
    dateFormatterGet.locale = Locale(identifier: locale)
    return dateFormatterGet.string(from: date)
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
      //  dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
       // dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
extension String {

    func epoch(dateFormat: String = "yyyy-MM-dd", timeZone: String? = nil,startDate:Date) -> TimeInterval? {
    // building the formatter
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    if let timeZone = timeZone { formatter.timeZone = TimeZone(identifier: timeZone) }

    // extracting the epoch
    let date = formatter.date(from: self)
    return date?.timeIntervalSince(startDate)
  }

}

extension Array where Element: Equatable {

 // Remove first collection element that is equal to the given `object`:
 mutating func remove(object: Element) {
     guard let index = firstIndex(of: object) else {return}
     remove(at: index)
 }

}
extension String {
    
    func numberOfLines() -> Int {
        return self.numberOfOccurrencesOf(string: "\n") + 1
    }

    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}
extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension UINavigationController {

    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
