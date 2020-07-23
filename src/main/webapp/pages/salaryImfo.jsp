
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>薪资管理</title>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <style type="text/css">
        #cebian {
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
            var active="active_"+$("#nowPage").val();
            document.getElementById(active).setAttribute('class','active')
        })
        //下一页
        function NextPage(page) {
            var pages=$("#sumPages").val();
            if(page<pages){
                page++;
                var url='${pageContext.request.contextPath}/imfo/findAll?pn='+page;
                $(location).attr('href', url);
            }

        }
        //上一页
        function PreviouPage(page) {
            if(page>1){
                page--;
                var url='${pageContext.request.contextPath}/imfo/findAll?pn='+page;
                $(location).attr('href', url);
            }
        }
        //编辑按钮
        function editSalary(id){
            var name="name_"+id;
            var basicS="basicS_"+id;
            var fullAS="fullAS_"+id;
            var workS="workS_"+id;
            var overtimeS="overtimeS_"+id;
            var deduct="deduct_"+id;
            var tax="tax_"+id;

            $("#editTishi").val("编辑薪资信息");
            $("#editId").val(id)
            $("#editName").val(document.getElementById(name).innerHTML)
            $("#editbasicS").val(document.getElementById(basicS).innerHTML)
            $("#editfullAS").val(document.getElementById(fullAS).innerHTML)
            $("#editworkS").val(document.getElementById(workS).innerHTML)
            $("#editovertimeS").val(document.getElementById(overtimeS).innerHTML)
            $("#editdeduct").val(document.getElementById(deduct).innerHTML)
            $("#edittax").val(document.getElementById(tax).innerHTML)

            $('#myModal').modal('show')

        }
        //编辑保存
        function editSalaSave() {
            var data=$("#editSave").serialize();//获取值
            $.ajax({
                type:'post',
                url:"${pageContext.request.contextPath}/imfo/editSalaSave",
                data:data,
                success: function (result) {
                    if (result=="full"){
                        $("#editTishi").text("修改失败")
                    }else{
                        $("#editTishi").text("修改成功")
                        setTimeout(function(){
                            var url='${pageContext.request.contextPath}/imfo/findAll?pn='+$("#nowPage").val();
                            $(location).attr('href', url);
                        }, 500);
                    }
                }

            })
        }
    </script>
</head>


<div class="page-header">
    <h1>员工信息管理系统 <small>Employee information management system</small></h1>
</div>
<div class="container-fluid">
    <div id="cebian">
        <ul class="nav nav-pills nav-stacked">
            <li role="presentation"><a href="${pageContext.request.contextPath}/account/findAll?pn=1">员工信息管理</a></li>
            <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/imfo/findAll?pn=1">薪资管理</a></li>
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
                <th>底薪</th>
                <th>全勤奖</th>
                <th>项目奖</th>
                <th>加班费</th>
                <th>惩罚扣除</th>
                <th>个税</th>
                <th>总计</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <th id="Id_${emp.id}">${emp.id}</th>
                    <th id="name_${emp.id}">${emp.name}</th>
                    <th id="basicS_${emp.id}">${emp.basicS}</th>
                    <th id="fullAS_${emp.id}">${emp.fullAS}</th>
                    <th id="workS_${emp.id}">${emp.workS}</th>
                    <th id="overtimeS_${emp.id}">${emp.overtimeS}</th>
                    <th id="deduct_${emp.id}">${emp.deduct}</th>
                    <th id="tax_${emp.id}">${emp.tax}</th>
                    <th id="sum_${emp.id}">${emp.basicS+emp.fullAS+emp.workS+emp.overtimeS-emp.deduct-emp.tax}</th>
                    <th>
                        <button class="btn btn-info btn-sm" id="${emp.id}" onclick="editSalary(this.id)">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                    </th>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    </div>
</div>

<%--分页条--%>
<div align="center">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li>
                <a href="javascript:void(0)" onclick="PreviouPage(${pageInfo.pageNum})" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <li id="active_${pageNum}"><a href="${pageContext.request.contextPath}/imfo/findAll?pn=${pageNum}">${pageNum}</a></li>
            </c:forEach>
            <li>
                <a href="javascript:void(0)" onclick="NextPage(${pageInfo.pageNum})" aria-label="Next">
                    <input id="sumPages" type="hidden" value="${pageInfo.pages}">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<input type="hidden" id="nowPage" value="${pageInfo.pageNum}">



<%--薪资修改--%>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">薪资修改</h4>
            </div>
            <div class="modal-body">
                <%-- 表单--%>
                <form id="editSave" class="form-horizontal">
                    <input type="hidden" name="Id" id="editId" value="">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text"  class="form-control" disabled="disabled" id="editName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">底薪</label>
                        <div class="col-sm-10">
                            <input type="text" name="BasicS" class="form-control" id="editbasicS" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">全勤奖</label>
                        <div class="col-sm-10">
                            <input type="text" name="FullAS" class="form-control" id="editfullAS" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">项目奖</label>
                        <div class="col-sm-10">
                            <input type="text" name="WorkS" class="form-control" id="editworkS" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">加班费</label>
                        <div class="col-sm-10">
                            <input type="text" name="OvertimeS" class="form-control" id="editovertimeS" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">惩罚扣除</label>
                        <div class="col-sm-10">
                            <input type="text" name="Deduct" class="form-control" id="editdeduct" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">个税</label>
                        <div class="col-sm-10">
                            <input type="text" name="Tax" class="form-control" id="edittax" >
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" onclick="editSalaSave()" class="btn btn-default">保存</button>
                        </div>
                    </div>
                </form>
                <div align="center"><label  class="active"  id="editTishi">编辑薪资信息</label></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
