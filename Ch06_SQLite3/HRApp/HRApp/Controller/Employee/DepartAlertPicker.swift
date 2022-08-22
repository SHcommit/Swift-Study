import UIKit

class departPicker : UIPickerView , UIPickerViewDelegate, UIPickerViewDataSource
{
    var _list : [DepartRecord]! = [DepartRecord]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(list : [DepartRecord]!, frame : CGRect)
    {
        self.init(frame: frame)
        _list = list
        self.delegate = self
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self._list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let (_, title, addr) = _list[row]
        return title+"("+addr+"호)"
    }
}
