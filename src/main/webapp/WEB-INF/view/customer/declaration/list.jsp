<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
            <div class="col-lg-12 form-inline no-padding">
                <div class="widget widget-table searchBoxArea">

                    <table>
                        <tr>
                            <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                <i class="fa fa-search"></i><br/>검색
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <span id="search_slct_type_aria"></span>
                                <span id="search_reason_aria"></span>
                                <span name="question_platform" id="question_platform"></span>
                                <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
        <!-- //serachBox -->

        <div class="col-md-6 no-padding">
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#report" role="tab" data-toggle="tab"> 회원신고 </a></li>
                <li><a href="/customer/declaration/image">이미지신고</a></li>
            </ul>
        </div>

        <div class="col-md-6 no-padding pull-right">
            <table class="table table-bordered table-summary pull-right no-margin" id="declarationSummary">
                <thead>
                <tr>
                    <th rowspan="2">미처리 건</th>
                    <th colspan="7">제재조치</th>
                    <th rowspan="2">누적 처리 건</th>
                </tr>
                <tr>
                    <th>확인완료 건</th>
                    <th>경고 건</th>
                    <th>1일 건</th>
                    <th>3일 건</th>
                    <th>7일 건</th>
                    <th>영구정지 건</th>
                    <th>강제탈퇴 건</th>
                </tr>
                </thead>
                <tbody id="summaryDataTable">

                </tbody>
            </table>
        </div>

        <!-- DATA TABLE -->
        <div class="col-lg-12 no-padding mt10">
            <div class="widget widget-table">
                <div class="widget-header">
                    <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                </div>
                <div class="widget-content">
                    <table id="list_info" class="table table-sorting table-hover table-bordered">
                        <thead>
                        </thead>
                        <tbody id="tableBody">
                        </tbody>
                    </table>
                    <span>
                        <button class="hidden">111</button>
                    </span>

                </div>
                <div class="widget-footer">
                    <span>
                        <button class="btn btn-success btn-sm print-btn" type="button" id="checkProcBtn"><i class="fa fa-check"></i>선택 처리</button>
                    </span>
                    <span>
                        <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                    </span>
                </div>
            </div>
        </div> <%-- #data table --%>

        <div class="col-lg-12 no-padding mt10">
            <div class="tab-pane fade in active" id="report_tab">
                <!-- 상세 -->
                <jsp:include page="../../customer/declaration/report.jsp"/>
            </div>
        </div>
    </div> <%-- #page-wrapper --%>
