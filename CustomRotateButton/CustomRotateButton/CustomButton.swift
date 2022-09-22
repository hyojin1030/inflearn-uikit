import UIKit

enum RotateType {
    case up
    case down
}

class CustomButton: UIButton {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    var isUp = RotateType.down {
        didSet {
            changeDesign()
        }
    }
    
    var selectTypeCallback: ((RotateType) -> Void)?
    
    private func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        } else {
            isUp = .up
        }
        
        selectTypeCallback?(isUp)
    }
    
    private func changeDesign() {
        
        UIView.animate(withDuration: 0.5) {
            if self.isUp == .up{
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            } else {
                self.imageView?.transform = .identity
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
        
        
    }
    
}
