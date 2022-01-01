//
//  State.swift
//  RawajTest
//
//  Created by A on 01/01/2022.
//

import Foundation
import RxSwift
import RxRelay

class State {
    var isLoading = BehaviorRelay<Bool>(value: false)
    var isProductTableViewHide = BehaviorRelay<Bool>(value: false)
}
