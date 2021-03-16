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
                                <div>
                                    <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                    <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <input id="onedayDate" type="text" class="form-control" >
                                <input id="monthDate" type="text" class="form-control" >

                                <input type="hidden" name="startDate" id="startDate">
                                <input type="hidden" name="endDate" id="endDate" />

                                <%--<input name="startDate" id="startDate">--%>
                                <%--<input name="endDate" id="endDate" />--%>
                                <span id="searchMemberArea"></span>
                                <label><input type="text" class="form-control" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                <a href="javascript://" class="_prevSearch">[이전]</a>
                                <a href="javascript://" class="_todaySearch">[오늘]</a>
                                <a href="javascript://" class="_nextSearch">[다음]</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="col-md-4 no-padding" id="div_minigameHistorySummury" style="display: none">
                <table class="table table-bordered _tableHeight" data-height="23px">
                    <colgroup>
                        <col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/><col width="20%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="_bgColor" data-bgcolor="#bfbfbf">게임 진행 횟수<br/>(참여인원)</th>
                        <th class="_bgColor" data-bgColor="#bfbfbf">달(소진)</th>
                        <th class="_bgColor" data-bgColor="#f8cbad">유료</th>
                        <th class="_bgColor" data-bgColor="#b4c7e7">무료</th>
                        <th class="_bgColor" data-bgcolor="#bfbfbf">등록건수(총합)</th>
                    </tr>
                    </thead>
                    <tbody id="historyTableBody"></tbody>
                </table>
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

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    $(document).ready(function() {
        $("#gameHistorySortArea").html(util.getCommonCodeSelect(0, game_history_sort));

        slctType = 1;
        dateType();
    });

    // thumbnail 명칭 겹쳐서 thumbnailImg 로 세팅
    var xOffset = 10;
    var yOffset = 30;
    var height = 0;
    $(document).on("mouseover",".thumbnailImg",function(e){ //마우스 오버
        if(common.isEmpty($(this).attr("src"))){
            return;
        }
        $("body").append("<p id='preview'><img id='previewImage' src='"+ $(this).attr("src") +"' width='300px' /></p>"); //이미지

        $("#previewImage").load(function () {
            height = $(this).height();
        });

        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");
    });
    $(document).on("mousemove",".thumbnailImg",function(e){ //마우스 이동
        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px");
    });
    $(document).on("mouseout",".thumbnailImg",function(){ //마우스 아웃
        $("#preview").remove();
    });

</script>

<script id="tmp_historyTableBody" type="text/x-handlebars-template">
    <tr>
        <td>{{addComma totalGoCnt}}</td>
        <td>{{addComma totalPayAmt}}</td>
        <td>{{addComma payCnt}}</td>
        <td>{{addComma freeCnt}}</td>
        <td>{{addComma totalCnt}}</td>
    </tr>
</script>