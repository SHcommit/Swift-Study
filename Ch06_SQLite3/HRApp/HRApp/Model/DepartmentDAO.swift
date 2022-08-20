import Darwin

class DepartmentDAO
{
    typealias DepartRecord = (code: Int,depart:String,addr:String)
    
    lazy var fmdb : FMDatabase! =
    {
        let manager = FileManager.default
        let docPath = manager.urls(for:.documentDirectory,in: .userDomainMask).first
        let dbPath  = docPath!.appendingPathComponent("hrDb.sqlite").path
        
        if manager.fileExists(atPath: dbPath) == false
        {
            let dbSource = Bundle.main.path(forResource: "hrDb", ofType: "sqlite")
            try! manager.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        let db = FMDatabase(path:dbPath)
        return db
    }()
    
    init()
    {
        self.fmdb.open()
    }
    deinit
    {
        self.fmdb.close()
    }
    
    //테이블 전부 읽어들임.
    func find() -> [DepartRecord]
    {
        var list = [DepartRecord]()
        do{
            let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                ORDER BY depart_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next()
            {
                let depart : DepartRecord = (Int(rs.int(forColumn:"depart_cd")),String(rs.string(forColumn: "depart_title")!),String(rs.string(forColumn: "depart_addr")!))
                list.append(depart)
            }
        }
        catch let error as NSError
        {
            NSLog("failed: \(error.localizedDescription)")
        }
        return list
    }
    
    // 특정 레코드만 읽어들일 경우
    func getDepart(_ cd : Int) -> DepartRecord?
    {
        //1. 질의 실행
        let sql = """
            SELECT depart_cd, depart_title, depart_addr
            FROM department
            WHERE depart_cd = ?
        """
        //옵셔널 타입 반환
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [cd])
        if let _rs = rs
        {
            _rs.next()
            
            let depart : DepartRecord = (Int(_rs.int(forColumn: "depart_cd")),String(_rs.string(forColumn:"depart_title")!),String(_rs.string(forColumn:"depart_addr")!))
            return depart
        }
        else
        {
            return nil
        }
    }
    
    //부서 정보 추가
    func create(title: String!, addr: String!) -> Bool
    {
        do
        {
            let sql = """
                INSERT INTO department (depart_title, depart_addr)
                VALUES ( ? , ? )
            """
            guard let _title = title else
            {
                return false
            }
            guard let _addr = addr else
            {
                return false
            }
            guard !_title.isEmpty && !_addr.isEmpty else
            {
                return false
            }
            try self.fmdb.executeUpdate(sql,values: [_title,_addr])
            return true
        }
        catch let error as NSError
        {
            NSLog("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(cd : Int) -> Bool
    {
        do
        {
            let sql = "DELETE FROM department WHERE depart_cd= ?"
            try self.fmdb.executeUpdate(sql, values: [cd])
            return true
        }
        catch let error as NSError
        {
            NSLog("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
}
