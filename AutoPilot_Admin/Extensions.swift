//
//  Extensions.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation
import UIKit

extension CGFloat {
    
    static func iphone5() -> CGFloat {
        return 568
    }
    
    static func iphone78() -> CGFloat {
        return 667 // x 375
    }
    
    static func iphone78Plus() -> CGFloat {
        return 736 // x 414
    }
    
    static func iphoneX() -> CGFloat {  // Same as iPhone 12 Mini
        return 812 // x 375
    }
    
    static func iphone11() -> CGFloat {
        return 896 // x 414
    }
    
    //iPhone 12
    
    static func iphone12AndPro() -> CGFloat {
        return 844 // x 390
    }
    
    static func iphone12ProMax() -> CGFloat {
        return 926 // x 428
    }
    
    static func iphone12Mini() -> CGFloat {
        return 812 // x 375
    }
    
    static func createAspectRatio(value: CGFloat) -> CGFloat {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let centerYAspect: CGFloat = value/375 //428
        let centerYOffset = screenWidth * centerYAspect
        return centerYOffset
    }
    
}

extension UIFont {
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    //NEXA
    
    static func nexaBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "NexaBold", size: size)
    }
        
    //SOFIA
    
    static func sofiaProRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SofiaPro", size: size)
        //return customFont(name: "SofiaProLight", size: size)
        //return customFont(name: "SofiaPro-Bold", size: size)
    }
    
    static func sofiaProLight(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SofiaProLight", size: size)
    }
    
    static func sofiaProBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SofiaPro-Bold", size: size)
    }
    
    static func sofiaProMedium(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SofiaPro-Medium", size: size)
    }
    
    static func sofiaProSemiBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "SofiaPro-SemiBold", size: size)
    }
    
}

extension UIView {
    func applyShadow(shadowOpacity: Float, shadowSize: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = shadowSize
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func animateAndFade(timeInt: TimeInterval, delay: TimeInterval, xValue: CGFloat, yValue: CGFloat, aValue: CGFloat) {
        UIView.animate(withDuration: timeInt, delay: delay, options: [], animations: {
            self.transform = CGAffineTransform(translationX: xValue, y: yValue)
            self.alpha = aValue
        }) { (success) in
            //
        }
    }
    
    func successImpactGenerator() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func lightImpactGenerator() {
      let impactGenerator = UIImpactFeedbackGenerator(style: .light)
      impactGenerator.prepare()
      impactGenerator.impactOccurred()
    }
    
    func heavyImpactGenerator() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
      impactGenerator.prepare()
      impactGenerator.impactOccurred()
    }
    
    func jiggleWiggle(arg: Bool, completion: (Bool) -> ()) {
        UIView.animate(withDuration: 0.15, animations: {
          self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { (success) in
          UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
          }, completion: { (success) in
            UIView.animate(withDuration: 0.15, animations: {
              self.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
            }, completion: { (success) in
              UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
              }, completion: { (success) in
                print("animation done 💩💩💩")
                //completion(arg)
              })
            })
          })
        }
        completion(arg)
    }
    
    func badWiggle() {
        UIView.animate(withDuration: 0.08, animations: {
          self.transform = CGAffineTransform(translationX: 20, y: 0)
        }) { (success) in
          UIView.animate(withDuration: 0.08, animations: {
            self.transform = CGAffineTransform(translationX: -20, y: 0)
          }, completion: { (success) in
            UIView.animate(withDuration: 0.08, animations: {
              self.transform = CGAffineTransform(translationX: 10, y: 0)
            }, completion: { (success) in
              UIView.animate(withDuration: 0.08, animations: {
                self.transform = CGAffineTransform(translationX: -10, y: 0)
              }, completion: { (success) in
                UIView.animate(withDuration: 0.08, animations: {
                  self.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: { (success) in
                  print("done")
                })
              })
            })
          })
        }
    }
    
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat, shadowCornerRadius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = shadowCornerRadius
    }
    
    
}

extension UIViewController {
    func lightImpactGenerator() {
      let impactGenerator = UIImpactFeedbackGenerator(style: .light)
      impactGenerator.prepare()
      impactGenerator.impactOccurred()
    }
    
