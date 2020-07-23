package cn.little.controller;

import cn.little.dao.SamDao;
import cn.little.domain.JobImfo;
import cn.little.domain.SalaryImfo;
import cn.little.domain.employee;
import cn.little.domain.internImfo;
import cn.little.service.SamService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.xdevapi.JsonArray;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/imfo")
public class SalaryAndMoreController {

    @Autowired
    private SamService samService;

    //薪资管理
    @RequestMapping("findAll")
    public String findAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model,HttpServletRequest request){
        Cookie[] cok = request.getCookies();
        Map<String, String> cm = new HashMap<>();
        if (cok == null) {
//            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return "redirect:/index.jsp";
        } else {
            for (Cookie cookie : cok) {
                cm.put(cookie.getName(), cookie.getValue());
            }
            if (cm.containsKey("load")) {
                PageHelper.startPage(pn,7);
                List<SalaryImfo> all = samService.findAll();
                PageInfo page=new PageInfo(all);
                model.addAttribute("pageInfo",page);
                return "salaryImfo";
            } else {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return "redirect:/index.jsp";
            }

        }
    }

    //编辑薪资
    @RequestMapping("editSalaSave")
    public @ResponseBody String editSalaSave(SalaryImfo salaryImfo){
        String editLine="full";
        int i=samService.editSalaSave(salaryImfo);
        if(i>0){
            editLine="sucess";
        }
        return editLine;
    }

    //实习生培训
    @RequestMapping("internFindAll")
    public String internFindAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model,HttpServletRequest request){
        Cookie[] cok = request.getCookies();
        Map<String, String> cm = new HashMap<>();
        if (cok == null) {
//            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return "redirect:/index.jsp";
        } else {
            for (Cookie cookie : cok) {
                cm.put(cookie.getName(), cookie.getValue());
            }
            if (cm.containsKey("load")) {
                PageHelper.startPage(pn,7);
                List<internImfo> all = samService.internFindAll();
                PageInfo page=new PageInfo(all);
                model.addAttribute("pageInfo",page);
                return "internImfo";
            } else {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return "redirect:/index.jsp";
            }

        }

    }
//    @RequestMapping(value="SelectInfo", produces = "application/json; charset=utf-8")
    //实习期内容
    @RequestMapping(value="SelectInfo", produces = "application/json; charset=utf-8")
    public @ResponseBody Object SelectInfo(){
        String arr[]=samService.SelectInfo();
        Map<String,String> map=new HashMap<>();
        map.put("arr0",arr[0]);
        map.put("arr1",arr[1]);
        map.put("arr2",arr[2]);
        return map;
    }

    //保存实习期进度
    @RequestMapping("edtInSave")
    public @ResponseBody int edtInSave(@RequestParam("id") int id,@RequestParam("AdaptPeriod") int AdaptPeriod,@RequestParam("GraowPeriod") int GraowPeriod,@RequestParam("AssiPeriod") int AssiPeriod){
        int i=0;
        i+=samService.edtInSave(id,AdaptPeriod,GraowPeriod,AssiPeriod);
        return i;
    }

    //保存描述
    @RequestMapping("edtScriptSave")
    public @ResponseBody int edtScriptSave(@RequestParam("yi") String yi,@RequestParam("er") String er,@RequestParam("san") String san){
        int i=0;
        i+=samService.edtScriptSave(yi,er,san);
        return i;
    }

    //加载招聘管理界面
    @RequestMapping("jobNeedAll")
    public String jobNeedAll(JobImfo jobImfo, HttpServletRequest req,HttpServletRequest request){
        Cookie[] cok = request.getCookies();
        Map<String, String> cm = new HashMap<>();
        if (cok == null) {
//            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return "redirect:/index.jsp";
        } else {
            for (Cookie cookie : cok) {
                cm.put(cookie.getName(), cookie.getValue());
            }
            if (cm.containsKey("load")) {
                List<JobImfo> list = new ArrayList<JobImfo>();
                for(int i=1;i<=5;i++){
                    jobImfo = samService.jobNeedAll(i);
                    list.add(jobImfo);
                }
                req.setAttribute("listImfo",list);
                return "Recruitment";
            } else {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return "redirect:/index.jsp";
            }

        }

    }

    @RequestMapping("editJobSave")
    public @ResponseBody int editJobSave(@RequestParam int id,@RequestParam int editRenShu,@RequestParam String editGangW){
        int i=0;
        i+=samService.editJobSave(id,editRenShu,editGangW);
        return i;
    }


}
