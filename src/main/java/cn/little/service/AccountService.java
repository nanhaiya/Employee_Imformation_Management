package cn.little.service;

import cn.little.domain.AdminImfo;
import cn.little.domain.employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface AccountService {

    //管理员登录
    public int adminLoad(AdminImfo adminImfo);

    //查询所有员工数据
    public List<employee> findAll();

    //查询岗位人数
    public int JobNum(int jobId);

    //添加员工
    public int Addemployeimfo(String Name,int JobId,String WorkPlace);

    //查询性质
    public int selectKind(int id);

    //编辑
    public int editEmpo(int id,String name,String Select_WorkPlace,int kind);

    //删除实习生
    public int delectTr(int kind);

    //员工删除
    public int deleEmp(int id);

    //薪资板块删除
    public int deleSalary(int id);


}
