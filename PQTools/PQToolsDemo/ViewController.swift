//
//  ViewController.swift
//  PQToolsDemo
//
//  Created by 盘国权 on 2019/4/2.
//  Copyright © 2019 pgq. All rights reserved.
//

import UIKit
import PQTools

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PQPushType.allCases.forEach { type in
    
//            let str = .reduce("", { $0 + String($1) + "1" })
//            let baseStr = str.pq.base64!
//            print(str, baseStr)
            
            let data = type.rawValue.data(using: .utf8)
            
            let base64Data = Data(base64Encoded: data!)
            var deStr = String(data: base64Data!, encoding: .utf8)!
            deStr.removeAll(where: { $0 == "1" })
            print("解码", deStr)
        }
        
        let btn = PQButton(frame: CGRect(x: 10, y: 50, width: 100, height: 44))
        btn.setTitle("选中了", for: .selected)
        let image = UIImage.pq_drawCircle(CGSize(width: 40, height: 40), color: .green)
        btn.setImage(image, for: .selected)
        btn.buttonClick { (button) in
            button.isSelected =  !button.isSelected
        }
        btn.backgroundColor = .systemOrange
        view.addSubview(btn)
        
        
    }
    
    var index: Int = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function, #line)
//        if index >= PQPushType.allCases.count {
//            index = 0;
//        }
//
//        PQHUD.push(PQPushType.allCases[index])
//        index += 1
    }


}

