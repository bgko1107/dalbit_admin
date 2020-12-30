<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_chatNo = request.getParameter("chatNo");
%>

<div class="col-md-12 no-padding">
    <div class="widget-content">
        <div class="widget-content mt10 col-md-12 no-padding">
            <table class="table table-sorting table-hover table-bordered">
                <tr>
                    <th>우체통No</th>
                    <td></td>
                </tr>
                <tr>
                    <th rowspan="2">대화참여자 (2명)</th>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
        </div>

        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                            <jsp:include page="../../../searchArea/daySearchFunction.jsp"/>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <jsp:include page="../../../searchArea/dateRangeSearchArea.jsp"/>
                            <input type="hidden" name="startDate" id="startDate">
                            <input type="hidden" name="endDate" id="endDate" />

                            <%--<input name="startDate" id="startDate">--%>
                            <%--<input name="endDate" id="endDate" />--%>

                            <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            <a href="javascript://" class="_prevSearch">[이전]</a>
                            <a href="javascript://" class="_todaySearch">[오늘]</a>
                            <a href="javascript://" class="_nextSearch">[다음]</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="widget-content mt10 col-md-12 no-padding">
            <table id="list_info" class="table table-sorting table-hover table-bordered">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>기간</th>
                        <th>일시</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody id="tableBody">

                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        slctType = 3;
        dateType();

        var data = new Object();
        data.chatNo = '${param.chatNo}';
        data.startDate = $("#startData").val();
        data.endDate = $("#endData").val();
        data.inner = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
        data.searchText = $("#searchText").val();

        util.getAjaxData("mailboxMsg", "/rest/member/mailbox/msg", data, fn_list_success);
    });

    function fn_list_success(dst_id, response){
        if(response.result == 'success'){
            var template = $('#tmp_list').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html=templateScript(context);
            $("#tableBody").html(html);
        }
    }

</script>

<script id="tmp_list" type="text/x-handlebars-template">
    {{#each this as |user|}}
    <tr>
        <td>{{mem_no}}</td>
        <td>{{msg}}</td>
        <td>{{date}}</td>
        <td>{{last_upd}}</td>
    </tr>
</script>