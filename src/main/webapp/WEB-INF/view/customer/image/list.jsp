
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="main-header">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <div class="row col-md-12">
                            <h3 class="title"><i class="fa fa-search"></i>검색</h3>
                            <div>
                                <input type="hidden" name="pageStart" id="pageStart">
                                <input type="hidden" name="pageCnt" id="pageCnt">
                                <span id="search_searchType_aria"></span>
                                <label><input type="text" class="form-control" id="txt_search" name="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!-- //serachBox -->

        <div id="headerTab">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#profileList" role="tab" data-toggle="tab" id="tab_profileList" onclick="onClickHeaderTab(this.id)">프로필</a></li>
                <li><a href="#broadcastList" role="tab" data-toggle="tab" id="tab_broadcastList" onclick="onClickHeaderTab(this.id)">방송방 배경</a></li>
                <%--    TODO 추후 추가
                <li><a href="#castList" role="tab" data-toggle="tab" id="tab_castList" onclick="onClickHeaderTab(this.id)">캐스트</a></li>
                --%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="profileList"><jsp:include page="/WEB-INF/view/customer/image/profileList.jsp"/></div>     <!-- 프로필 -->
                <div class="tab-pane fade" id="broadcastList"><jsp:include page="/WEB-INF/view/customer/image/broadcastList.jsp"/></div>          <!-- 방송방 배경 -->
                <%--    TODO 추후 추가
                <div class="tab-pane fade" id="castList"><jsp:include page="/WEB-INF/view/content/item/castList.jsp"/></div>                       <!-- 캐스트 -->
                --%>
            </div>
        </div>
    </div>
</div>


<!-- 원본 이미지 보기 -->
<div id="imageFullSize"></div>

<div class="main-content" style="margin-top: 3px;">
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        init();
        initEvent();
    });

//=------------------------------ Init / Event--------------------------------------------
    function init() {
        //검색조건 불러오기
        $("#search_searchType_aria").html(util.getCommonCodeSelect(-1, declaration_image_searchType));
    }

    function initEvent(){
        $('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                searchEvent();
            };
        });

        $('#bt_search').click( function() {       //검색
            searchEvent();
        });
    }


//=------------------------------ Option --------------------------------------------

    //Tab 선택시 호출 함수
    function onClickHeaderTab(id){
        var targetName = id.split("_")[1];
        var targetFnc = eval("fnc_"+targetName);

        // 검색조건
        if(targetName == "broadcastList"){
            $("#search_osType_aria").html("");
        }else{
            $("#search_osType_aria").html(util.getCommonCodeSelect(-1, content_platform2));
        }


        // 하위 탭 초기화
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

    function initContentTab(){
        $("[name=main-content-div]").each(function(){
            $(this).find("#contentTab").find(".active").removeClass("active");
            $(this).find(".tab-content").find(".active").removeClass("in").removeClass("active");
        });
    }


    // 검색
    function searchEvent(){
        var selectTabId = $("#headerTab").find(".active").find("a").prop("id").split("_")[1];
        console.log(selectTabId)
        var targetFnc = eval("fnc_"+selectTabId);

        console.log(targetFnc)

        targetFnc.pagingInfo = new PAGING_INFO(0, 1, 24);
        targetFnc.selectMainList();

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

    function handlebarsPaging(targetId, pagingInfo){
        var targetName = targetId.split("_")[0];
        var targetFnc = eval("fnc_"+targetName);

        targetFnc.pagingInfo = pagingInfo;

        targetFnc.initDataTable();
    }

    function fullSize_image(url) {     // 이미지 full size
        console.log(url);
        $("#imageFullSize").html(util.imageFullSize("fullSize_image",url));
        $('#fullSize_image').modal('show');
    }
    function modal_close(){
        $("#fullSize_image").modal('hide');
    }

</script>