</div> <%-- #wapper --%>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/customer/questionCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var dtList_info;

    $(document).ready(function() {

        getReportList();
        ui.checkBoxUnbind('list_info', function(){
            var me = $(this);
            var check = $('#list_info tbody input[type="checkbox"]:not(".disabled")');

            if(check.length == 0){
                alert('목록에 미처리 신고건이 없습니다.');
                return false;
            }

            if(me.prop('checked')){
                check.prop('checked', true);
            }else{
                check.prop('checked', false)
            }
        });
    });

    /** Data Table **/
    var tmp_searchText = null;
    var tmp_searchType = null;
    var tmp_slctType = null;
    var tmp_slctReason = null;
    var tmp_slctPlatform = null;
    function getReportList() {

        util.getAjaxData("summary", "/rest/customer/declaration/opCount", "", function (dst_id, response) {
            var template = $('#tmp_declarationSummary').html();
            var templateScript = Handlebars.compile(template);
            var context = response;
            var html = templateScript(context);

            $("#summaryDataTable").html(html);
        });

        var dtList_info_data = function ( data ) {
            data.searchText = tmp_searchText;
            data.searchType = tmp_searchType;
            data.slctType = tmp_slctType;
            data.slctReason = tmp_slctReason;
            data.strPlatform = tmp_slctPlatform;
        };
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, customerDataTableSource.DeclareList);
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.useInitReload(true);
        dtList_info.setPageLength(10);
        dtList_info.usePageLenght(10);
        dtList_info.createDataTable();

        // 검색조건 불러오기
        $("#search_search_type_aria").html(util.getCommonCodeSelect(-1, declaration_searchType));
        $("#search_slct_type_aria").html(util.getCommonCodeSelect(-1, declaration_slctType));
        $("#search_reason_aria").html(util.getCommonCodeSelect(-1, declaration_reason));
        $("#question_platform").html(util.getCommonCodeSelect(-1, question_platform));

        getDeclareInfo();

    }

    $(".av nav-tabs nav-tabs-custom-colored active").on('click', function() {
        $("#" + $(this).data('id')).addClass('on');
    });

    $('input[id="searchText"]').on('keydown', function(e) {    // textBox 처리
        if(e.keyCode == 13) {
            getDeclareInfo();
        };
    });

    $("#bt_search").on('click', function() {  // 버튼의 클릭이벤트
        getDeclareInfo();
    });

    function getDeclareInfo() {
        tmp_searchText = $('#searchText').val();
        tmp_searchType = $("select[name='searchType']").val();
        tmp_slctType  = $("select[name='slctType']").val();
        tmp_slctReason  = $("select[name='slctReason']").val();
        tmp_slctPlatform  = $("select[name='platform']").val();

        dtList_info.reload();

        /*검색결과 영역이 접혀 있을 시 열기*/
        ui.toggleSearchList();
        $("#declarationForm").empty();

    }

    function getDeclarationDetail(index){
        var data = dtList_info.getDataRow(index);

        var obj = {};
        obj.reportIdx = data.reportIdx;
        obj.rowNum = data.rowNum;

        util.getAjaxData("detail", "/rest/customer/declaration/detail", obj, fn_detail_success);
    }

    $(document).on('click', '#checkProcBtn', function(){
        var checkSelector = $("#list_info tbody input[type='checkbox']:checked");
        var checkedCnt = checkSelector.length;
        if(checkedCnt < 1){
            alert('선택된 신고내용이 없습니다.');
            return false;
        }
        if(confirm(checkedCnt + '건을 확인완료 처리 하시겠습니까?')){

            var reportIdxs = '';
            checkSelector.each(function(){
               var idx = $(this).parent().parent().find('._getDeclarationDetail').data('reportidx');

                reportIdxs += idx + ',';
            });
            var data = {
                reportIdxs : reportIdxs
            }

            util.getAjaxData('multiOperate', '/rest/customer/declaration/multi/operate', data, function(dist_id, response){
                alert(response.message);
                dtList_info.reload(null, false);
            });
        }

    });

    // /*=---------- 엑셀 ----------*/
    $('#excelDownBtn').on('click', function(){

        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        util.excelDownload($(this), "/rest/customer/declaration/listExcel", formData, function(){
            console.log("fn_success_excel");
        })
    });

    $("#excelBtn").on("click", function () {
        $("#list_info").table2excel({
            exclude: ".noExl",
            name: "Excel Document Name",
            filename: "report" +'.xls', //확장자를 여기서 붙여줘야한다.
            fileext: ".xls",
            exclude_img: true,
            exclude_links: true,
            exclude_inputs: true
        });
    });

    /*----------- 엑셀 ---------=*/

</script>

<script id="tmp_declarationSummary" type="text/x-handlebars-template">
    {{#data}}
    <tr>
        <td>{{addComma notOpCnt}}건</td> <%--미처리--%>
        <td>{{addComma code_1_Cnt}}건</td> <%--확인완료--%>
        <td>{{addComma code_2_Cnt}}건</td> <%--경고--%>
        <td>{{addComma code_3_Cnt}}건</td> <%--1일 정지--%>
        <td>{{addComma code_4_Cnt}}건</td> <%--3일 정지--%>
        <td>{{addComma code_5_Cnt}}건</td> <%--7일 정지--%>
        <td>{{addComma code_6_Cnt}}건</td> <%--영구 정지 --%>
        <td>{{addComma code_7_Cnt}}건</td> <%--강제 탈퇴--%>
        <td>{{addComma allOpCnt}}건</td>
    </tr>
    {{/data}}
</script>