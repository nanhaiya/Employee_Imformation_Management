package cn.little.service;

import cn.little.domain.JobImfo;
import cn.little.domain.SalaryImfo;
import cn.little.domain.internImfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SamService {

    //查询所有薪资薪资
    public List<SalaryImfo> findAll();


    //保存薪资信息
    public int editSalaSave(SalaryImfo salaryImfo);

    //查询实习生信息
    public List<internImfo> internFindAll();

    //查询实习期内容
    public String[] SelectInfo();

    //保存实习生进度
    public int edtInSave(int id,int AdaptPeriod,int GraowPeriod,int AssiPeriod);

    //编辑实习生内容
    public int edtScriptSave(String yi,String er,String san);

    //查询需求
    public JobImfo jobNeedAll(int jobId);

    public int editJobSave(int id,int editRenShu,String editGangW);
}
