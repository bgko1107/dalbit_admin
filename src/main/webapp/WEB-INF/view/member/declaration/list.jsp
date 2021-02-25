<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <span id="declaration_summaryArea"></span>
        <div class="widget-content">
            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="col-md-12 no-padding">
    <jsp:include page="declarationTab.jsp"></jsp:include>
</div>


<script>
    $(document).ready(function() {
    });

    var tmp_slctType = null;
    var tmp_slctReason = -1;
    var tmp_slctPlatform = null;
    function getHistory_declarationDetail(tmp) {     // 상세보기

        tmp_slctType = null;
        tmp_slctReason = -1;
        tmp_slctPlatform = null;

        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        console.log("tmp : " + tmp);
        var source = MemberDataTableSource[tmp];

        var dtList_info_detail_data = function (data) {
            data.searchType = 1;
            data.slctType = tmp_slctType;
            data.slctReason = tmp_slctReason;
            data.searchText = memNo;
            data.strPlatform = tmp_slctPlatform;
            data.slctDateType = 3;
        };
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(true);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable();
        initDataTableTop_select_declaration(tmp);    // 상단 selectBox

        ui.checkBoxInit('list_info_detail');
        var obj = new Object();
        obj.mem_no = memNo;
        util.getAjaxData("summary", "/rest/customer/declaration/opCount_target", obj, declaration_fn_success, fn_fail);
    }
    function initDataTableTop_select_declaration(tmp){
        var topTable = '<span id="search_slct_type_aria" onchange="sel_change_report()"></span>' +
                        '<span name="search_reason_aria_top" id="search_reason_aria_top" onchange="sel_change_report()"></span>' +
                        '<span name="question_platform" id="question_platform" onchange="sel_change_report()"></span>';
        $("#"+tmp).find("#main_table").find(".top-left").addClass("no-padding").append(topTable);
        $("#search_slct_type_aria").html(util.getCommonCodeSelect(-1, declaration_slctType));
        $("#search_reason_aria_top").html(util.getCommonCodeSelect(-1, declaration_reason));
        $("#question_platform").html(util.getCommonCodeSelect(-1, question_platform));
    }

    function sel_change_report(){
        tmp_slctType  = $("select[name='slctType']").val();
        tmp_slctReason = $("select[name='slctReason']").val();
        tmp_slctPlatform  = $("#question_platform").find("select[name='platform']").val();

        console.log(tmp_slctPlatform);

        dtList_info_detail.reload();
    }

    function declaration_fn_success(dst_id, response) {
        var template = $("#tmp_declarationSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : declaration_summary
            , content : response.data
        }
        var html = templateScript(data);
        $("#declaration_summaryArea").html(html);
    }
    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    $(document).on('click', '._getDeclarationDetail', function() {
        $('#tab_memberReport').removeClass("hide");
        var data = {
            'reportIdx' : $(this).data('idx')
        };
        util.getAjaxData("detail", "/rest/customer/declaration/detail", data, fn_detail_success);
    });

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')){
            $(this).parent().parent().find('._getDeclarationDetail').click();
        }
    });

</script>

<script id="tmp_declarationSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right">
        <thead>
        <tr>
            {{#each this.header}}
                <th>{{this.code}}</th>
            {{/each}}
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{addComma content.notOpCnt}}건</td> <%--미처리--%>
            <td>{{addComma content.allOpCnt}}건</td>
            <td>정상: {{addComma content.code_1_Cnt}}건, 경고: {{addComma content.code_2_Cnt}}건, 강제탈퇴: {{addComma content.code_7_Cnt}}건<br/>
                1일: {{addComma content.code_3_Cnt}}건, 3일: {{addComma content.code_4_Cnt}}건, 7일: {{addComma content.code_5_Cnt}}건
            </td> <%--정상--%>
            <td>{{addComma content.code_7_Cnt}}건</td> <%--영구 정지--%>
            <td>{{addComma content.code_6_Cnt}}건</td> <%--영구 정지--%>
        </tbody>
    </table>
</script>