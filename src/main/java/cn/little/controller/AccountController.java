package cn.little.controller;

/*
* 账户web
* */

import cn.little.domain.AdminImfo;
import cn.little.domain.employee;
import cn.little.service.AccountService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;


    @RequestMapping("/adminLoad")
    public @ResponseBody String adminLoad(@RequestParam("admin") String admin, @RequestParam("password") String password, HttpServletResponse response){

        Cookie cok=new Cookie("load","lxlx");
        cok.setMaxAge(60*4);      //cookie失效时间4分钟
        cok.setPath("/");
        response.addCookie(cok);

        AdminImfo adminImfo=new AdminImfo();
        adminImfo.setAdmin(admin);
        adminImfo.setPassword(password);
        if(accountService.adminLoad(adminImfo)==1){
            adminImfo.setLoadStatus(1);
            return "sucess";
        }else{
            adminImfo.setLoadStatus(0);
            return "fal";
        }

    }
//

    @RequestMapping("/findAll")
    public String FindAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model, HttpServletRequest request,HttpServletResponse response) throws IOException {
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
                PageHelper.startPage(pn, 7);
                List<employee> all = accountService.findAll();
                PageInfo page = new PageInfo(all);
                model.addAttribute("pageInfo", page);
/*        List<employee> list=page.getList();
        for (employee employee:list){
            System.out.println("Id:"+employee.getId()+"name:"+employee.getName());
        }*/
                return "emplooyeImfo";
            } else {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return "redirect:/index.jsp";
            }

        }
    }

    @RequestMapping("AddEmpo")
    public @ResponseBody String AddEmpo(@RequestParam("Name") String Name,@RequestParam("jobId") int JobId,@RequestParam("WorkPlace") String WorkPlace){
        int jobNum=accountService.JobNum(JobId);
        if(jobNum==0){
            return "full";
        }else{
            int suss=accountService.Addemployeimfo(Name,JobId,WorkPlace);
            if (suss<0){
                return "fal";
            }else{
                return "success";
            }

        }


    }

    @RequestMapping("editEmpo")
    public  @ResponseBody int editEmpo(@RequestParam("id") int id,@RequestParam("inputEditName") String name,@RequestParam("Select_WorkPlace") String Select_WorkPlace,@RequestParam("Select_kind") String Select_kind){
        System.out.println(name+Select_WorkPlace+Select_kind+id);
        int kind=accountService.selectKind(id);
        int i=0;
        if (kind!=0&&"正式员工".equals(Select_kind)){
            //实习生删除
            i+=accountService.delectTr(kind);
            //员工修改
            i+=accountService.editEmpo(id,name,Select_WorkPlace,0);

        }else{
            //员工修改
            i+=accountService.editEmpo(id,name,Select_WorkPlace,kind);
        }
        return i;
    }

    @RequestMapping("deleEmp")
    public  @ResponseBody int deleEmp(@RequestParam("id") int id){
        int kind=accountService.selectKind(id);
        int i=0;
        if (kind!=0){
            //实习生删除
            i+=accountService.delectTr(kind);
        }
        //员工删除
        i+=accountService.deleEmp(id);
        //薪资删除
        i+=accountService.deleSalary(id);
        return i;
    }

}
