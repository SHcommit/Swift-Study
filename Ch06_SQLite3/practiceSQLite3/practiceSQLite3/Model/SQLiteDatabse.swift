import UIKit

/**
 TODO : <#Summay text for documentation#>
 
 - Param db : sqlite3
 - Param stmt : tableStatement
 - Param dbPath : 앱 문서 내 sqlite3 경로
 - Param sqlStr : 태이블 생성 sql구문, 이미 생성 되있으면 따로 테이블 생성 x
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. 앱 내 문서에 새로 sqlite3 경로를 만든다.
 2. sql구문으로 table생성을 하는 문자열을 통해 테이블을 정의한다.
 3. db 객체 연결~ 해제
    3-1. sqlite3_open()          // db생성
    3-2. sqlite3_prepare()      // sql구문 객체 생성 -> 상태 코드 반환 SQLITE_OK ? SQLITE_FAIL
    3-3. sqlite3_step()           // 컴파일된 sql구문 객체를 db에 전달.(테이블 생성)
    3-4. sqlite3_finalize()       // 컴파일된 sql구문 삭제
    3-5. sqlite3_close()
        이거 하나의 임계구역에서 작업되는 거라고 생각하면됨. 한 세트
 */
class SQLiteDatabase
{
    var db       : OpaquePointer? = nil
    var stmt     : OpaquePointer? = nil
    var dbPath   : String? = ""
    var sqlStr   : String  = ""
    init()
    {
        addDbPath()
        sqlStr = "CREATE TABLE IF NOT EXISTS squqence (num INTEGER)"
        db = openDatabase()
        createTable()
    }
    
    func addDbPath()
    {
        let manager    = FileManager()
        let docPathURL = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        dbPath = try! docPathURL?.appendingPathComponent("db.sqlite").path
        //와 신기 ㅋㅋㅋ 경로를 홈으로 하니까 db 생성됨 ㅋㅋㅋㅋ
        //dbPath = "/Users/yangseunghyeon/db.sqlite"
        if manager.fileExists(atPath:dbPath!) == false
        {
            let dbSource = Bundle.main.path(forResource:"db",ofType: "sqlite")
            try! manager.copyItem(atPath: dbSource!, toPath: dbPath!)
        }
    }
    func openDatabase() -> OpaquePointer?
    {
        var db : OpaquePointer?
        guard let path = dbPath else
        {
            NSLog("db path is nil")
            return nil
        }
        if sqlite3_open(path,&db) == SQLITE_OK
        {
            NSLog("success to connect db")
            return db
        }
        else
        {
            NSLog("fail to connect db")
            return nil
        }
    }
    func createTable()
    {
        guard sqlite3_prepare(db, sqlStr, -1, &stmt, nil) == SQLITE_OK else
        {
            return NSLog("Wrong create table db string")
        }
        
        defer
        {
            NSLog("close db connection")
            sqlite3_close(stmt)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE
        {
            NSLog("create table")
        }
        else
        {
            NSLog("not create table db")
        }
        defer
        {
            NSLog("Finalize stmt")
            sqlite3_finalize(stmt)
        }
    }
}