    func errorImpactGenerator() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func heavyImpactGenerator() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
      impactGenerator.prepare()
      impactGenerator.impactOccurred()
    }
    
    func successImpactGenerator() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func hideTabBar(tabDuration: Double) {
        let myTB = MyTabBarController()
        var viewFrame = self.tabBarController?.tabBar.frame
        let viewHeight = self.tabBarController?.tabBar.frame
        viewFrame?.origin.y = self.view.frame.size.height + 250 //250 (viewHeight!.size.height)
        UIView.animate(withDuration: tabDuration, animations: {
            self.tabBarController?.tabBar.frame = viewFrame!
        })
    }
    
    func showTabBar() {
        var viewFrame = self.tabBarController?.tabBar.frame
        let viewHeight = self.tabBarController?.tabBar.frame
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
                        
        switch screenHeight {
        case .iphone5() :
            viewFrame?.origin.y = 729
        case .iphone78() :
            viewFrame?.origin.y = 618
        case .iphone78Plus() :
            viewFrame?.origin.y = 687
        case .iphone11() :
            viewFrame?.origin.y = 815
        
        case .iphone12AndPro() :
            viewFrame?.origin.y = 761
            
        case .iphone12ProMax() :
            viewFrame?.origin.y = 844
            
        default:
            viewFrame?.origin.y = 729
        }
        
        //viewFrame?.origin.y = 815//729.0//self.view.frame.size.height - (viewHeight!.size.height)
        
        //print("\(viewFrame?.origin.y) - 🤟🤟🤟")
        
        UIView.animate(withDuration: 0.35, animations: {
            self.tabBarController?.tabBar.frame = viewFrame!
        })
    }

    func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.3) {
        if animated {
            if let frame = self.tabBarController?.tabBar.frame {
                let factor: CGFloat = hidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                UIView.animate(withDuration: duration, animations: {
                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                })
                return
            }
        }
        self.tabBarController?.tabBar.isHidden = hidden
    }
    
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UILabel {
    
    func setupLineHeight(myText: String, myLineSpacing: CGFloat) {
        
        let attributedString = NSMutableAttributedString(string: myText)

       // *** Create instance of `NSMutableParagraphStyle`
       let paragraphStyle = NSMutableParagraphStyle()

       // *** set LineSpacing property in points ***
       paragraphStyle.lineSpacing = myLineSpacing // Whatever line spacing you want in points

       // *** Apply attribute to string ***
       attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

       // *** Set Attributed String to your label ***
       self.attributedText = attributedString
        
    }
    
}

extension String {
 
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
 
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
                
        return self[indexPosition]
    }
}

extension UIColor {
    
    static let swBlue = UIColor(red: 95/255, green: 201/255, blue: 207/255, alpha: 1.0)
    
