//
//  HomeVC.swift
//  TestDrawer
//
//  Created by Phat Pham on 10/10/20.
//

import UIKit
import Extensions

class HasDrawerNavigationController: UINavigationController {
    var onToggleDraw: (() -> Void)?
    @objc func onPressLeftBtn() {
        onToggleDraw?()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let leftBtn = UIBarButtonItem(title: "Show", style: .done, target: self, action: #selector(onPressLeftBtn))
        if visibleViewController is Screen1VC || visibleViewController is Screen2VC {
            self.visibleViewController?.navigationItem.leftBarButtonItem = leftBtn
        }
    }
    
    func moveToVC(withNumber number: Int) {
        switch number {
        case 0:
            self.setViewControllers([Screen1VC()], animated: false)
        case 1:
            self.setViewControllers([Screen2VC()], animated: false)
        default: break
        }
    }
}

class HomeVC: UIViewController {
    
    let drawer = UIView(backgroundColor: .lightGray)
    var drawerWidthAnchor: NSLayoutConstraint!
    
    var middleVCWidthAnchor: NSLayoutConstraint!
    
    let middleVC = HasDrawerNavigationController(rootViewController: Screen1VC())
    lazy var drawerWitdh = self.view.frame.width - 50
    
    var showDrawer = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.showDrawer {
                    self.drawerWidthAnchor.constant = self.drawerWitdh
                } else {
                    self.drawerWidthAnchor.constant = 0
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.with(backgroundColor: .systemPink)
        
        drawerWidthAnchor = drawer.widthAnchor.constraint(equalToConstant: 0)
        drawerWidthAnchor.isActive = true
        
        middleVC.onToggleDraw = onToggleDraw
        middleVCWidthAnchor = middleVC.view.anchor(.width(self.view.frame.width)).width
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        self.view.addSubview(stackView)
        stackView.anchor(
            .leading(self.view.leadingAnchor, constant: 0),
            .top(self.view.topAnchor, constant: 0),
            .bottom(self.view.bottomAnchor, constant: 0)
        )
        
        stackView.addArrangedSubview([
            drawer,
            middleVC.view
        ])
        
        
        drawer.vstack(
            UIButton(title: "VC1",titleColor: .white, target: self, action: #selector(onTapChangeVC(_:))).withSetUp { $0.tag = 0 },
            UIButton(title: "VC2",titleColor: .white, target: self, action: #selector(onTapChangeVC(_:))).withSetUp { $0.tag = 1 },
            UIView()
        ).with(padding: .allSides(10))
    }
    
    @objc func onTapChangeVC(_ btn: UIButton) {
        middleVC.moveToVC(withNumber: btn.tag)
        showDrawer = false
    }
    
    func onToggleDraw() {
        showDrawer.toggle()
    }
}

