<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <div class="col-lg-12 form-inline no-padding">
            <div class="col-md-8 no-padding">
                <div class="widget widget-table searchBoxArea">
                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                            </th>
                            <th id="th_bottonList">
                                <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <label><input type="text" class="form-control" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- //serachBox -->
        <!-- tab -->
        <div class="col-lg-12 form-inline no-padding">
            <jsp:include page="tabList.jsp"/>
        </div>
        <!-- //tab -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript" src="/js/dataTablesSource/event/ggamggameDataTableSource.js?${dummyData}"></script>

<script type="text/javascript">

    $(document).ready(function() {
        slctType = 99;
        dateType();
    });

</script>