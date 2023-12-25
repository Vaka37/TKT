//
//  Extension.swift
//  TKT
//
//  Created by Kalandarov Vakil on 11.02.2023.
//

import Foundation
import SwiftUI

extension String {
    func localized() -> String {
        return NSLocalizedString(self,comment: "")
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
