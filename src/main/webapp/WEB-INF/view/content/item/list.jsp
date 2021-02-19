
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table searchBoxArea">
                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <span id="search_viewOn_aria" onchange="btSearchClick();"></span>
                                <span id="search_osType_aria" onchange="btSearchClick();"></span>
                                <span id="search_searchType_aria" style="display: none"></span>

                                <label><input type="text" class="form-control" id="txt_search" name="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
        <!-- //serachBox -->

        <div id="headerTab">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#chargeList" role="tab" data-toggle="tab" id="tab_chargeList" onclick="onClickHeaderTab(this.id)">충전 아이템</a></li>
                <li><a href="#exchangeList" role="tab" data-toggle="tab" id="tab_exchangeList" onclick="onClickHeaderTab(this.id)">교환 아이템</a></li>
                <li><a href="#giftList" role="tab" data-toggle="tab" id="tab_giftList" onclick="onClickHeaderTab(this.id)">선물 아이템</a></li>
                <li><a href="#quick" role="tab" data-toggle="tab" id="tab_quick" onclick="onClickTab(this.id)">퀵 메시지</a></li>
                <%--    TODO 추후 추가
                <li><a href="#subscribeList" role="tab" data-toggle="tab" id="tab_subscribeList" onclick="onClickHeaderTab(this.id)">구독 아이템</a></li>
                <li><a href="#broadcastList" role="tab" data-toggle="tab" id="tab_broadcastList" onclick="onClickHeaderTab(this.id)">방송 아이템</a></li>
                --%>
            </ul>
            <div class="tab-content no-padding">
                <div class="tab-pane fade active in" id="chargeList"><jsp:include page="/WEB-INF/view/content/item/chargeList.jsp"/></div>     <!-- 충전 아이템 -->
                <div class="tab-pane fade" id="exchangeList"><jsp:include page="/WEB-INF/view/content/item/exchangeList.jsp"/></div>          <!-- 교환 아이템 -->
                <div class="tab-pane fade" id="giftList"><jsp:include page="/WEB-INF/view/content/item/giftList.jsp"/></div>                       <!-- 선물 아이템 -->
                <div class="tab-pane fade" id="quick"><jsp:include page="/WEB-INF/view/content/item/quick.jsp"/></div>                       <!-- 퀵메시지 -->
                <%--    TODO 추후 추가
                <div class="tab-pane fade" id="subscribeList"><jsp:include page="/WEB-INF/view/content/item/subscribeList.jsp"/></div>     <!-- 구독 아이템 -->-
                <div class="tab-pane fade" id="broadcastList"><jsp:include page="/WEB-INF/view/content/item/broadcastList.jsp"/></div>     <!-- 방송 아이템 -->
                --%>
            </div>
        </div>
    </div>
</div>
<div class="main-content" style="margin-top: 3px; display: none;">
    <!-- TAB -->
        <div name="main-content-div" id="chargeListContent"><jsp:include page="detail/chargeTab.jsp"></jsp:include></div>  <!-- 충전 아이템 -->
        <div name="main-content-div" id="exchangeListContent" style="display: none;"><jsp:include page="detail/exchangeTab.jsp"></jsp:include></div>        <!-- 교환 아이템 -->
        <div name="main-content-div" id="giftListContent" style="display: none;"><jsp:include page="detail/giftTab.jsp"></jsp:include></div>                      <!-- 선물 아이템 -->
        <%--    TODO 추후 추가
        <div name="main-content-div" id="subscribeListTab" style="display: none;"><jsp:include page="detail/chargeTab.jsp"></jsp:include></div>         <!-- 구독 아이템 -->
        <div name="main-content-div" id="broadcastListTab" style="display: none;"><jsp:include page="detail/chargeTab.jsp"></jsp:include></div>         <!-- 방송 아이템 -->
        --%>
    <!-- TAB END -->
</div>

<%--<jsp:include page="/WEB-INF/view/common/util/imageModal.jsp"></jsp:include>--%>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        init();
        initEvent();
    });

//=------------------------------ Init / Event--------------------------------------------

    function init() {
        //검색조건 불러오기
        $("#search_viewOn_aria").html(util.getCommonCodeSelect(-1, viewOn, 'N', 'viewYn'));
        $("#search_osType_aria").html(util.getCommonCodeSelect(-1, content_platform2));
        $("#search_searchType_aria").html(util.getCommonCodeSelect(-1, item_searchType));
    }

    function initEvent(){
        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                getItemInfo();
            };
        });

        $('#bt_search').click( function() {       //검색
            getItemInfo();
        });

        $("#btn_changeItem").off("click").on("click", function () { //삭제
            changeItemEvent();
        })
    }


