import UIKit

class departPicker : UIPickerView , UIPickerViewDelegate, UIPickerViewDataSource
{
    var _list : [DepartRecord]! = [DepartRecord]()
    var selected : Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(list : [DepartRecord]!, frame : CGRect)
    {
        self.init(frame: frame)
        _list = list
        self.delegate = self
        self.dataSource = self
        
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
    
    //애로 컴포넌트 row들 구성하는게 더 좋네 아래꺼보다 pickerView(_:titleForRow: ...)
    func pickerView(_ pickerVIew:UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view : UIView?) -> UIView
    {
        var tv = view as? UILabel
        if tv == nil
        {
            tv                = UILabel()
            tv?.font          = UIFont.systemFont(ofSize: 14)
            tv?.textAlignment = .center
        }
        tv?.text = "\(self._list[row].departTitle)(\(self._list[row].departAddr)"
        return tv!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let (_, title, addr) = _list[row]
//        let titleView
//        return title+"("+addr+"호)"
//    }
}
