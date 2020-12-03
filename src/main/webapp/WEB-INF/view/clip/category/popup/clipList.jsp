<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_representClip = request.getParameter("representClip");
%>

<!-- 클립관리 > 클립내역관리 > 클립관리(전체/오늘) -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span>
            · 대표클립은 목록에서 1건만 선택>[대표클립 등록]버튼> 대표클립부분에 데이터 출력가 출력되어 확인 및 저장이 가능합니다.<br/>
            · 추천 목록은 목록에서 제한 없이 추가 선택이 가능>[추천 클립 추가]버튼> 추천 클립부분에 데이터 출력가 출력되어 확인 및 저장이 가능합니다.
        </span><br/>

        <div>
            <div class="col-md-1 no-padding"><select id="recommendClipSubjectType" name="recommendClipSubjectType" class="form-control pull-left ml5" onchange="recommendClipSelect_onChange();"></select></div>
            <span id="recommendClipOrderByType" name="recommendClipOrderByType" class="pull-left ml5" onchange="recommendClipSelect_onChange();"></span>

            <span class="pull-right">
                <button type="button" class="btn-default btn btn-sm" onclick="representClipAdd()" >대표클립등록</button>
                <button type="button" class="btn-default btn btn-sm" onclick="recommendClipAdd();" >추천 클립 추가</button>
            </span>
        </div>
        <table id="clip_history_list_info" class="table table-sorting table-hover table-bordered">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="/js/dataTablesSource/clip/clipHistoryDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var representClip = <%=in_representClip%>;

    $(function (){
        getHistory();

    });
    function getHistory(){
        $("#recommendClipOrderByType").html(util.getCommonCodeSelect(-1, clip_orderByType));

        getRecommendClipSubjectTypeCodeDefine();

        initDataTable_clipHistory();
    }

    var dtList_info_recommendClip;
    function initDataTable_clipHistory() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.subjectType = Number(common.isEmpty($("#recommendClipSubjectType").val()) ? "-1" : $("#recommendClipSubjectType").val());
            data.searchText = $("#searchText").val();
            data.search_testId = $('input[name="search_testId"]').is(":checked") ? "0" : "-1";
            data.orderByType = Number($("#recommendClipOrderByType").find("#clipOrderByType").val());
            data.isChoiceDate = -1;
            data.searchTypeOpen = 1;
            data.searchState = 1;
        };

        dtList_info_recommendClip = new DalbitDataTable($("#clip_history_list_info"), dtList_info_data, ClipHistoryDataTableSource.recommendClip);
        dtList_info_recommendClip.useIndex(true);
        dtList_info_recommendClip.setPageLength(10);
        // dtList_info.usePageLenght(50);
        dtList_info_recommendClip.useCheckBox(true);
        dtList_info_recommendClip.createDataTable();

        //---------- Main DataTable ----------=
    };

    function getRecommendClipSubjectTypeCodeDefine(){
        var data = {};
        data.type="clip_type";
        data.order = "asc";
        data.is_ues = "1";
        util.getAjaxData("codeList", "/common/codeList", data, fn_RecommendClipSubjectTypeCode_success);
    }
    function fn_RecommendClipSubjectTypeCode_success(dst_id, response){
        var allData = {
            sel: ""
            , type: "clip_type"
            , value: "-1"
            , code: "주제(전체)"
            , order: "0"
            , is_use: "1"
        };
        response.data.unshift(allData);

        var template = $("#tmp_recommendClipCodeDefine").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#recommendClipSubjectType").html(html);

        $("#recommendClipSubjectType").val(-1);
    }


    //클립 운영자 인증 요청
    function editClipConfirm(clipNo, confirmData){
        if(confirm("운영자 관리 여부를 수정 하시겠습니까?")) {
            var data = Object();
            data.cast_no = clipNo;
            data.editSlct = 8;
            data.confirm = confirmData === 1 ? 0 : 1;
            data.sendNoti = 0;

            editClipDetailData(data);
        }
    }

    function recommendClipSelect_onChange(){
        dtList_info_recommendClip.reload();
    }

    function representClipAdd(){
        if(dtList_info_recommendClip.getCheckedData().length > 1){
            alert("한 개의 클립만 대표 클립으로 등록이 가능합니다");
            return false;
        }
        for(var i=0;i<dtList_info_recommendClip.getCheckedData().length;i++){
            dtList_info_recommendClip.getCheckedData()[i].represent = '1';
        }
        window.opener.representClipAdd(dtList_info_recommendClip.getCheckedData());
        window.close();
    }

    function recommendClipAdd(){
        for(var i=0;i<dtList_info_recommendClip.getCheckedData().length;i++){
            dtList_info_recommendClip.getCheckedData()[i].represent = '0';
        }
        window.opener.recommendClipAdd(dtList_info_recommendClip.getCheckedData());
        window.close();
    }

</script>


<script id="tmp_recommendClipCodeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>