//=------------------------------ Option --------------------------------------------

    //Tab 선택시 호출 함수
    function onClickHeaderTab(id){
        $("#searchForm").show();
        var targetName = id.split("_")[1];
        var targetFnc = eval("fnc_"+targetName);

        // 검색조건
        if(targetName == "exchangeList"){
            $("#search_osType_aria").html("");
        }else{
            $("#search_osType_aria").html(util.getCommonCodeSelect(-1, content_platform2));
        }


        // 하위 탭 초기화
        initContentTab();
        initSelectDataInfo();
        var targetContent = eval($("#"+targetName+"Content"))
        $("[name=main-content-div]").each(function(){
            $(this).find("#contentTab").find(".active").removeClass("active");
            $(this).find(".tab-content").find(".active").removeClass("in").removeClass("active");

            if($(this).attr("id") == targetContent.attr("id")){
                $(this).show();
            }else{
                $(this).hide();
            }
        });
    }

    // Content Tab 선택 초기화
    function initContentTab(){
        $("[name=main-content-div]").each(function(){
            $(this).find("#contentTab").find(".active").removeClass("active");
            $(this).find(".tab-content").find(".active").removeClass("in").removeClass("active");
        });

        $(".main-content").hide();
    }

    function showContentTab(){
        $(".main-content").show();
    }

    // 리플레시
    function changeItemEvent() {
        util.getAjaxData("sendChangeItem", "/rest/content/item/sendChangeItem", null, fn_changeItem_success, fn_fail);
    };

    // 리플레시 성공 시
    function fn_changeItem_success(dst_id, data, dst_params){
        alert(data.message);
    };


    // Ajax 실패
    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    // 검색
    function getItemInfo(){
        var selectTabId = $("#headerTab").find(".active").find("a").prop("id").split("_")[1];
        console.log(selectTabId);
        if(selectTabId != "quick"){
            console.log(selectTabId);
            var targetFnc = eval("fnc_"+selectTabId);

            console.log(targetFnc);
            console.log(targetFnc.dtList_info.dataTableSource);

            /* 엑셀저장을 위해 조회조건 임시저장 */
            // tmp_search = $('#txt_search').val();
            // tmp_gubun = $("select[name='selectGubun']").val();

            // targetFnc.dtList_info.reload();
            console.log(targetFnc.dtList_info);
            targetFnc.selectMainList();
        }else{
            if(selectTabId == "quick"){
                fnc_quick();
            }
        }


        /*검색결과 영역이 접혀 있을 시 열기*/
        ui.toggleSearchList();
    }

        // /*=---------- 엑셀 ----------*/
        // $('#excelDownBtn').on('click', function(){
        //     var formElement = document.querySelector("form");
        //     var formData = new FormData(formElement);
        //
        //     formData.append("search", tmp_search);
        //     formData.append("date", tmp_date);
        //     formData.append("gubun", tmp_gubun);
        //     formData.append("checkDate", tmp_checkDate);
        //     formData.append("stDate", tmp_stDate);
        //     formData.append("edDate", tmp_edDate);
        //     /*formData.append("test003", "test003");*/
        //     excelDownload($(this), "/rest/member/member/listExcel", formData, fn_success_excel, fn_fail_excel)
        // });

        // $("#excelBtn").on("click", function () {
        //     $("#list_info").table2excel({
        //         exclude: ".noExl",
        //         name: "Excel Document Name",
        //         filename: "report" +'.xls', //확장자를 여기서 붙여줘야한다.
        //         fileext: ".xls",
        //         exclude_img: true,
        //         exclude_links: true,
        //         exclude_inputs: true
        //     });
        // });
        //
        // function fn_success_excel(){
        //     console.log("fn_success_excel");
        // }
        //
        // function fn_fail_excel(){
        //     console.log("fn_fail_excel");
        // }
        /*----------- 엑셀 ---------=*/

    var choiceDataInfo = null;
    function initSelectDataInfo() {
        choiceDataInfo = {};
    }

    function setSelectDataInfo(key, data){
        if(common.isEmpty(choiceDataInfo)){
            initSelectDataInfo();
        }
        choiceDataInfo[key] = data;
    }

    function getSelectDataInfo() {
        if(common.isEmpty(choiceDataInfo) || jQuery.isEmptyObject(choiceDataInfo)){
            return null;
        }

        return choiceDataInfo;
    }

    function getImg(targetId) {
        var target = $("#"+targetId);

        if(target.length <= 0 || target.val().length <= 0){
            alert("이미지 URL을 확인하여 주시기 바랍니다.");
            return false;
        }

        var imgUrl = target.val();
        $("#"+targetId+"Viewer").attr("src", imgUrl);
        $("#"+targetId+"Viewer").attr("onerror", "imgError(this.src)");
    }

    function imgError(imgURL) {
        if(imgURL.length > 0){
            alert("이미지 URL이 정상적이지 않습니다.\n입력 URL :" + imgURL);
        }
    }

    function onClickTab(id){
        if(id == "tab_quick"){
            $("#searchForm").hide();
            fnc_quick();
        }
    }

    function btSearchClick(){
        $("#bt_search").click();
    }


</script>