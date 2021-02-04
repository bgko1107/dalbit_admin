<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 클립관리(전체/오늘) -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate" style="display: none;"></span>
        <span id="select_clipTypeOpen" name="select_clipTypeOpen" class="pull-left ml5"></span>
        <span id="select_clipConfirmType" name="select_clipConfirmType" class="pull-left ml5"></span>
        <span id="select_clipStateType" name="select_clipStateType" class="pull-left ml5"></span>
        <select id="clipSubjectType" name="clipSubjectType" class="form-control pull-left ml5"></select>
        <span id="select_clipOrderByType" name="select_clipOrderByType" class="pull-left ml5"></span>
        <span class="pull-right">
            <div class="pull-left" style="width:30px; height:30px; background-color: #dae3f3; border:1px solid #cccccc;"></div>
            <div class="pull-left pl10 pt5" style="width:105px; height:30px; border:1px solid #cccccc; border-left-width: 0px;">테스트 아이디</div>
        </span>
        <table id="clip_hot_list_info" class="table table-sorting table-hover table-bordered">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>


<script type="text/javascript">
    var beforeClipTypeOpen = 1;
    var beforeClipStateType = 1;
    var beforeOrderByType = 5;
    var beforeClipSubjectType = -1;

    $(document).on('change', "#clipSubjectType", function(){
        beforeClipTypeOpen = $("#searchTypeOpen").val();
        beforeClipStateType = $("#searchState").val();
        beforeOrderByType = $("#clipOrderByType").val();
        beforeClipSubjectType = $("#clipSubjectType").val();
        // dtList_info.reload(selectCallback_hotHistory, false);
        initDataTable_clipHot();
    });

    $(function(){

    });

    function initClipHotList(){
        beforeClipTypeOpen = 1;
        beforeClipStateType = 1;
        beforeOrderByType = 5;
        beforeClipSubjectType = -1;

        $("#searchTypeOpen").val("1");
        $("#searchState").val("1");
        $("#clipOrderByType").val("5");
        $("#clipSubjectType").val("-1");
    }

    function initClipNewList(){
        beforeClipTypeOpen = 1;
        beforeClipStateType = 1;
        beforeOrderByType = 1;
        beforeClipSubjectType = -1;

        $("#searchTypeOpen").val("1");
        $("#searchState").val("1");
        $("#clipOrderByType").val("1");
        $("#clipSubjectType").val("-1");
    }

    function getClipList(){
        $("#select_clipTypeOpen").html(util.getCommonCodeSelect(beforeClipTypeOpen, clip_typeOpen_select));
        $("#select_clipTypeOpen").hide();
        $("#select_clipStateType").html(util.getCommonCodeSelect(beforeClipStateType, clip_stateType_select));
        $("#select_clipStateType").hide();
        $("#select_clipOrderByType").html(util.getCommonCodeSelect(beforeOrderByType, clip_orderByType_hot));
        $("#select_clipOrderByType").hide();
        getClipSubjectTypeCodeDefine();

        initDataTable_clipHot();
    }

    var dtList_info;
    function initDataTable_clipHot() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.searchTypeOpen = Number($("#searchTypeOpen").val());
            data.searchState = Number($("#searchState").val());
            data.orderByType = Number($("#clipOrderByType").val());
            data.subjectType = Number(common.isEmpty($("#clipSubjectType").val()) ? "-1" : $("#clipSubjectType").val());
        };

        dtList_info = new DalbitDataTable($("#clip_hot_list_info"), dtList_info_data, ClipHistoryDataTableSource.list, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        // dtList_info.createDataTable(selectCallback_hotHistory);
        dtList_info.createDataTable();

        //---------- Main DataTable ----------=
    };

    function selectCallback_hotHistory(data){
        // 탭 우측 총 건수 추가
        var template = $("#tmp_headerInfo_clipHot").html();
        var templateScript = Handlebars.compile(template);

        data.summary.viewCnt = (data.pagingVo.totalCnt - data.summary.delTotalCnt);
        data.summary.memberTotalCnt = (Number(data.summary.manCnt) + Number(data.summary.femaleCnt) + Number(data.summary.unknownCnt));

        var context = data;
        var html = templateScript(context);

        $("#headerInfo").html(html);
        $("#headerInfo").show();
        ui.paintColor();

        $(".top-right").css("padding", "0px");
        $("#clip_hot_list_info_length").css("margin", "0px");
    }

    function getClipSubjectTypeCodeDefine(){
        var data = {};
        data.type="clip_type";
        data.order = "asc";
        data.is_ues = "1";
        util.getAjaxData("codeList", "/common/codeList", data, fn_ClipSubjectTypeCode_success);
    }
    function fn_ClipSubjectTypeCode_success(dst_id, response){
        var allData = {
            sel: ""
            , type: "clip_type"
            , value: "-1"
            , code: "주제(전체)"
            , order: "0"
            , is_use: "1"
        };
        response.data.unshift(allData);

        var template = $("#tmp_codeDefine").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#clipSubjectType").html(html);

        $("#clipSubjectType").val(beforeClipSubjectType);
    }



    //숨기기 기능 이베트
    function updateClipHide(clipNo, hide) {
        var hideType = hide == 0 ? 1 : 0;
        if(confirm("클립 숨기기를 하는 경우 어드민에서 확인되지만 리스트에서는 본인외 타인에게 확인되지 않습니다. \n\n해당 클립을 "+ ((hideType === 1) ? "숨기기" : "숨기기 해제") +" 하시겠습니까?")){
            var data = Object();
            data.cast_no = clipNo;
            data.editSlct = 5;
            data.hide = hideType;
            data.sendNoti = 0;

            editClipDetailData(data);
        }
    }

    function fn_ClipUpdateHide_success(dst_id, response){
        alert(response.message);
        $("#bt_search").click();
    }
    function fn_fail(dst_id, response){
        alert(data.message);
        console.log(data, textStatus, jqXHR);
    };


    // 클립 신고 삭제 이벤트
    function reportDeleteClip(clipNo){
        console.log(clipNo)
        // if(confirm("해당 클립을 삭제 하시겠습니까?")){
            var data = new Object();
            data.cast_no = clipNo;

            util.getAjaxData("clipDetailInfo", "/rest/clip/history/info", data, fn_detailInfo_select_success);
        // }
    }


    //클립 삭제 이벤트
    function deleteClip(clipNo, memNo) {
        console.log(clipNo)
        if(confirm("해당 클립을 삭제 하시겠습니까?")){
            var data = Object();
            data.memNo = memNo;
            data.cast_no = clipNo;
            data.editSlct = 4;
            data.state = 5;
            data.sendNoti = 1;

            editClipDetailData(data);
        }
    }

    var clipInfoData = "";
    function fn_detailInfo_select_success(dst_id, response, dst_params) {
        clipInfoData = response.data;
        openClipReportPopup();
    }

    function fn_ClipDelete_success(dst_id, response){
        alert(response.message);
        $("#bt_search").click();
    }

