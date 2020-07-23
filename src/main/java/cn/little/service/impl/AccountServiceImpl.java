package cn.little.service.impl;

import cn.little.dao.AccountDao;
import cn.little.domain.AdminImfo;
import cn.little.domain.employee;
import cn.little.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("AccountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao accountDao;

    //管理员登录
    public int adminLoad(AdminImfo adminImfo) {
        return accountDao.adminLoad(adminImfo);
    }


    public List<employee> findAll() { return accountDao.findAll();}

    public int JobNum(int jobId) {
        return accountDao.JobNum(jobId);
    }

    public int Addemployeimfo(String Name, int JobId, String WorkPlace) {
        int Id=accountDao.NextId();
        int InId=accountDao.NextInId();
        int a=accountDao.Addemployeimfo(Id,Name,JobId,WorkPlace,InId);
        a+=accountDao.Addsalarypurchase(Id);
        a+=accountDao.Addinternimfo(InId);
        return a;
    }

    public int selectKind(int id) {
        return accountDao.selectKind(id);
    }

    public int editEmpo(int id, String name, String Select_WorkPlace, int kind) {
        return accountDao.editEmpo(id,name,Select_WorkPlace,kind);
    }

    public int delectTr(int kind) {
        return accountDao.delectTr(kind);
    }

    public int deleEmp(int id) {
        return accountDao.deleEmp(id);
    }

    @Override
    public int deleSalary(int id) {
        return accountDao.deleSalary(id);
    }


}
