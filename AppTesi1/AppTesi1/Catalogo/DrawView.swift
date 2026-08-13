//
//  DrawView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 15/03/23.
//

import SwiftUI
import UIKit

struct DrawView: View {
    @StateObject var canvasView = CanvasUIView()

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    let image = canvasView.capture()
                    let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                }, label:{
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                })
            }
            CanvasView(canvasView: canvasView).frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                ForEach([Color.green, .blue, .red, .yellow, .black, .purple, .white], id: \.self){ color
                    in
                    colorButton(color: color)
                }

                Button(action: {
                    self.canvasView.undo()
                }, label: {
                    Image(systemName: "arrow.turn.up.left")
                        .font(.largeTitle)
                })
            }.padding()
        }
    }
    @ViewBuilder
    func colorButton(color: Color) -> some View{
        Button{
            canvasView.setStrokeColor(color: color)
        }label: {
            if(color == .white){
                Image(systemName: "eraser")
                    .font(.largeTitle)
            }else{
                Image(systemName: "circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(color)
                    .mask{
                        Image(systemName: "pencil.tip")
                            .font(.largeTitle)
                    }
            }
        }
        
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}

struct CanvasView: UIViewRepresentable {
    typealias UIViewType = CanvasUIView
    
    @ObservedObject var canvasView: CanvasUIView
    
    func makeUIView(context: Context) -> CanvasUIView {
        return canvasView
    }
    
    func updateUIView(_ uiView: CanvasUIView, context: Context) {
        // Nothing to update
    }
}

class CanvasUIView: UIView, ObservableObject {
    // Variables
    @Published var strokeColor = UIColor.black
    fileprivate var strokeWidth: CGFloat = 5.0
    fileprivate var paths: [Path] = [Path]()
    @Published var isEraserEnabled = false
    fileprivate var lastPoint: CGPoint!

    override func draw(_ rect: CGRect) {
        // Create graphics context
        let context = UIGraphicsGetCurrentContext()
        // Set fill color of context
        context?.setFillColor(UIColor.white.cgColor)
        // Set rectangle to be drawn
        context?.fill(rect)
        
        if isEraserEnabled {
            context?.setBlendMode(.normal)
            self.strokeColor = UIColor.white
        } else {
            context?.setBlendMode(.normal)
            // Set drawing color of context
            let cgStrokeColor = self.strokeColor.cgColor
            UIColor(cgColor: cgStrokeColor).setStroke()

        }
        
        // Draw each path saved in the array
        for path in paths {
            path.path.lineWidth = strokeWidth
            path.color.setStroke()
            path.path.stroke()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lastPoint = touch.location(in: self)
        
        // Create a new path
        let path = Path()
        path.color = strokeColor
        
        // Add starting point to the path
        path.path.move(to: lastPoint)
        
        // Add path to array
        paths.append(path)

        // Update view
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: newPoint)
        lastPoint = newPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: newPoint)
    }

    private func drawLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        // Aggiungi il punto corrente al percorso
        guard var path = paths.popLast() else { return }
        path.path.addLine(to: endPoint)
        paths.append(path)
        
        // Aggiorna la vista
        setNeedsDisplay()
    }
    
    func undo() {
        // Rimuovi l'ultimo percorso dall'array
        _ = paths.popLast()
        
        // Aggiorna la vista
        setNeedsDisplay()
    }
    

    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }


    func setStrokeColor(color: Color) {
        let uiColor = UIColor(color)
        self.strokeColor = uiColor
    }

    func clear() {
        // Rimuovi tutti i percorsi
        paths.removeAll()
        
        // Aggiorna la vista
        setNeedsDisplay()
    }

    fileprivate class Path {
        var color = UIColor.black
        var path = UIBezierPath()
    }
}
extension UIView {
    func capture() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
