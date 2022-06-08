//
//  MemoListVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoListVC: UITableViewController {
    var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated : Bool){
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    /**
     * 테이블 뷰 cell 몇개로 할건지?
     * TODO : AppDelegate의 멤버변수 가져와서 count 반환
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memoList.count
    }

    /**
     * 테이블 셀 레이블에 데이터 지정
     * TODO :
     *  1. 재사용 큐에서 특정 cell 인스턴스 가져옴
     *  2. AppDelelgate에 있는 memoList에서 데이터를 cell의 레이블에 삽입
     *  3. 데이터 받은 cell 반환
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let rowData = self.appDelegate.memoList[indexPath.row]
        let cellId  = rowData.image == nil ? "memoCell" : "memoCellWithImage"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        cell.subject?.text  = rowData.title
        cell.contents?.text = rowData.contents
        cell.img?.image     = rowData.image
        
        let formatter       = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text  = formatter.string(from: rowData.regdate!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        if appDelegate != nil {
            return appDelegate!.memoList.count
        }else{
            return -1
        }
    }*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
