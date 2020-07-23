<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工信息管理</title>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <style type="text/css">
        #cebian{
            width: 15%;
            height: 300px;
            border-right: 1px solid #cff1ef;
            float: left;
        }
        #zhong {
            width: 85%;
            float: left;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            if($("#nowPage").val()!=null){
                var active="active_"+$("#nowPage").val();
                document.getElementById(active).setAttribute('class','active')
            }
        })
        //新增
        function addEmpo() {
            console.log("jinlaile")
            $("#addTishi").text("添加员工");
            $("#AddName").text("");
            $.post("${pageContext.request.contextPath}/account/AddEmpo",{"Name":$("#AddName").val(),"jobId":$("#AddWord  option:selected").val(),"WorkPlace":$("#Add_workPlace  option:selected").val()},function (result) {
                if (result=="full"){
                    $("#addTishi").text("岗位人数已满！添加失败")
                }else if (result=="success"){
                    $("#addTishi").text("添加成功！")
                    setTimeout(function(){
                        var url;
                        if ($("#nowPage").val()==null){
                            url='${pageContext.request.contextPath}/account/findAll?pn=1';
                        }else{
                            url='${pageContext.request.contextPath}/account/findAll?pn='+$("#nowPage").val();
                        }

                        $(location).attr('href', url);
                    }, 1000);
                }else{
                    $("#addTishi").text("添加失败！")
                }
            });
        }
        //编辑
        function edit(id) {
            $("#editTishi").text("编辑员工");
            var nameId="name_"+id;
            var workPlaceId="workPlace_"+id;
            var kindId="kind_"+id;
            var name=document.getElementById(nameId).innerHTML;
            var workPlace=document.getElementById(workPlaceId).innerHTML;
            var kind=document.getElementById(kindId).innerHTML;

            $('#myModalEdit').modal('show')
            $("#inputEditName").val(name)
            $("#Select_WorkPlace").val(workPlace);
            $("#Select_kind").val(kind);
            $("#HidId").val(id);
            $("#kindkind").val(kind);
        }
        //编辑保存
        function editUpdate() {
            var inputEditName=$("#inputEditName").val();
            var Select_WorkPlace=$("#Select_WorkPlace").val();
            var Select_kind=$("#Select_kind").val();
            var id=$("#HidId").val();
            var kindkind=$("#kindkind").val();
            if(inputEditName==""){
                $("#editTishi").text("姓名不能为空");
            }else{
                if(kindkind!=Select_kind&&Select_kind=="实习生"){
                    $("#editTishi").text("不能由正式员工转为实习生");
                }else{
                    $.post("${pageContext.request.contextPath}/account/editEmpo",{"id":id,"inputEditName":inputEditName,"Select_WorkPlace":Select_WorkPlace,"Select_kind":Select_kind},function (result) {
                        if (result==0){
                            $("#editTishi").text("修改失败")
                        }else{
                            $("#editTishi").text("修改成功")
                            setTimeout(function(){
                                var url='${pageContext.request.contextPath}/account/findAll?pn='+$("#nowPage").val();
                                $(location).attr('href', url);
                            }, 1000);
                        }
                    });
                }
            }
        }
        //删除
        function dele(id) {
            var r = confirm("确定删除该员工？");
            if (r == true) {
                $.post("${pageContext.request.contextPath}/account/deleEmp",{"id":id},function (result) {
                    if (result==0){
                       alert("删除失败")
                    }else{
                       alert("删除成功")
                            var url='${pageContext.request.contextPath}/account/findAll?pn='+$("#nowPage").val();
                            $(location).attr('href', url);
                    }
                });
            }
        }
        //下一页
        function NextPage(page) {
            var pages=$("#sumPages").val();
            if(page<pages){
                page++;
                var url='${pageContext.request.contextPath}/account/findAll?pn='+page;
                $(location).attr('href', url);
            }

        }
        //上一页
        function PreviouPage(page) {
            if(page>1){
                page--;
                var url='${pageContext.request.contextPath}/account/findAll?pn='+page;
                $(location).attr('href', url);
            }
        }
    </script>
