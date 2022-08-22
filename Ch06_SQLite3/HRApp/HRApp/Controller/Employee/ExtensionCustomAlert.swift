import UIKit

extension CustomAlert
{
    func addPickerView(list : [DepartRecord]!)
    {
        self.setupContent()
        guard self.alert != nil else
        {
            NSLog("alert 초기화해주세요.")
            return
        }
        let picker = departPicker(list: list, frame: CGRect.zero)
        selected = picker.selected
        do
        {
            try! self.contentVC?.view = picker
        }
        catch let err as NSError
        {
            NSLog("picker err : \(err.localizedDescription)")
            return
        }
    }
}
