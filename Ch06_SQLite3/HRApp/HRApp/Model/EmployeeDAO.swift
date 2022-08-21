enum EmpStateType : Int
{
    case ING = 0 , STOP , OUT
    
    func desc() -> String
    {
        switch self
        {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
}

struct EmployeeVO
{
    var empCd       = 0
    var empName     = ""
    var joinDate    = ""
    var stateCd     = EmpStateType.ING
    var departCd    = 0
    var departTitle = ""
}

class EmployeeDAO
{
    lazy var fmdb : FMDatabase! =
    {
        let mgr = FileManager.default
        let path = mgr.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let _path = path else
        {
            NSLog("filemanager path nil")
            return nil
        }
        let dbPath = _path.appendingPathComponent("hrDb.sqlite").path
        
        if mgr.fileExists(atPath: dbPath) == false
        {
            let dbSource = Bundle.main.path(forResource: "hrDb",ofType: "sqlite")
            try! mgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        return FMDatabase(path: dbPath)
    }()
    
    init()
    {
        self.fmdb.open()
    }
    deinit
    {
        self.fmdb.close()
    }
    
    func find() -> [EmployeeVO]
    {
        var list = [EmployeeVO]()
        do
        {
            let sql = """
                SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
                FROM employee
                JOIN department On department.depart_cd = employee.depart_cd
                ORDER BY employee.depart_cd ASC
            """
            //레코드 가져오는,,
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            while rs.next()
            {
                var record         = EmployeeVO()
                record.empCd       = Int(rs.int(forColumn: "emp_cd"))
                record.empName     = rs.string(forColumn: "emp_name")!
                record.joinDate    = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                list.append(record)
            }
        }
        catch let error as NSError
        {
            NSLog("failed: \(error.localizedDescription)")
        }
        return list
    }
    
    func get(cd : Int) -> EmployeeVO?
    {
        let sql = """
            SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
            FROM employee
            JOIN department On department.depart_cd = employee.depart_cd
            WHERE emp_cd = ?
        """
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [cd])
        
        if let _rs = rs
        {
            _rs.next()
            var record         = EmployeeVO()
            record.empCd       = Int(_rs.int(forColumn: "emp_cd"))
            record.empName     = _rs.string(forColumn: "emp_name")!
            record.joinDate    = _rs.string(forColumn: "join_date")!
            record.departTitle = _rs.string(forColumn: "depart_title")!
            
            let cd = Int(_rs.int(forColumn: "state_cd"))
            record.stateCd = EmpStateType(rawValue: cd)!
            return record
        }
        else
        {
            return nil
        }
    }
    
    func create(param: EmployeeVO) -> Bool
    {
        do
        {
            let sql = """
                INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
                VALUES( ? , ? , ? , ? )
            """
            
            var params = [Any]()
            params.append(param.empCd)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        }
        catch let error as NSError
        {
            NSLog("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(cd : Int) -> Bool
    {
        do
        {
            let sql = """
                DELETE FROM employee WHERE emp_cd = ?
            """
            try self.fmdb.executeUpdate(sql, values: [cd])
            return true
        }
        catch let error as NSError
        {
            NSLog("Insert Error : \(error.localizedDescription) ")
            return false
        }
            
    }
}
