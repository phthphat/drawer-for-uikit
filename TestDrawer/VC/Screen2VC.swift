//
//  Screen2VC.swift
//  TestDrawer
//
//  Created by Phat Pham on 10/10/20.
//

import UIKit

class Screen2VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.with(backgroundColor: .green)
        
        let btn = UIButton(title: "Push", titleColor: .orange, target: self, action: #selector(onTapPush))
        self.view.addSubview(btn)
        btn.centerSuperview()
    }
        
    @objc func onTapPush() {
        self.navigationController?.pushViewController(DestinationVC(), animated: true)
    }
}
