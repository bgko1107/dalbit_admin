<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="../../include/header.jsp"%>
</head>
<body>

<div id="wrapper">

    <%@include file="../../include/navigation.jsp"%>

    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">방송기록</h1>
                </div>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div>
                                <button type="button" class="btn btn-default">선택삭제</button>

                                <button type="button" class="btn btn-default">Excel 출력</button>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><label>
                                                    <input type="checkbox" value="">NO
                                                </label>
                                            </th>
                                            <th>Name</th>
                                            <th>NickName</th>
                                            <th>PhoneNum</th>
                                            <th>Email</th>
                                            <th>JoinDate</th>
                                            <th>BirthDate</th>
                                            <th>Live</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableBody">

                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="/template/js/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/template/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/template/js/metisMenu.min.js"></script>

<!-- DataTables JavaScript -->
<script src="/template/js/dataTables/jquery.dataTables.min.js"></script>
<script src="/template/js/dataTables/dataTables.bootstrap.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/template/js/startmin.js"></script>
<script src="/js/handlebars-v4.7.2.js"></script>
<script src="/js/common.js"></script>

<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
    $(document).ready(function() {
        getAjaxData("list", "/rest/member/list", "", fn_success, fn_fail);
    });


    function fn_success(dst_id, response){
        dalbitLog(response);

        var template = $('#tmp_list').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        console.log(html)

        $("#tableBody").append(html);

        $('#dataTables-example').DataTable({
            responsive: true
        });
    }

    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }
</script>

<script id="tmp_list" type="text/x-handlebars-template">
    {{#data}}
        <tr>
            <td>
                <label>
                    <input type="checkbox" value="">{{NO}}
                </label>
            </td>
            <td>{{Name}}</td>
            <td>{{NickName}}</td>
            <td >{{PhoneNum}}</td>
            <td>{{Email}}</td>
            <td>{{JoinDate}}</td>
            <td>{{BirthDate}}</td>
            <td>{{Live}}</td>
            <td><label></label>
                <select class="form-control">
                    <option>정상</option>
                    <option>탈퇴</option>
                    <option>정지</option>
                </select>
            </td>
        </tr>
    {{/data}}
</script>

</body>
</html>