    //DARK MODE COLORS
    static let darkModeBackground = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
    static let darkModeCardBackground = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0)
    static let darkModeTextColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    static let nvuBlueOne = UIColor(red: 77/255, green: 110/255, blue: 142/255, alpha: 1.0)
    
    static let newRed = UIColor(red: 239/255, green: 93/255, blue: 111/255, alpha: 1.0)
    static let newGreen = UIColor(red: 18/255, green: 183/255, blue: 106/255, alpha: 1.0)
    static let newBlack = UIColor(red: 7/255, green: 11/255, blue: 18/255, alpha: 1.0)
    static let themeOrange = UIColor(red: 233/255, green: 122/255, blue: 47/255, alpha: 1.0)
    static let mainThemeColor = UIColor(red: 98/255, green: 186/255, blue: 77/255, alpha: 1.0)
    static let mainBackgroundColor = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    //static let mainBackgroundColor = UIColor(red: 12/255, green: 12/255, blue: 14/255, alpha: 1.0)
    static let themePurple = UIColor(red: 109/255, green: 69/255, blue: 255/255, alpha: 1.0)
    static let themeBlack = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    static let themeGray = UIColor(red: 35/255, green: 34/255, blue: 39/255, alpha: 1.0)
    static let themeBackground = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    static let liveGreen = UIColor(red: 0/255, green: 255/255, blue: 133/255, alpha: 1.0)
    static let themeInActive = UIColor(red: 183/255, green: 191/255, blue: 199/255, alpha: 1.0)
    
    //Status colors
    
    static let invisileStatus = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)
    static let onlineStatus = UIColor(red: 65/255, green: 220/255, blue: 61/255, alpha: 1.0)
    static let busyStatus = UIColor(red: 220/255, green: 61/255, blue: 61/255, alpha: 1.0)
    static let awayStatus = UIColor(red: 220/255, green: 185/255, blue: 61/255, alpha: 1.0)
    static let unicornStatus = UIColor(red: 220/255, green: 61/255, blue: 204/255, alpha: 1.0)
    static let manBearPigStatus = UIColor(red: 61/255, green: 182/255, blue: 220/255, alpha: 1.0)
    
    //Use this
    static var themeColor: UIColor {
//        do {
//            let myClass = try Disk.retrieve("myClass", from: .caches, as: Class.self)
//            guard let colorString = myClass.themeColor, let colorInt = Int(colorString) else { return UIColor(red: 255/255, green: 126/255, blue: 124/255, alpha: 1.0) }
//
//            return UIColor(rgb: colorInt)
//        } catch {
//            print(error)
//
//            return UIColor(red: 255/255, green: 126/255, blue: 124/255, alpha: 1.0)
//        }
        
        return UIColor(red: 6/255, green: 174/255, blue: 255/255, alpha: 1.0)//(red: 190/255, green: 203/255, blue: 255/255, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    /// Regular string.
    var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
}

extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

final class AnimatedLabel: UILabel {
    typealias OptionalCallback = (() -> Void)
    typealias OptionalFormatBlock = (() -> String)

    var completion: OptionalCallback?
    var animationDuration: AnimationDuration = .brisk
    var decimalPoints: DecimalPoints = .zero
    var countingMethod: CountingMethod = .linear
    var customFormatBlock: OptionalFormatBlock?

    private var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + (update(t: Float(progress / totalTime)) * (destinationValue - startingValue))
    }

    private var rate: Float = 0
    private var startingValue: Float = 0
    private var destinationValue: Float = 0
    private var progress: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var totalTime: TimeInterval = 0
    private var easingRate: Float = 0
    private var timer: CADisplayLink?

    func count(from: Float, to: Float, duration: AnimationDuration = .strolling) {
        startingValue = from
        destinationValue = to
        timer?.invalidate()
        timer = nil

        if duration.value == 0.0 {
            setTextValue(value: to)
            completion?()
            return
        }

        easingRate = 3.0
        progress = 0.0
        totalTime = duration.value
        lastUpdate = Date.timeIntervalSinceReferenceDate
        rate = 3.0

        addDisplayLink()
    }

    func countFromCurrent(to: Float, duration: AnimationDuration = .strolling) {
        count(from: currentValue, to: to, duration: duration)
    }

    func countFromZero(to: Float, duration: AnimationDuration = .strolling) {
        count(from: 0, to: to, duration: duration)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        progress = totalTime
        completion?()
    }

    private func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(self.updateValue(timer:)))
        timer?.add(to: .main, forMode: .default)
        timer?.add(to: .main, forMode: .tracking)
    }

    private func update(t: Float) -> Float {
        var t = t

        switch countingMethod {
        case .linear:
            return t
        case .easeIn:
            return powf(t, rate)
        case .easeInOut:
            var sign: Float = 1
            if Int(rate) % 2 == 0 { sign = -1 }
            t *= 2
            return t < 1 ? 0.5 * powf(t, rate) : (sign*0.5) * (powf(t-2, rate) + sign*2)
        case .easeOut:
            return 1.0-powf((1.0-t), rate);
        }
    }

    @objc private func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now

        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }

        setTextValue(value: currentValue)
        if progress == totalTime { completion?() }
    }

    private func setTextValue(value: Float) {
        text = String(format: customFormatBlock?() ?? decimalPoints.format, value)
    }

}

enum DecimalPoints {
    case zero, one, two, ridiculous

