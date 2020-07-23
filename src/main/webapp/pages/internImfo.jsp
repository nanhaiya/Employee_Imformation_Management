<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>实习生培训</title>
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
            $("#adaptdata").hover(
                function(){
                    $('#adaptdata').popover('show')
                },function(){
                    $('#adaptdata').popover('hide')
                }
            )
            $("#graowdata").hover(
                function(){
                    $('#graowdata').popover('show')
                },function(){
                    $('#graowdata').popover('hide')
                }
            )
            $("#assidata").hover(
                function(){
                    $('#assidata').popover('show')
                },function(){
                    $('#assidata').popover('hide')
                }
            )
            $.post("${pageContext.request.contextPath}/imfo/SelectInfo",function (result) {
                result=JSON.stringify(result)
                result=eval("("+result+")");  //将json以js形式展示
                $("#adaptdata").attr("data-content",result.arr0)
                $("#graowdata").attr("data-content",result.arr1)
                $("#assidata").attr("data-content",result.arr2)
            });
        })

        //编辑实习期进度
        function editSalary(id) {
            $("#editTishi").text("编辑实习期进度！")
            var adaptPeriod="adaptPeriod_"+id;
            var graowPeriod="graowPeriod_"+id;
            var assiPeriod="assiPeriod_"+id;
            var name="name_"+id;

            $("#editId").val(id)
            $("#edityi").val(document.getElementById(adaptPeriod).innerHTML)
            $("#editer").val(document.getElementById(graowPeriod).innerHTML)
            $("#editsan").val(document.getElementById(assiPeriod).innerHTML)
            $("#inputEditName").val(document.getElementById(name).innerHTML)
            $("#myModalEdit").modal('show')
        }

        //保存实习期进度
        function editUpdate() {
            var edityi=$("#edityi").val();
            var editer=$("#editer").val();
            var editsan=$("#editsan").val();
            if(!isNaN(edityi)&&!isNaN(editer)&&!isNaN(editsan)){
                //数字
                if(edityi>=0&&edityi<=100||editer>=0&&editer<=100||editsan>=0&&editsan<=100){
                    $.post("${pageContext.request.contextPath}/imfo/edtInSave",{
                        "id":$("#editId").val(),
                        "AdaptPeriod":edityi,
                        "GraowPeriod":editer,
                        "AssiPeriod":editsan
                    },function (result) {
                        if (result==0){
                            $("#editTishi").text("修改失败！")
                        }else{
                            $("#editTishi").text("修改成功！")
                            var url='${pageContext.request.contextPath}/imfo/internFindAll?pn='+$("#nowPage").val();
                            $(location).attr('href', url);
                        }
                    });

                }else{
                    $("#editTishi").text("请输入为符合要求的数字！")
                }
            }else{
                $("#editTishi").text("请输入为数字！")
            }
        }

        //编辑实习期内容
        function editSalaryImfo() {
            var adaptdata=$("#adaptdata").attr('data-content');
            var graowdata=$("#graowdata").attr('data-content');
            var assidata=$("#assidata").attr('data-content');
            $("#editrong").val(adaptdata);
            $("#editshi").val(graowdata);
            $("#editcheng").val(assidata);
            $("#inFoEdit").modal('show')

        }
        //保存实习期内容
        function editInfoUpdate() {
            var adaptdata=$("#editrong").val();
            var graowdata=$("#editshi").val();
            var assidata=$("#editcheng").val();

            $.post("${pageContext.request.contextPath}/imfo/edtScriptSave",{
                "yi":adaptdata,
                "er":graowdata,
                "san":assidata
            },function (result) {
                if (result==0){
                    $("#editTishi").text("修改失败！")
                }else{
                    $("#editTishi").text("修改成功！")
                    var url='${pageContext.request.contextPath}/imfo/internFindAll?pn='+$("#nowPage").val();
                    $(location).attr('href', url);
                }
            });
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
            <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/imfo/internFindAll?pn=1">实习生培训</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/imfo/jobNeedAll">招聘管理</a></li>
        </ul>
    </div>
    <div id="zhong">
        <table class="table table-striped" id="emps_table">
            <thead>
            <tr>
                <th>实习生Id</th>
                <th>姓名</th>
                <th >
                    <div id="adaptdata" data-toggle="popover" data-placement="top" title="适应期内容" data-content="融入期内容：xxx">
                        适应期进度
                    </div>
                 </th>
                <th>
                    <div id="graowdata" data-toggle="popover" data-placement="top" title="融入期内容" data-content="适应期内容：xxx">
                        融入期进度
                    </div>
                </th>
                <th data-toggle="popover" data-placement="top" data-content="">
                    <div id="assidata" data-toggle="popover" data-placement="top" title="成长期内容" data-content="成长期内容：xxx">
                        成长期进度
                    </div>
                </th>
                <th>
                    <button class="btn btn-info btn-sm" onclick="editSalaryImfo()">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                        编辑实习期内容
                    </button>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <th id="Id_${emp.id}">${emp.id}</th>
                    <th id="name_${emp.id}">${emp.name}</th>
                    <th><label id="adaptPeriod_${emp.id}">${emp.adaptPeriod}</label>%</th>
                    <th><label id="graowPeriod_${emp.id}">${emp.graowPeriod}</label>%</th>
                    <th><label id="assiPeriod_${emp.id}">${emp.assiPeriod}</label>%</th>
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


<%--修改--%>
<!-- Modal -->
<div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editEmpInfo">修改实习期进度（请输入数字1-100）</h4>
            </div>
            <div class="modal-body">
                <%-- 表单--%>
                <form class="form-horizontal">
                    <input type="hidden" value="" id="HidId">
                    <div class="form-group">
                        <input type="hidden" id="editId" value="">
                        <label  class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputEditName"  disabled="disabled" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">适应期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edityi">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">融入期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editer"   >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">成长期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editsan"   >
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" onclick="editUpdate()" class="btn btn-default">保存</button>
                        </div>
                    </div>
                </form>
                <div align="center"><label  class="active"  id="editTishi">编辑实习期进度</label></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%--修改--%>
<!-- Modal -->
<div class="modal fade" id="inFoEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >编辑实习期内容</h4>
            </div>
            <div class="modal-body">
                <%-- 表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">适应期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editrong">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">融入期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editshi">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">成长期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="editcheng">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" onclick="editInfoUpdate()" class="btn btn-default">保存</button>
                        </div>
                    </div>
                </form>
                <div align="center"><label  class="active"  id="editInfoTishi">编辑实习期内容</label></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
