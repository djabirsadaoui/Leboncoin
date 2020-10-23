//
//  Box.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import Foundation

class Box<T> {
typealias Listener = (T) -> Void
var listener: Listener?

func bind(_ listener: Listener?) {
    self.listener = listener
}

func bindAndFire(listener: Listener?) {
    self.listener = listener
    listener?(value)
}

var value: T {
    didSet {
        listener?(value)
    }
}

init(_ value: T) {
    self.value = value
}}
