//
//  ListUIGuideHelper.swift
//  List Post
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import UIKit
protocol ListUIGuideHelper {
    func showLoading(completion: (() -> Void)?)
    func hideLoading(completion: (() -> Void)?)
    func scrollControll(scrollView: UIScrollView, completion: (() -> Void)?)
}
