package cn.little.service.impl;

import cn.little.dao.SamDao;
import cn.little.domain.JobImfo;
import cn.little.domain.SalaryImfo;
import cn.little.domain.internImfo;
import cn.little.service.SamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("SamService")
public class SamServiceImpl implements SamService {

    @Autowired
    private SamDao samDao;

    public List<SalaryImfo> findAll() {
        return samDao.findAll();
    }

    @Override
    public int editSalaSave(SalaryImfo salaryImfo) {
        return samDao.editSalaSave(salaryImfo);
    }

    @Override
    public List<internImfo> internFindAll() {
        return samDao.internFindAll();
    }

    @Override
    public String[] SelectInfo() {
        return samDao.SelectInfo();
    }

    @Override
    public int edtInSave(int id, int AdaptPeriod, int GraowPeriod, int AssiPeriod) {
        return samDao.edtInSave(id,AdaptPeriod,GraowPeriod,AssiPeriod);
    }

    @Override
    public int edtScriptSave(String yi, String er, String san) {
        int i=0;
        i+=samDao.edtScriptSaveyi(yi);
        i+=samDao.edtScriptSaveer(er);
        i+=samDao.edtScriptSavesan(san);
        return i;
    }

    @Override
    public JobImfo jobNeedAll(int jobId) {
        return samDao.jobNeedAll(jobId);
    }

    @Override
    public int editJobSave(int id, int editRenShu, String editGangW) {
        return samDao.editJobSave(id,editRenShu,editGangW);
    }
}
