//
//  Extension.swift
//  TKT
//
//  Created by Kalandarov Vakil on 11.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
