<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding" style="height: 85px;">
        <div class="container-fluid col-lg-9 no-padding" id="searchContainer">
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList" style="display: none">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <input id="monthDate" type="text" class="form-control"/>

                                    <span id="isChoiceDateArea"></span>
                                    <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <span id="searchRadio" onchange="searchRadioChange();">
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" value="1" id="searchRadio1" name="searchRadio" class="form-control" checked="checked">
                                            <span>
                                                <i></i>클립
                                            </span>
                                        </label>
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" value="2" id="searchRadio2" name="searchRadio" class="form-control">
                                            <span>
                                                <i></i>회원
                                            </span>
                                        </label>
                                    </span>
                                    <span id="searchClipArea" onchange="btSearchClick();"></span>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요."></label>
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
            </form>
        </div>

        <div class="col-md-3 no-padding pull-right" id="totalContainer">
            <div id="headerInfo"></div>
        </div>
    </div>
    <!-- tab -->
    <div class="no-padding" id="infoTab">
        <jsp:include page="infoTab.jsp"/>
    </div>
    <!-- //tab -->
</div>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/clip/clipHistoryDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var newSlctType=1;
    $(function(){
        slctType = 99;
        $("#isChoiceDateArea").append(util.getCommonCodeRadio(-1, clip_isChoiceDate));
        $("#searchClipArea").append(util.getCommonCodeSelect(-1, searchClip));

        dateType();
        $('input[id="searchText"]').keydown(function() {
            if (event.keyCode === 13) {
                $("#bt_search").click();
            };
        });

        $("#tab_all").click();

    });

    $(document).on('change', 'input[name="isChoiceDate"]', function(){
        var type = $(this).val();

        if(type != 1){ // 전체
            $("._prevSearch").hide();
            $("._todaySearch").hide();
            $("._nextSearch").hide();
            $("#rangeDatepicker").hide();
        }else{
            $("._prevSearch").show();
            $("._todaySearch").show();
            $("._nextSearch").show();
            $("#rangeDatepicker").show();
        }

        $("#bt_search").click();
    });

    $(document).on('click', '#search_testId', function(){
        $("#bt_search").click();
    });


    function searchRadioChange(){
        newSlctType = $('input[name="searchRadio"]:checked').val();
        $("#searchClipArea").empty();
        if(newSlctType == 1){
            $("#searchClipArea").append(util.getCommonCodeSelect(-1, searchClip));
        }else{
            $("#searchClipArea").append(util.getCommonCodeSelect(-1, searchMember));
        }
    }

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>
