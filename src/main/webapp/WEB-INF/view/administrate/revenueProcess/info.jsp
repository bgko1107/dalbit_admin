<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding">
        <div class="container-fluid">
            <form id="searchForm">
                <div class="row form-inline">
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
                                    <span id="slctTypeArea"></span>

                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">

                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;display: none"/>

                                    <input id="yearDate" type="text" class="form-control" style="width: 196px;display: none"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>

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
    </div>
    <!-- tab -->
    <div class="no-padding" id="infoTab">
        <jsp:include page="infoTab.jsp"/>
    </div>
    <!-- //tab -->
</div>


<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>

<script src="/js/lib/excellentexport.js"></script>

<script type="text/javascript">

    // setTimeDate(dateTime);

    var clickTab = false;

    $(function(){
        slctType = 1;
        dateType();

        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                $("#bt_search").click();
            };
        });
    });

    $(document).on('change', 'input[name="slctType"]', function(){
        radioChange($(this).val());
    });

    function radioChange(val){
        slctType = val;
        $("#div_dayButton").hide();
        $("#div_monthButton").hide();
        $("#div_yearButton").hide();
        $("#onedayDate").hide();
        $("#monthDate").hide();
        $("#yearDate").hide();

        if(slctType == 0){
            $("#div_dayButton").show();
            $("#onedayDate").show();
        }else if(slctType == 1){
            $("#div_monthButton").show();
            $("#monthDate").show();
        }else if(slctType == 2){
            $("#div_yearButton").show();
            $("#yearDate").show();
        }
        setDayButton();
    }

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "byeolAmt_paginate_top" || targetId == "byeolAmt_paginate") {
            byeolAmtPagingInfo = pagingInfo;
            getByeolAmtList(pagingInfo.pageNo);
        }else if(targetId == "dalAmt_paginate_top" || targetId == "dalAmt_paginate") {
            dalAmtPagingInfo = pagingInfo;
            getDalAmtList(pagingInfo.pageNo);
        }else if(targetId == "withdrawalDal_paginate_top" || targetId == "withdrawalDal_paginate") {
            withdrawalDalPagingInfo = pagingInfo;
            getWithdrawalDalList(pagingInfo.pageNo);
        }else if(targetId == "withdrawalByeol_paginate_top" || targetId == "withdrawalByeol_paginate") {
            withdrawalByeolPagingInfo = pagingInfo;
            getWithdrawalByeolList(pagingInfo.pageNo);
        }else if(targetId == "dalSales_paginate_top" || targetId == "dalSales_paginate") {
            dalSalesPagingInfo = pagingInfo;
            getDalbitSalesList(pagingInfo.pageNo);
        }
    }

</script>

