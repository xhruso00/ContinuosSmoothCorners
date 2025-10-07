import AppKit
import UniformTypeIdentifiers

enum FileType {
    case PDF
    case SVG
}

class ViewController: NSViewController {

    @IBOutlet weak var widthTextField: NSTextField!
    @IBOutlet weak var heightTextField: NSTextField!
    @IBOutlet weak var radiusSlider: NSSlider!
    @IBOutlet weak var smoothCornersButton: NSButton!
    @IBOutlet weak var fillColorWell: NSColorWell!
    @IBOutlet weak var canvas: Canvas!

    func updateUI() {
        canvas.width = CGFloat(widthTextField.floatValue)
        canvas.height = CGFloat(heightTextField.floatValue)
        canvas.radius = CGFloat(radiusSlider.floatValue)
        canvas.isContinuos = smoothCornersButton.state == .on
        canvas.color = fillColorWell.color
    }

    func export(to fileURL : URL) {
        let frameRect = NSRect(x: 0, y: 0,
                               width: CGFloat(widthTextField.floatValue),
                               height: CGFloat(heightTextField.floatValue))
        let canvas = Canvas(frame: frameRect)
        canvas.width = frameRect.width
        canvas.height = frameRect.height
        canvas.radius = CGFloat(radiusSlider.floatValue)
        canvas.isContinuos = smoothCornersButton.state == .on
        canvas.color = fillColorWell.color
        
        let data = canvas.dataWithPDF(inside: frameRect)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            NSAlert(error: error).runModal()
        }
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        updateUI()
    }
    
    @IBAction func exportAction(_ sender: NSButton) {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [UTType.pdf]
        savePanel.beginSheetModal(for: self.view.window!) { [weak self] response in
            guard response == .OK, let url = savePanel.url else { return }
            self?.export(to: url)
        }
    }
    
}

