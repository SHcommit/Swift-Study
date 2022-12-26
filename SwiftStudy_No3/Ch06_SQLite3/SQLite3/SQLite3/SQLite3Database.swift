//import UIKit
//
//class SQLite3Database
//{
//    var db      : OpaquePointer!
//    var stmt    : OpaquePointer!
//    var fileMgr : FileManager?
//    var dbPath  : String?
//    init()
//    {
//        findSQLite3Path()
//
//        // DDL. 테이블 없으면 sequence 테이블 정의하라.
//        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
//        sqlite_open(dbPath,&db)
//
//    }
//
//    /*
//        파일메니저를 통해 앱 내 디렉터리 경로를 찾고 URL객체로 생성.
//        "db.sqlite" 경로 추가로 SQLite3 db경로 저장.
//     */
//    func findSQLite3Path()
//    {
//        fileMgr = FileManager()
//        let docPathURL = fileMgr?.urls(for: .documentDirectory, in: .userDomainMask).first!
//        dbPath = docPathURL?.appendingPathComponent("db.sqlite").path ?? nil
//        NSLog(dbPath!)
//    }
//    func openDatabase() -> OpaquePointer?
//    {
//        var db : OpaquePointer
//        guard let dbPath = dbPath else
//        {
//            NSLog("dbPath is nil")
//            return nil
//        }
//        if sqlite3_open(dbPath,&db)
//        {
//            NSLog("\n\(dbPath)에서 db에 성공적으로 연결했습니다.")
//            return db
//        }
//        else
//        {
//            NSLog("db을 열 수 없어요.")
//            return nil
//        }
//    }
//}
