package cn.little.dao;

import cn.little.domain.JobImfo;
import cn.little.domain.SalaryImfo;
import cn.little.domain.internImfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Repository
public interface SamDao {

    //查询所有薪资
    @Select("SELECT  employeimfo.Id,employeimfo.`Name`,BasicS,FullAS,WorkS,OvertimeS,Deduct,Tax FROM salarypurchase INNER JOIN employeimfo on salarypurchase.Id=employeimfo.SalaryId")
    public List<SalaryImfo> findAll();

    //薪资编辑
    @Update("UPDATE salarypurchase SET BasicS=#{BasicS},FullAS=#{FullAS},WorkS=#{WorkS},OvertimeS=#{OvertimeS},Deduct=#{Deduct},Tax=#{Tax} where Id=#{Id}")
    public int editSalaSave(SalaryImfo salaryImfo);

    //查询所有实习生
    @Select("SELECT internimfo.Id,employeimfo.`Name`,AdaptPeriod,GraowPeriod,AssiPeriod FROM internimfo INNER JOIN employeimfo WHERE internimfo.Id=employeimfo.TraineeId")
    public List<internImfo> internFindAll();

    //查询实习期内容
    @Select("Select internjobscript from internjobscript")
    public String[] SelectInfo();

    //实习生进度编辑
    @Update("UPDATE internimfo SET AdaptPeriod=#{AdaptPeriod},GraowPeriod=#{GraowPeriod},AssiPeriod=#{AssiPeriod} WHERE Id=#{id}")
    public int edtInSave(@Param("id") int id,@Param("AdaptPeriod") int AdaptPeriod,@Param("GraowPeriod") int GraowPeriod,@Param("AssiPeriod") int AssiPeriod);

    //实习生内容编辑1
    @Update("UPDATE internjobscript set internjobscript=#{yi} where internjobId=1")
    public int edtScriptSaveyi(String yi);

    //实习生内容编辑2
    @Update("UPDATE internjobscript set internjobscript=#{er} where internjobId=2")
    public int edtScriptSaveer(String er);

    //实习生内容编辑3
    @Update("UPDATE internjobscript set internjobscript=#{san} where internjobId=3")
    public int edtScriptSavesan(String san);

    //查询岗位信息
    @Select("SELECT jobId,jobName,imageName,jobScrite,jobNeedP,((SELECT jobNeedP from jobimfo WHERE jobId=#{jobId})-(SELECT count(*) FROM employeimfo WHERE JobId=#{jobId})) AS 'jobNeed' FROM jobimfo where  JobId=#{jobId}")
    public JobImfo jobNeedAll(int jobId);

    //保存岗位信息
    @Update("UPDATE jobimfo set jobNeedP=#{editRenShu},jobScrite=#{editGangW} where jobId=#{id}")
    public int editJobSave(@Param("id") int id, @Param("editRenShu") int editRenShu, @Param("editGangW") String editGangW);
}
