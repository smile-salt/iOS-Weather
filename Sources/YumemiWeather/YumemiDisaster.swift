//
//  YumemiDisaster.swift
//  YumemiWeather
//
//  Created by 渡部 陽太 on 2020/04/19.
//

import Foundation

public protocol YumemiDisasterHandleDelegate: AnyObject {
    func handle(disaster: String)
}

public class YumemiDisaster {
    
    public weak var delegate: YumemiDisasterHandleDelegate?
    
    public init() {}
    
    public func fetchDisaster() {
        self.delegate?.handle(disaster: "只今、災害情報はありません。")
    }
    
}
