//
//  TestViewController.swift
//  MultipleCellTableView
//
//  Created by Ewen on 2021/10/15.
//

import UIKit

class TestViewController: UIViewController {
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text          = "I AM A TEST PAGE."
        label.font          = .systemFont(ofSize: 36, weight: .bold)
        label.textColor     = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(testLabel)
        testLabel.frame = view.bounds
    }
}
