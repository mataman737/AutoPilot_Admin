//
//  MyTabBarController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import UIKit
import NWWebSocket
import Disk
import Network

class MyTabBarController: UITabBarController {
    
    var socket: NWWebSocket?
    var lastUpdatedSocketConnection: Date = Date()
    
    static var orderProfitUpdate: OrderProfitUpdate?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    let coustmeTabBarView : UIView = {
        //  daclare coustmeTabBarView as view
        let view = UIView(frame: .zero)
        
        // to make the cornerRadius of coustmeTabBarView
        view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        // to make the shadow of coustmeTabBarView
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //hideTabBarBorder()
        //setupRoundedTabBar()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(refresh), name: NSNotification.Name("refresh"), object: nil)
        
        triggerTimer()
        
    }
    
    @objc func refresh() {
        API.sharedInstance.pingTradingServer { success, error in
            guard error == nil else {
                print(error!)
                return
            }
                        
            guard success else {
                print("error pinging trading server")
                return
            }
            
            self.setupSocket()
        }
    }
    
    func setupSocket() {
        DispatchQueue.main.async { [weak self] in
            if let socketURL = URL(string: "ws://ab1b9cff49db78aad.awsglobalaccelerator.com/wsadmin?account=s") {
                self?.socket = NWWebSocket(url: socketURL)
                self?.socket?.delegate = self
                self?.socket?.connect()
            }
        }
    }

    func checkIfDataIsRecent() {
        let currentTime = Date()

        // check if the difference between the current time and lastUpdatedSocketConnection is less than one second
        //print(currentTime.timeIntervalSince(lastUpdatedSocketConnection) < 15)
        if currentTime.timeIntervalSince(lastUpdatedSocketConnection) < 15 {
            //print("Data is recent enough 🐶🐶🐶")
            NotificationCenter.default.post(name: NSNotification.Name("showReconnectingFalse"), object: nil, userInfo: nil)
        } else {
            //print("Data is stale 😿😿😿")
            NotificationCenter.default.post(name: NSNotification.Name("showReconnecting"), object: nil, userInfo: nil)
        }
    }
    
    func triggerTimer() {
        // set up a timer to call updateData every second
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.checkIfDataIsRecent()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //coustmeTabBarView.frame = tabBar.frame
    }
    
    // THIS IS THE PROBLEM
    /*
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()

        // Adjust the safe area to the height of the bottom views.
        newSafeArea.bottom += coustmeTabBarView.bounds.size.height

        // Adjust the safe area insets of the
        //  embedded child view controller.
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    */
    
    func setupRoundedTabBar() {
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.2)
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width, height: 400), cornerRadius: (20)).cgPath //400
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0).cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
    }
    
    private func addcoustmeTabBarView() {
        coustmeTabBarView.frame = tabBar.frame
        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage(color: .black)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
}

extension MyTabBarController: WebSocketConnectionDelegate {
    func webSocketDidConnect(connection: WebSocketConnection) {
        // Respond to a WebSocket connection event
        print("did connect to ws")
        let lToken = try? Disk.retrieve("token", from: .applicationSupport, as: LToken.self)
        if let token = lToken?.token {
            connection.send(string: "Bearer \(token)")
        }
    }

        func webSocketDidDisconnect(connection: WebSocketConnection,
                                    closeCode: NWProtocolWebSocket.CloseCode, reason: Data?) {
            // Respond to a WebSocket disconnection event
            print("disconnected from ws")
            setupSocket()
        }

        func webSocketViabilityDidChange(connection: WebSocketConnection, isViable: Bool) {
            // Respond to a WebSocket connection viability change event
        }

    func webSocketDidAttemptBetterPathMigration(result: Result<WebSocketConnection, NWError>) {
            // Respond to when a WebSocket connection migrates to a better network path
            // (e.g. A device moves from a cellular connection to a Wi-Fi connection)
        }

        func webSocketDidReceiveError(connection: WebSocketConnection, error: NWError) {
            // Respond to a WebSocket error event
            print("got ws error")
            print(error)
        }

        func webSocketDidReceivePong(connection: WebSocketConnection) {
            // Respond to a WebSocket connection receiving a Pong from the peer
        }

        func webSocketDidReceiveMessage(connection: WebSocketConnection, string: String) {
            // Respond to a WebSocket connection receiving a `String` message
            // print("got message")
            
            guard let data = string.data(using: .utf8) else {
                print("couldn't convert string to data")
                return
            }
            
            do {
                let orderUpdate = try JSONDecoder().decode(OrderProfitUpdate.self, from: data)
                MyTabBarController.orderProfitUpdate = orderUpdate
                
                NotificationCenter.default.post(name: NSNotification.Name("orderUpdate"), object: nil, userInfo: ["orderUpdate": orderUpdate])
                lastUpdatedSocketConnection = Date()
                
                
            } catch {
                print("\(error) 👽👽👽 444")
            }
            
            do {
                let tickerUpdate = try JSONDecoder().decode(TickerPriceUpdate.self, from: data)
                
                NotificationCenter.default.post(name: NSNotification.Name("updatePrice"), object: nil, userInfo: ["tickerUpdate": tickerUpdate])
            } catch {
//                print("\(error) 👽👽👽 444")
            }
        }

        func webSocketDidReceiveMessage(connection: WebSocketConnection, data: Data) {
            // Respond to a WebSocket connection receiving a binary `Data` message
            print("got data")
        }
}

extension MyTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }

    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
            let selectedVC = selectedViewController else { return }

        guard let fromView = selectedVC.view,
            let toView = tabViewControllers[toIndex].view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
            fromIndex != toIndex else { return }


        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)

        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        // Disable interaction during animation
        view.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        // Slide the views by -offset
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
        }, completion: { finished in
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}

public extension UIImage {
      convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
      }
    }

public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
}

public func preciseRound(_ value: Double, precision: RoundingPrecision = .ones) -> Double {
    switch precision {
    case .ones:
        return round(value)
    case .tenths:
        return round(value * 10) / 10.0
    case .hundredths:
        return round(value * 100) / 100.0
    }
}
