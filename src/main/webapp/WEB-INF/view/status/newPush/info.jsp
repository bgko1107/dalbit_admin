<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<style>
    .selectedRow {
        background-color: #007ef9;
        cursor: pointer;
    }

</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid col-lg-12 no-padding">
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">

                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th>
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton"  style="display: none"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                        <div id="div_yearButton" style="display: none"><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>

                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>
                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">

                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;display: none"/>

                                    <input id="yearDate" type="text" class="form-control" style="width: 196px;display: none"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
        <!-- tab -->
        <div class="no-padding" id="infoTab">
            <jsp:include page="infoTab.jsp"/>
        </div>
        <!-- //tab -->
    </div>
</div>

<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/status/pushDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var tabType = <%=in_tabType%>;

    if(!common.isEmpty(tabType)) {
        if (tabType == 0) {
            $('.nav-tabs li:eq(0) a').tab('show');
        } else if (tabType == 1) {
            $('.nav-tabs li:eq(1) a').tab('show');
        } else if (tabType == 2) {
            $('.nav-tabs li:eq(2) a').tab('show');
        } else if (tabType == 3) {
            $('.nav-tabs li:eq(3) a').tab('show');
        } else if (tabType == 4) {
            $('.nav-tabs li:eq(4) a').tab('show');
        } else if (tabType == 5) {
            $('.nav-tabs li:eq(5) a').tab('show');
        }
    }

    $(function(){
        if(!common.isEmpty(tabType)){
            $("#tablist_con li.active a").click();
        }else{
            slctType = 1;
            dateType();
        }

        $('input[id="searchText"]').keydown(function() {
            if (event.keyCode === 13) {
                $("#bt_search").click();
            };
        });
    });

    function getData(){
        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        return data;
    }


    function monthRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }
    function totalRowspan(className){
        $("." + className).each(function() {
            var rows = $("." + className + ":contains('" + $(this).text() + "')");
            if (rows.length > 1) {
                rows.eq(0).attr("rowspan", rows.length);
                rows.not(":eq(0)").remove();
            }
        });
    }

</script>