</script>


<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>

<script type="text/x-handlebars-template" id="tmp_headerInfo_clipHot">
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="11%"/><col width="9%"/><col width="13%"/>
                <col width="11%"/><col width="9%"/><col width="13%"/>
                <col width="11%"/><col width="9%"/><col width="13%"/>
            </colgroup>
            <thead>
            <tr>
                <th colspan="9" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">
                    전체 클립 등록 (본인삭제/운영자삭제) 건 수 : {{addComma pagingVo.totalCnt 'N'}} 건 ( {{addComma summary.delMyselfTotalCnt 'N'}} / {{addComma summary.delAdminTotalCnt 'N'}} 건 )
                    <br><span style="color:yellow"> - 삭제 제외 현재 등록 건 수 : {{addComma summary.viewCnt 'N'}} 건 </span>
                </th>
            </tr>
            <tr>
                <th colspan="3" class="_bgColor" data-bgcolor="#dae3f3">남성</th>
                <th colspan="3" class="_bgColor" data-bgcolor="#fbe5d6">여성</th>
                <th colspan="3" class="_bgColor" data-bgcolor="#FFF2CC">알수없음</th>
            </tr>
            <tr>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록자 수</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">삭제<br>(본인/운영자)</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록자 수</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">삭제<br>(본인/운영자)</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">등록자 수</th>
                <th class="_bgColor" data-bgcolor="#f2f2f2">삭제<br>(본인/운영자)</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{{addComma summary.manTotalCnt 'N'}} 건</td>
                <td>{{addComma summary.manCnt 'N'}} 명</td>
                <td>
                    {{addComma summary.delManTotalCnt 'N'}} 건 <br>( {{addComma summary.delMyselfManTotalCnt 'N'}} / {{addComma summary.delAdminManTotalCnt 'N'}} )
                </td>

                <td>{{addComma summary.femaleTotalCnt 'N'}} 건</td>
                <td>{{addComma summary.femaleCnt 'N'}} 명</td>
                <td>
                    {{addComma summary.delFemaleTotalCnt 'N'}} 건 <br>( {{addComma summary.delMyselfFemaleTotalCnt 'N'}} / {{addComma summary.delAdminFemaleTotalCnt 'N'}} )
                </td>

                <td>{{addComma summary.unknownTotalCnt 'N'}} 건</td>
                <td>{{addComma summary.unknownCnt 'N'}} 명</td>
                <td>
                    {{addComma summary.delUnknownTotalCnt 'N'}} 건 <br>( {{addComma summary.delMyselfUnknownTotalCnt 'N'}} / {{addComma summary.delAdminUnknownTotalCnt 'N'}} )
                </td>
            </tr>
            <tr>
                <td colspan="9" class="_bgColor" data-bgcolor="#f2f2f2">총 등록자 수 : {{addComma summary.memberTotalCnt}} 명</td>
            </tr>
            </tbody>
        </table>
</script>