    var format: String {
        switch self {
        case .zero: return "%.0f/5"
        case .one: return "%.0f%%"
        case .two: return "%.2f"
        case .ridiculous: return "%f"
        }
    }
}

enum CountingMethod {
    case easeInOut, easeIn, easeOut, linear
}

enum AnimationDuration {
    case laborious, plodding, strolling, brisk, noAnimation

    var value: TimeInterval {
        switch self {
        case .laborious: return 4.0
        case .plodding: return 15.0
        case .strolling: return 8.0
        case .brisk: return 2.0
        case .noAnimation: return 0.0
        }
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
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

//
//  SampleNotificationDelegate.swift
//  NotificationSample
//
//  Created by Lucas Goes Valle on 14/03/18.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI

class SampleNotificationDelegate: NSObject , UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        completionHandler()
    }
}

//
//  NotificationService.swift
//  Service
//
//  Created by Lucas Goes Valle on 14/03/18.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            var urlString:String? = nil
            if let urlImageString = request.content.userInfo["imageUrl"] as? String {
                urlString = urlImageString
            }
            
            if urlString != nil, let fileUrl = URL(string: urlString!) {
                print("fileUrl: \(fileUrl)")
                
                guard let imageData = NSData(contentsOf: fileUrl) else {
                    contentHandler(bestAttemptContent)
                    return
                }
                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "image.jpg", data: imageData, options: nil) else {
                    print("error in UNNotificationAttachment.saveImageToDisk()")
                    contentHandler(bestAttemptContent)
                    return
                }
                
                bestAttemptContent.attachments = [ attachment ]
            }
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

@available(iOSApplicationExtension 10.0, *)
extension UNNotificationAttachment {
    
    static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let folderName = ProcessInfo.processInfo.globallyUniqueString
        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
            try data.write(to: fileURL!, options: [])
            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
            return attachment
        } catch let error {
            print("error \(error)")
        }
        
        return nil
    }
}

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

//////////////////////

extension Date {
    
    func setDateShortHand() -> String {
        let formatterTwo = DateFormatter()
        formatterTwo.timeZone = NSTimeZone.local
        formatterTwo.dateFormat = "M/d"
        return formatterTwo.string(from: self)
    }
    
    func setDayString() -> String {
        let formatterTwo = DateFormatter()
        formatterTwo.timeZone = NSTimeZone.local
        formatterTwo.dateFormat = "EEEE"
        return formatterTwo.string(from: self)
    }
    
    /*
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
    
    static func today() -> Date {
        return Date()
    }
     */
    
    func getWeekDaysInEnglish() -> [String] {
      var calendar = Calendar(identifier: .gregorian)
      calendar.locale = Locale(identifier: "en_US_POSIX")
      return calendar.weekdaySymbols
    }

    enum Weekday: String {
      case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }

    enum SearchDirection {
      case next
      case previous

      var calendarSearchDirection: Calendar.SearchDirection {
        switch self {
        case .next:
          return .forward
        case .previous:
          return .backward
        }
      }
    }
    
    static func today() -> Date {
        return Date()
    }

    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
      return get(.next,
                 weekday,
                 considerToday: considerToday)
    }

    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
      return get(.previous,
                 weekday,
                 considerToday: considerToday)
    }

    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {

      let dayName = weekDay.rawValue

      let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

      assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

      let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

      let calendar = Calendar(identifier: .gregorian)

      if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
        return self
      }

      var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
      nextDateComponent.weekday = searchWeekdayIndex

      let date = calendar.nextDate(after: self,
                                   matching: nextDateComponent,
                                   matchingPolicy: .nextTime,
                                   direction: direction.calendarSearchDirection)

      return date!
    }

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    
    static func getDatesPast(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
                
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
                arrDates.append(dateString)
        }
        print(arrDates)
        return arrDates
    }
    
    static func getDatesFuture(forFutureNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move forward in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: 1, to: date)!
                
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
                arrDates.append(dateString)
        }
        print(arrDates)
        return arrDates
    }
    
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    func convert(from initTimeZone: TimeZone, to targetTimeZone: TimeZone) -> Date {
        let delta = TimeInterval(targetTimeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}