</head>
<body>
<div class="page-header">
    <h1>员工信息管理系统 <small>Employee information management system</small></h1>
</div>
<div class="container-fluid">
    <div id="cebian">
        <ul class="nav nav-pills nav-stacked">
            <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/account/findAll?pn=1">员工信息管理</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/findAll?pn=1">薪资管理</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/internFindAll?pn=1">实习生培训</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/jobNeedAll">招聘管理</a></li>
        </ul>
    </div>
    <div id="zhong">
        <table class="table table-striped" id="emps_table">
            <thead>
                <tr>
                    <th>员工Id</th>
                    <th>姓名</th>
                    <th>岗位</th>
                    <th>工作地</th>
                    <th>员工性质</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th id="Id_${emp.id}">${emp.id}</th>
                        <th id="name_${emp.id}">${emp.name}</th>
                        <th id="jobName_${emp.id}">${emp.jobName}</th>
                        <th id="workPlace_${emp.id}">${emp.workPlace}</th>
                        <th id="kind_${emp.id}">${emp.kind}</th>
                        <th>
                            <button class="btn btn-primary btn-sm" id="${emp.id}" onclick="edit(this.id)">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm"  id="${emp.id}" onclick="dele(this.id)">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%--新增按钮--%>
<div class="container">
    <div align="right">
        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            新增
        </button>
    </div>
</div>
<%--分页条--%>
<div align="center">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li>
                <a href = "javascript:void(0)" onclick="PreviouPage(${pageInfo.pageNum})" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <li id="active_${pageNum}"><a href="${pageContext.request.contextPath}/account/findAll?pn=${pageNum}">${pageNum}</a></li>
            </c:forEach>
            <li>
                <a href = "javascript:void(0)" onclick="NextPage(${pageInfo.pageNum})" aria-label="Next">
                    <input id="sumPages" type="hidden" value="${pageInfo.pages}">
                    <input type="hidden" id="nowPage" value="${pageInfo.pageNum}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>



<%--新增模块--%>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
               <%-- 表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="AddName" placeholder="姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">岗位</label>
                        <div class="col-sm-10">
                            <select id="AddWord">
                                <option value="1">人事部</option>
                                <option value="2">财务部</option>
                                <option value="3">市场</option>
                                <option value="4">项目经理</option>
                                <option value="5">开发工程师</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">工作地</label>
                        <div class="col-sm-10">
                            <select id="Add_workPlace">
                                <option value="湖南长沙">湖南长沙</option>
                                <option value="湖南常德">湖南常德</option>
                                <option value="湖南岳阳">湖南岳阳</option>
                                <option value="湖南湘潭">湖南湘潭</option>
                                <option value="湖南株洲">湖南株洲</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
               </div>
                   <div class="form-group">
                       <div class="col-sm-offset-2 col-sm-10">
                           <button type="button" onclick="addEmpo()" class="btn btn-default">保存</button>
                       </div>
                   </div>
                   </form>
                   <div align="center"><label  class="active"  id="addTishi">添加员工</label></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


<%--修改--%>
<!-- Modal -->
<div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editEmpInfo">修改资料</h4>
            </div>
            <div class="modal-body">
                <%-- 表单--%>
                <form class="form-horizontal">
                    <input type="hidden" value="" id="HidId">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputEditName" placeholder="姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">工作地</label>
                        <div class="col-sm-10">
                            <select id="Select_WorkPlace">
                                <option value="湖南长沙">湖南长沙</option>
                                <option value="湖南常德">湖南常德</option>
                                <option value="湖南岳阳">湖南岳阳</option>
                                <option value="湖南湘潭">湖南湘潭</option>
                                <option value="湖南株洲">湖南株洲</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工性质</label>
                        <div class="col-sm-10">
                            <input type="hidden" value="" id="kindkind">
                            <select id="Select_kind">
                                <option value="正式员工">正式员工</option>
                                <option value="实习生">实习生</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" onclick="editUpdate()" class="btn btn-default">保存</button>
                        </div>
                    </div>
                </form>
                    <div align="center"><label  class="active"  id="editTishi">编辑员工</label></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
