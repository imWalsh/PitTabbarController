//
//  PitTabbarController.swift
//  Walsh
//

import UIKit


final public class PitTabbarController: UITabBarController {
    
    private var itemWidth: CGFloat = 0
	
	private var buttons: [UIControl] = []
	private var previousItem: PitTabbarButton?
	
    
    private lazy var cycleView: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        v.bounds = CGRect(x: 0, y: 0, width: 52, height: 52)
        v.layer.cornerRadius = 26
        v.layer.masksToBounds = true
        v.layer.position = v.center
        v.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.3).cgColor
        v.layer.borderWidth = 0.5
        return v
    }()
    
    private lazy var pitView: PitView = {
        let v = PitView(effect: UIBlurEffect(style: .systemMaterialDark), count: viewControllers!.count)
        
        return v
    }()
    
	public override var viewControllers: [UIViewController]? {
		didSet {
			setup()
		}
	}
	
	/// method
	public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setup() {
        
        UITabBar.appearance().tintColor = .clear
        UITabBar.appearance().unselectedItemTintColor = .clear
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.hidesBottomBarWhenPushed = true
        
        tabBar.addSubview(pitView)
        tabBar.addSubview(cycleView)
        
        let x = screenWidth / CGFloat(viewControllers!.count) / 2
        self.cycleView.center = CGPoint(x: x, y: 5)
        
        addChildren()
		
		delegate = self
    }
    
    private func addChildren() {
        for (index, item) in viewControllers!.enumerated() {
            guard let title = item.tabBarItem.title else { return }
            guard let image = item.tabBarItem.image else { return }
            let tabbarBtn = createTabbarButton(title: title, image: image, index: index)
            tabBar.addSubview(tabbarBtn)
			self.buttons.append(tabbarBtn)
        }
        
        self.selectedIndex = 0
        self.buttons.first?.isSelected = true
    }
    
    private func createTabbarButton(title: String, image: UIImage, index: NSInteger) -> PitTabbarButton {
        itemWidth = screenWidth / CGFloat(viewControllers!.count)
        let item = PitTabbarButton(frame: CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: tabBarHeight - bottomSafeAreaHeight))
        item.tag = index
        item.text = title
        item.image = image
        item.addTarget(self, action: #selector(selectedChanged(sender:)), for: .touchUpInside)
        
        return item
    }
    
    @objc private func selectedChanged(sender: PitTabbarButton) {
		
		if previousItem != nil && previousItem == sender { return }
		
		sender.isSelected = true
		
		if let controller = viewControllers?[sender.tag] {
			let _ = delegate?.tabBarController?(self, shouldSelect: controller)
			selectedIndex = sender.tag
			delegate?.tabBarController?(self, didSelect: controller)
		}
		
		previousItem?.isSelected = false
		previousItem = sender
    }
    
}

extension PitTabbarController: UITabBarControllerDelegate {
    
	public func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view,
              let toView = viewController.view else {
            return false
        }

        if fromView != toView {
            UIView.transition(from: fromView,
                              to: toView,
                              duration: 0.3,
                              options: [.transitionCrossDissolve],
                              completion: nil)
        }

        return true
    }

	/// 动画
	public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let itemWidth = screenWidth / CGFloat(viewControllers!.count)

        let x = CGFloat(self.selectedIndex) * itemWidth + (itemWidth / 2)

        let ani = CABasicAnimation(keyPath: "position.x")
        ani.toValue = x
        ani.duration = 0.3
        ani.fillMode = .both
        ani.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        ani.isRemovedOnCompletion = false
        let current = self.cycleView.layer.presentation()?.value(forKeyPath: "position.x") ?? 0
        ani.fromValue = current
        self.cycleView.layer.add(ani, forKey: "center")

        self.pitView.updatePit(x: x)


        self.buttons.forEach({ $0.isSelected = false })
        self.buttons[selectedIndex].isSelected = true
    }
    
}

class PitView: UIVisualEffectView {
    
    private lazy var maskLayer = CAShapeLayer()
    
    private var itemCount = 0
    
    
    convenience init(effect: UIVisualEffect?, count: NSInteger) {
        self.init(effect: effect)
        self.itemCount = count
        self.setup()
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
		self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: tabBarHeight)
    }
    
    public func updatePit(x: CGFloat) {
        let ani = CABasicAnimation(keyPath: "path")
        //        ani.speed = 3
        ani.duration = 0.3
        ani.fillMode = .both
        ani.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        ani.isRemovedOnCompletion = false
        let current = self.maskLayer.presentation()?.value(forKeyPath: "path") ?? UIBezierPath().cgPath
        ani.fromValue = current
        ani.toValue = self.createPath(x: x).cgPath
        
        self.maskLayer.removeAllAnimations()
        self.maskLayer.add(ani, forKey: "path")
    }
    
    private func createPath(x: CGFloat) -> UIBezierPath {
		let h = frame.height
        let w = frame.width
        let f: CGFloat = 30 // pit
		let r: CGFloat = 8  // pit 高
        let halfW = x
        
        let path = UIBezierPath()
		
		path.lineCapStyle = CGLineCap.round //线条拐角
		path.lineJoinStyle = CGLineJoin.round //终点处理
        path.move(to: .zero)
        
        path.addLine(to: CGPoint(x: halfW-f-(r/2.0), y: 0))
        
        path.addQuadCurve(to: CGPoint(x: halfW-f, y: (r/2.0)), controlPoint: CGPoint(x: halfW-f, y: 0))
        
        path.addArc(withCenter: CGPoint(x: halfW, y: (r/2.0)), radius: f, startAngle: .pi, endAngle: 0, clockwise: false)
        
        path.addQuadCurve(to: CGPoint(x: halfW+f+(r/2.0), y: 0), controlPoint: CGPoint(x: halfW+f, y: 0))
        
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0.0, y: h))
        
		path.close()
		
        path.lineWidth = 1
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        let x = screenWidth / CGFloat(itemCount) / 2
        
        let path = self.createPath(x: x).cgPath
        
        self.maskLayer.frame = self.bounds
        self.maskLayer.fillRule = .evenOdd //  奇偶层显示规则
        self.maskLayer.path = path
        self.layer.mask = self.maskLayer
    }
}
