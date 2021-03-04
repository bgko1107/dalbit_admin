
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
                                <input type="hidden" name="is_view" id="is_view" value="1" />

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
            <div id="bannerList"><jsp:include page="/WEB-INF/view/content/banner/bannerList.jsp"/></div>          <!-- 배너 -->
        </div>
    </div>
</div>
<div class="main-content" style="margin-top: 3px; display: none;">
    <!-- TAB -->
        <div name="main-content-div" id="bannerListContent">
            <jsp:include page="bannerTab.jsp"></jsp:include>
        </div>  <!-- 배너 -->
    <!-- TAB END -->
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        init();
        initEvent();
    });

//=------------------------------ Init / Event--------------------------------------------
    var startDate;
    var endDate;
    function init() {
        //검색조건 불러오기
        $("#search_platformGroup_aria").html(util.getCommonCodeSelect(-1, content_platform2));
        $("#search_bannerType_aria").html(util.getCommonCodeSelect(-1, banner_bannerType, 'N', 'position'));
        /*$("#search_viewOn_aria").html(util.getCommonCodeSelect(-1, viewOn, 'N', 'is_view'));*/

        // init DatePicker
        $('#banner-reportrange').daterangepicker({
                startDate: moment().subtract('days', 29),
                endDate: moment(),
                dateLimit: {days: 60},
                showDropdowns: true,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: false,
                ranges: {
                    '1일': [moment(), moment()],
                    // '어제': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    '7일': [moment().subtract('days', 6), moment()],
                    '30일': [moment().subtract('days', 29), moment()],
                    '이번달': [moment().startOf('month'), moment().endOf('month')],
                    '지난달': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                opens: 'left',
                buttonClasses: ['btn btn-default'],
                applyClass: 'btn-small btn-primary',
                cancelClass: 'btn-small',
                format: 'L',
                separator: ' to ',
                locale: {
                    customRangeLabel: '직접선택',
                }
            },

            function (start, end) {
                console.log("Callback has been called!");
                startDate = start.format('YYYYMMDD');
                endDate = end.format('YYYYMMDD');
                // $('#bannerReportrange span').html(start.format('YYYY.MM.DD') + ' - ' + end.format('YYYY.MM.DD'));
                $('#banner-inputReportrange').attr("startDate", startDate);
                $('#banner-inputReportrange').attr("endDate", endDate);
                $('#banner-inputReportrange').val(start.format('YYYY.MM.DD') + ' - ' + end.format('YYYY.MM.DD'));
            }
        );
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
    }


//=------------------------------ Option --------------------------------------------

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


    // 검색
    function getItemInfo(){
        // var selectTabId = $("#headerTab").find(".active").find("a").prop("id").split("_")[1];
        var selectTabId = "bannerList";
        var targetFnc = eval("fnc_"+selectTabId);

        /* 엑셀저장을 위해 조회조건 임시저장 */
        // tmp_search = $('#txt_search').val();
        // tmp_gubun = $("select[name='selectGubun']").val();

        // targetFnc.dtList_info.reload();
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
    function btSearchClick(){
        $("#bt_search").click();
    }
</script>