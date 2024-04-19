//
//  Triangle.swift
//  TKT
//
//  Created by Vakil on 19.04.2024.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 4, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX + 4, y: rect.minY / 2))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 2))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
