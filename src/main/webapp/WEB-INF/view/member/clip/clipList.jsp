<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 클립관리(전체/오늘) -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate" style="display: none;"></span>
        <select id="clipSubjectType" name="clipSubjectType" class="form-control pull-left"></select>
        <span id="select_clipOrderByType" name="select_clipOrderByType" class="pull-left ml5"></span>
        <%--<span class="pull-right">--%>
            <%--<div class="pull-left" style="width:30px; height:30px; background-color: #dae3f3; border:1px solid #cccccc;"></div>--%>
            <%--<div class="pull-left pl10 pt5" style="width:105px; height:30px; border:1px solid #cccccc; border-left-width: 0px;">테스트 아이디</div>--%>
        <%--</span>--%>
        <span id="clip_summaryArea"></span>
        <table id="clip_history_list_info" class="table table-sorting table-hover table-bordered">
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

<!-- 팬보드 댓글 보기 -->
<div class="modal fade" id="clipReplyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content">
            <div class="modal-header no-padding">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body" style="display: table">
                <div class="col-md-12 no-padding" id="div_reply">
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/dataTablesSource/clip/clipHistoryDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>


<script type="text/javascript">
    var beforeOrderByType = 0;
    var beforeClipSubjectType = -1;

    $(document).on('change', "#clipSubjectType, #clipOrderByType", function(){
        beforeOrderByType = $("#clipOrderByType").val();
        beforeClipSubjectType = $("#clipSubjectType").val();
        dtList_info_detail.reload(selectCallback_clipHistoty);
    });

    $(function(){

    });

    function initClipHistory(){
        beforeOrderByType = 0;
        beforeClipSubjectType = -1;
        $("#clipOrderByType").val("0");
        $("#clipSubjectType").val("-1");
    }

    function getHistory_clipList(tmp){
        $("#select_clipOrderByType").html(util.getCommonCodeSelect(beforeOrderByType, clip_orderByType_memberDetail));
        getClipSubjectTypeCodeDefine();
        initDataTable_clipHistory(tmp);
    }

    function initDataTable_clipHistory(tmp) {
        if(common.isEmpty(memNo)){
            return;
        }

        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = ClipHistoryDataTableSource.list;

        //=---------- Main DataTable ----------
        var dtList_info_detail_data = function (data) {
            data.orderByType = Number($("#clipOrderByType").val());
            data.subjectType = Number(common.isEmpty($("#clipSubjectType").val()) ? "-1" : $("#clipSubjectType").val());
            data.targetMemNo = memNo;
        };

        dtList_info_detail = new DalbitDataTable($("#clip_history_list_info"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(selectCallback_clipHistoty);

        //---------- Main DataTable ----------=
    };

    function selectCallback_clipHistoty(data){
        if(data.result == "fail"){
            return;
        }

        // 탭 우측 총 건수 추가
        var text = "<span style='color: black;'>클립 누적등록 수 :</span>" +
            "<span style='color: darkblue; font-weight: bold; '> " +  common.addComma(data.pagingVo.totalCnt) + " 건</span>" +
            "<span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>" +
            "<span style='color: blue; font-weight: bold; '>남성 : " +  common.addComma(data.summary.manTotalCnt) + " 건, </span>" +
            "<span style='color: red; font-weight: bold; '>여성 : " +  common.addComma(data.summary.femaleTotalCnt) + " 건, </span>" +
            "<span style='color: black; font-weight: bold; '>알수없음 : " +  common.addComma(data.summary.unknownTotalCnt) + " 건</span>";
        $("#headerInfo").html(text);
        $("#headerInfo").show();

        var data = {
            subjectType : Number(common.isEmpty($("#clipSubjectType").val()) ? "-1" : $("#clipSubjectType").val())
            ,memNo : memNo
        };
        util.getAjaxData("selectReply", "/rest/clip/history/member/list/summary", data, clip_tableSummary_table);
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
        if(confirm("클립 숨기기를 하는 경우 어드민에서 확인되지만 리스트에서는 본인외 타인에게 확인되지 않습니다. \n\n해당 클립을 숨기기 하시겠습니까?")){
            var data = {
                "castNo" : clipNo
                , "hide" : hide
            }
            util.getAjaxData("isHide", "/rest/clip/history/updateHide", data , fn_ClipUpdateHide_success, fn_fail)
        }
    }

    function fn_ClipUpdateHide_success(dst_id, response){
        alert(response.message);
        dtList_info_detail.reload(selectCallback_clipHistoty);
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

    var clipInfoData = "";
    function fn_detailInfo_select_success(dst_id, response, dst_params) {
        clipInfoData = response.data;
        openClipReportPopup();
    }

    //클립 신고 팝업 오픈
    function openClipReportPopup(){
        var report = "/member/member/popup/reportPopup?"
            + "memNo=" + encodeURIComponent(clipInfoData.cast_mem_no)
            + "&memId=" + encodeURIComponent(clipInfoData.cast_userId)
            + "&memNick=" + encodeURIComponent(common.replaceHtml(clipInfoData.cast_nickName))
            + "&memSex=" + encodeURIComponent(clipInfoData.cast_memSex)
            + "&deviceUuid=" + clipInfoData.cast_deviceUuid
            + "&ip=" + clipInfoData.cast_ip
            + "&fnCallBack=getMemNo_info_reload_clipList";

        util.windowOpen(report,"750","910","clipReport");
    }

    // 클립 신고 팝업 완료 콜백 함수
    function getMemNo_info_reload_clipList(memNo){
        if(!common.isEmpty(clipInfoData)){
            var data = Object();
            data.memNo = clipInfoData.cast_mem_no;
            data.cast_no = clipInfoData.castNo;
            data.editSlct = 4;
            data.state = 5;
            data.sendNoti = 1;

            editClipDetailData(data, false);
        }
        getMemNo_info_reload(memNo);

        dtList_info_detail.reload(selectCallback_clipHistoty, false);
    }

    //클립 삭제 이벤트
    function deleteClip(clipNo) {
        console.log(clipNo)
        if(confirm("해당 클립을 삭제 하시겠습니까?")){
            var data = Object();
            data.memNo = clipInfoData.cast_mem_no;
            data.cast_no = clipNo;
            data.editSlct = 4;
            data.state = 5;
            data.sendNoti = 1;

            editClipDetailData(data);
        }
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

    //클립 수정
    var isAlertShow = true;
    function editClipDetailData(data, isAlert){
        isAlertShow = true;
        if(!common.isEmpty(isAlert)){
            isAlertShow = isAlert
        }

        util.getAjaxData("clipDetailInfoEdit", "/rest/clip/history/info/edit", data, fn_detailInfo_Edit_success);
    }

    function fn_detailInfo_Edit_success(dst_id, response, dst_params) {
        dtList_info_detail.reload(selectCallback_clipHistoty, false);
        if(isAlertShow){alert(response.message)};
    }


    function fn_ClipDelete_success(dst_id, response){
        alert(response.message);
        dtList_info_detail.reload(selectCallback_clipHistoty);
    }



    // 댓글 목록 리스트
    $(document).on('click', '._selectReply', function() {
        if($(this).data('reply') == 0) {
            alert('해당 클립에는 등록된 댓글이 없습니다.');
        } else if($(this).data('reply') > 0) {
            var data = {
                'targetClipNo' : $(this).data('cast_no')
            };
            util.getAjaxData("selectReply", "/rest/clip/history/reply/list", data, fn_success_selectReply);
        }
    });

    function fn_success_selectReply(dst_id, response) {

        $('#div_reply').empty();
        for(var i=0 ; i<response.data.length; i++){
            var tmp = '<div class="col-md-12 no-padding" style="margin-bottom: 10px;">';
            tmp +=    '<div class="col-md-2">';
            tmp +=      '<form id="profileImg' + i + '" method="post" enctype="multipart/form-data">';
            tmp +=          '<img class="pull-right" id="image_section' + i + '" src="" alt="your image" style="width: 40px;height: 40px"/>';
            tmp +=      '</form>';
            tmp +=     '</div>';
            tmp +=     '<div class="col-md-10">';
            if(response.data[i].status == "2"){
                tmp +=      '<i class="fa fa-lock" style="padding-left: 3px;padding-right: 3px"></i>';
            }
            tmp +=      '<label id="nickName' + i + '"></label>';
            tmp +=      '<label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp +=      '<lable id="contents' + i + '"></label><br>';
            tmp +=     '</div>';
            tmp +=     '</div>';


            console.log(tmp)
            $('#div_reply').append(tmp);

            $('#nickName' + i).text(response.data[i].memNick);
            $('#userId' + i).text(response.data[i].memNo);
            $('#writeDateFormat' + i).text(response.data[i].writeDate);
            $('#contents' + i).text(response.data[i].contents);
            $('#image_section' + i).prop("src" ,common.profileImage(PHOTO_SERVER_URL,response.data[i].profileImage,memSex));

            $('#clipReplyModal').modal("show");
        }
    }


    function clip_tableSummary_table(dst_id, response){
        var template = $("#clip_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : response.data
        };
        var html = templateScript(data);
        $("#clip_summaryArea").html(html);

        ui.paintColor();
    }

</script>


<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>


<script id="clip_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" id="declarationSummary" style="width: 500px;">
        <thead>
        <tr>
            <th colspan="5" class="_bgColor" data-bgcolor="#8faadc">총 합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">청취자</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">청취수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">선물 건</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">받은 별</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">좋아요</th>
        </tr>
        </thead>
        <tbody>
            <td>{{addComma content.listenerCnt}} 명</td>
            <td>{{addComma content.countPlay}} 건</td>
            <td>{{addComma content.countGift}} 건</td>
            <td>{{addComma content.countByeol}} 별</td>
            <td>{{addComma content.countGood}} 개</td>
        </tbody>
    </table>
</script>
