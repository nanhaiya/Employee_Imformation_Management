package cn.little.dao;

import cn.little.domain.AdminImfo;
import cn.little.domain.employee;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/*
* 管理员
* */
@Repository
public interface AccountDao {

    //管理员登录
    @Select("SELECT count(*) from admin where admin=#{admin} and password=#{password}")
    public int adminLoad(AdminImfo adminImfo);

    //查询所有员工信息
    @Select("SELECT Id,`Name`,jobName,WorkPlace,Kind from employeimfo INNER JOIN jobimfo on employeimfo.JobId=jobimfo.jobId")
    public List<employee> findAll();

    //查询岗位所缺人数
    @Select("select (SELECT jobNeedP from jobimfo WHERE jobId=#{jobId})-(SELECT count(*) FROM employeimfo WHERE JobId=#{jobId})")
    public int JobNum(int jobId);

    //查询下一位id
    @Select("SELECT ifnull(MAX(Id)+1,1) from employeimfo")
    public int NextId();

    //查询下一位实习生Id,空返回1
    @Select("SELECT ifnull(MAX(Id)+1,1) from internimfo")
    public int NextInId();

    //导入
    @Insert("Insert into employeimfo (Id,`Name`,JobId,SalaryId,WorkPlace,Kind,TraineeId)values(#{Id},#{Name},#{JobId},#{Id},#{WorkPlace},'实习生',#{InId})")
    public int Addemployeimfo(@Param("Id") int Id,@Param("Name") String Name,@Param("JobId") int JobId,@Param("WorkPlace") String WorkPlace,@Param("InId") int InId);

    @Insert("insert into salarypurchase (Id)values(#{Id})")
    public int Addsalarypurchase(@Param("Id") int Id);

    @Insert("insert into internimfo  (Id)values(#{InId})")
    public int Addinternimfo(@Param("InId") int InId);


    //查询性质
    @Select("SELECT TraineeId from employeimfo where id=#{id}")
    public int selectKind(@Param("id") int id);

    //删除实习生
    @Delete("DELETE from internimfo where Id=#{kind}")
    public int delectTr(int kind);

    //编辑
    @Update("UPDATE employeimfo SET `Name`=#{name},WorkPlace=#{Select_WorkPlace},TraineeId=#{kind},Kind='正式员工' where Id=#{id}")
    public int editEmpo(@Param("id") int id,@Param("name") String name,@Param("Select_WorkPlace") String Select_WorkPlace,@Param("kind") int kind);

    //删除实习生
    @Delete("DELETE from employeimfo where Id=#{id}")
    public int deleEmp(int id);

    //删除薪资板块
    @Delete("DELETE from salarypurchase where Id=#{id}")
    public int deleSalary(int id);



}
