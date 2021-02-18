
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
                                <input type="hidden" name="pageStart" id="pageStart">
                                <input type="hidden" name="pageCnt" id="pageCnt">
                                <span id="searchMemberArea" onchange="btSearchClick();"></span>
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
                <li class="active"><a href="#profileList" role="tab" data-toggle="tab" id="tab_profileList" onclick="onClickHeaderTab(this.id)">프로필</a></li>
                <li><a href="#broadcastList" role="tab" data-toggle="tab" id="tab_broadcastList" onclick="onClickHeaderTab(this.id)">방송방 배경</a></li>
                <li><a href="#clipList" role="tab" data-toggle="tab" id="tab_clipList" onclick="onClickHeaderTab(this.id)">클립</a></li>
                <li><a href="#noticeList" role="tab" data-toggle="tab" id="tab_noticeList" onclick="onClickHeaderTab(this.id)">회원공지</a></li>
                <%--<li><a href="#mailbox" role="tab" data-toggle="tab" id="tab_mailbox" onclick="onClickHeaderTab(this.id)">우체통</a></li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="profileList"><jsp:include page="/WEB-INF/view/customer/image/profileList.jsp"/></div>     <!-- 프로필 -->
                <div class="tab-pane fade" id="broadcastList"><jsp:include page="/WEB-INF/view/customer/image/broadcastList.jsp"/></div>           <!-- 방송방 배경 -->
                <div class="tab-pane fade" id="clipList"><jsp:include page="/WEB-INF/view/customer/image/clipList.jsp"/></div>                     <!-- 클립 -->
                <div class="tab-pane fade" id="noticeList"><jsp:include page="/WEB-INF/view/customer/image/noticeList.jsp"/></div>                 <!-- 회원공지 -->
                <%--<div class="tab-pane fade" id="mailbox"><jsp:include page="/WEB-INF/view/customer/image/mailbox.jsp"/></div>                 <!-- 우체통 -->--%>
            </div>
        </div>
    </div>
</div>


<div class="main-content" style="margin-top: 3px;"></div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

        initEvent();
    });

//=------------------------------ Init / Event--------------------------------------------
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

        if(targetName == "mailbox") {
            mailboxImgList();
        }else {
            var targetFnc = eval("fnc_" + targetName);

            // 검색조건
            if (targetName == "broadcastList") {
                $("#search_osType_aria").html("");
            } else {
                $("#search_osType_aria").html(util.getCommonCodeSelect(-1, content_platform2));
            }
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
        if(selectTabId == "mailbox"){
            mailboxImgList();
            mailboxPagingInfo = new PAGING_INFO(0, 1, 24);
        }else{
            var targetFnc = eval("fnc_"+selectTabId);
            targetFnc.pagingInfo = new PAGING_INFO(0, 1, 24);
            targetFnc.selectMainList();
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

    function handlebarsPaging(targetId, pagingInfo){

        console.log("----------------------------- 1");
        if(targetId == "mailboxList_info_paginate_top" || targetId == "mailboxList_info_paginate"){
            mailboxPagingInfo = pagingInfo;
            mailboxImgList(pagingInfo.pageNo);
        }else{
            var targetName = targetId.split("_")[0];
            var targetFnc = eval("fnc_"+targetName);

            targetFnc.pagingInfo = pagingInfo;

            targetFnc.initDataTable();
        }
    }

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

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>