<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding">
        <div class="container-fluid col-lg-12 no-padding" id="searchContainer">
            <form id="searchForm">
                <div class="col-lg-8 form-inline no-padding">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <input id="onedayDate" type="text" class="form-control" style="width: 196px;"/>
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" id="searchText" name="searchText" placeholder="검색할 정보를 입력하세요" style="display: none"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                    <span id="searchCheck">
                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_testId" id="search_testId" value="1">
                                            <span>테스트 아이디 제외</span>
                                        </label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="col-lg-4 no-padding">
                    <div class="col-lg-11 no-padding pull-right">
                        <span id="levelSummary"></span>
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


<script type="text/javascript">

    $(function(){
        slctType = 0;
        dateType();

        $(document).on('click', '#search_testId', function(){
            $("#bt_search").click();
        });
    });


    function levelSummary(data){
        var template = $('#tmp_levelSummary').html();
        var templateScript = Handlebars.compile(template);
        var context = data.summary;
        var html = templateScript(context);
        $("#levelSummary").html(html);
        ui.paintColor();
    }

    function preview(imageType){
        var imageUrl = imageType == "pc" ? $("#txt_pcImage").val() : $("#txt_mobileImage").val() ;
        $("#imageFullSize").html(util.imageFullSize("fullSize_background", imageUrl));
        $("#fullSize_background").modal('show');
    }


    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "detail_paginate_top" || targetId == "detail_paginate") {
            detailPagingInfo = pagingInfo;
            getDetailList(pagingInfo.pageNo);
        }
    }


</script>



<script type="text/x-handlebars-template" id="tmp_levelSummary">
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1"></th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">당첨인원</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">지급달</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">5레벨</th>
            <td>{{addComma level5Cnt}}</td>
            <td>{{addComma dal5Cnt}}</td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">10레벨</th>
            <td>{{addComma level10Cnt}}</td>
            <td>{{addComma dal10Cnt}}</td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">총계</th>
            <td>{{addComma totalCnt}}</td>
            <td>{{addComma totalDal}}</td>
        </tr>
    </table>
</script>
