<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>招聘管理</title>
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
        //修改需求人数
        function xuqiu(id) {
            var Sum="Sum_"+id;
            var Script="Script_"+id;
            var jobName="jobName_"+id;
            $("#editInfoTishi").text("编辑人数")

            $("#GWID").val(id)
            $("#editjobName").val(document.getElementById(jobName).value)
            $("#editRenShu").val(document.getElementById(Sum).innerHTML)
            $("#editGangW").val(document.getElementById(Script).innerHTML)
            $("#xuQiuEdit").modal('show')


        }

        //编辑保存
        function editInfoUpdate() {
            var editRenShu=$("#editRenShu").val()
            var editGangW=$("#editGangW").val()
            if(!isNaN(editRenShu)){
                $.post("${pageContext.request.contextPath}/imfo/editJobSave",{
                    "id":$("#GWID").val(),
                    "editRenShu":editRenShu,
                    "editGangW":editGangW
                },function (result) {
                    if (result==0){
                        $("#editInfoTishi").text("修改失败！")
                    }else{
                        $("#editInfoTishi").text("修改成功！")
                        var url='${pageContext.request.contextPath}/imfo/jobNeedAll';
                        $(location).attr('href', url);
                    }
                });
            }else{
                $("#editInfoTishi").text("人数应为数字格式！")
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
            <li role="presentation"><a href="${pageContext.request.contextPath}/account/findAll?pn=1">员工信息管理</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/findAll?pn=1">薪资管理</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/internFindAll?pn=1">实习生培训</a></li>
            <li role="presentation"  class="active"><a href="${pageContext.request.contextPath}/imfo/jobNeedAll">招聘管理</a></li>
        </ul>
    </div>
    <div class="container-fluid" id="zhong">
        <div class="row">
    <c:forEach items="${listImfo}" var="imfo">
                <div class="col-xs-3">
                    <div class="thumbnail">
                        <img src="${APP_PATH}/static/image/${imfo.imageName}.jpg" alt="...">
                        <div class="caption">
                            <h3>${imfo.jobName} <small><label id="Sum_${imfo.jobId}">${imfo.jobNeedP}</label>人</small></h3>
                            <h5>需求人数：<label>${imfo.jobNeed}</label>人</h5>
                            <p>描述内容：<label id="Script_${imfo.jobId}">${imfo.jobScrite}</label></p>
                            <input type="hidden" id="jobName_${imfo.jobId}" value="${imfo.jobName}">
                            <p><button  class="btn btn-primary" value="${imfo.jobId}" onclick="xuqiu(this.value)">修改</button></p>
                        </div>
                    </div>
                </div>
    </c:forEach>
        </div>
    </div>
</div>

<%--需求--%>
<!-- Modal -->
<div class="modal fade" id="xuQiuEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >编辑岗位设定人数或岗位描述</h4>
            </div>
            <div class="modal-body">
                <%-- 表单--%>
                <form class="form-horizontal">
                    <input type="hidden" id="GWID" value="">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">岗位</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" disabled="disabled" id="editjobName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">岗位设定人数</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editRenShu">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">岗位描述</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editGangW">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" onclick="editInfoUpdate()" class="btn btn-default">保存</button>
                        </div>
                    </div>
                </form>
                <div align="center"><label  class="active"  id="editInfoTishi">编辑内容</label></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>




</body>
</html>
