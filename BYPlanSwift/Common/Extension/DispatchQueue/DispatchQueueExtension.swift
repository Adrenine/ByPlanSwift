//
//  DispatchQueueExtension.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/27.
//  Copyright © 2020 kystar. All rights reserved.
//

import Foundation

extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
