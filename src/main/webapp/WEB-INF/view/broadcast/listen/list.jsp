<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <span id="listen_summaryArea"></span>
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

<!-- 강제퇴장 Modal -->
<div class="modal fade" id="forcedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 600px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <lable>운영자에 의한 변경 사유를 선택하여 주세요</lable>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <span id="declaration_Message"></span>
                <input type="text" id="forced_message" class="form-control" style="width: 500px"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="bt_modalForced"><i class="fa fa-times-circle"></i> 확인</button>
                <button type="button" class="btn btn-custom-primary" id="bt_modalForcedNotice"><i class="fa fa-check-circle"></i> 확인+메시지 발송</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/message/broadcast/broadCastMessage.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        $("#bt_modalForced").on("click", function () {          //강제퇴장 팝업 알림X
            forced(this.id);
        });
        $("#bt_modalForcedNotice").on("click", function () {    //강제퇴장 팝업 알림O
            forced(this.id);
        });
    });
    var tmp_sortAuth = -1;
    var tmp_forced = "";
    function getBroadHistory_listen(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = BroadcastDataTableSource[tmp];

        if(!common.isEmpty(type) == 1){
            tmp_sortAuth = 0;
        }
        var dtList_info_detail_data = function (data) {
            data.room_no = room_no;
            data.sortAuth = tmp_sortAuth;       // 청취자인지, 퇴장인지, 강퇴인지
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(true);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(listen_summary_table);

        var table_sel = '<span name="state" id="state" onchange="force_sel_change()"></span>';
        var forcedBtn = '<input type="button" value="강제퇴장" class="btn btn-danger btn-sm" id="btn_forced" style="margin-right: 3px;"/>';
        var exitBtn = '<input type="button" value="퇴장" class="btn btn-success btn-sm" id="btn_exit" style="margin-right: 3px;"/>';

        $("#" + tmp).find("#main_table").find(".top-left").addClass("no-padding").append(table_sel);
        $("#" + tmp).find("#main_table").find(".footer-left").append(forcedBtn);
        $("#" + tmp).find("#main_table").find(".footer-left").append(exitBtn);
        $("#state").html(util.getCommonCodeSelect(-1, state));
        forcedEventInit();

        if(!common.isEmpty(type) == 1){
            $("select[name='state']").val(0);
        }
    }

    function force_sel_change(type){
        tmp_sortAuth = $("select[name='state']").val();
        dtList_info_detail.reload(listen_summary_table);
    }
    function listen_summary_table(json){
        var template = $("#listen_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : listen_summary
            , content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#listen_summaryArea").html(html);
    }
    function forcedEventInit(){
        $("#btn_forced").on("click", function () { //강제퇴장
            forcedData("forced");
        });
        $("#btn_exit").on("click", function () { //강제퇴장
            forcedData("exit");
        });
    }
    function forcedData(tmp){
        tmp_forced = tmp;
        if(dtList_info_detail.getCheckedData().length <= 0){
            if(tmp_forced == "forced") {
                alert("강제퇴장자를 선택해 주십시오");
            }else if(tmp_forced == "exit") {
                alert("퇴장자를 선택해 주십시오");
            }
            return;
        }
        if(tmp_forced == "forced") {
            $("#declaration_Message").html(util.getCommonCodeCheck(-1, declaration_Message,"Y"));
        }else if(tmp_forced == "exit") {
            $("#bt_modalForcedNotice").hide();
        }
        $('#forcedModal').modal('show');
    }
    function forced(tmp){
        var sendNoti;
        if(tmp == "bt_modalForced") {    // 강제퇴장 알림X
            sendNoti = 0;
        }else if(tmp == "bt_modalForcedNotice"){      // 강제퇴장 알림O
            sendNoti = 1;
        }

        var forceMessage="";
        $('input:checkbox[name="declaration_Message"]').each(function() {
            if(this.checked){           //checked 처리된 항목의 값
                if(this.id == "declaration_Message99" ){
                    forceMessage = forceMessage + " - " + this.value + " : " + $("#forced_message").val() + "\n";
                }else {
                    forceMessage = forceMessage + " - " + this.value + "\n";
                }
            }
        });
        if($("#declaration_Message99").prop('checked')){
            if($("#forced_message").val().length < 1){
                alert("기타 사유를 입력해주세요");
                return false;
            }
        }
        if(tmp_forced == "exit") {
            forceMessage = $("#forced_message").val();
        }
        if(forceMessage == ""){
            alert("강제 퇴장 사유를 선택해주세요.");
            return;
        }

        if (confirm('강제 퇴장 하겠습니까?')) {
            var date = new Date();
            var timestamp = date.getFullYear() + "-" +
                            common.lpad(date.getMonth() + 1,2,"0") + "-" +
                            common.lpad(date.getDate(),2,"0") + " " +
                            common.lpad(date.getHours(),2,"0") + "." +
                            common.lpad(date.getMinutes(),2,"0") + "." +
                            common.lpad(date.getSeconds(),2,"0");

            var checkDatas = dtList_info_detail.getCheckedData();
            for(var i=0;i<checkDatas.length;i++){
                var memo = broadCastMessage.forceLeaveTitle;
                var memoDetail = broadCastMessage.forceLeave.replace("{{name}}",ADMIN_NICKNAME)
                                                          .replace("{{nickName}}",checkDatas[i].nickName)
                                                          .replace("{{message}}",forceMessage)
                                                          .replace("{{timestamp}}",timestamp);

                var data = new Object();
                data.room_no = room_no;
                data.mem_no = checkDatas[i].mem_no;             // 강퇴 대상
                data.mem_nickName=checkDatas[i].nickName;       // 강퇴 대상
                data.sendNoti = sendNoti;
                data.notiContents = memo;
                if(tmp_forced == "forced") {
                    data.notiMemo = memoDetail;
                }else if(tmp_forced == "exit") {
                    console.log(forceMessage);
                    data.notiMemo = forceMessage;
                }
                data.dj_mem_no = mem_no;
                data.dj_nickname = dj_nickname;
                data.forced = tmp_forced;

                util.getAjaxData("forceLeave", "/rest/broadcast/listener/forceLeave",data, forceLeave_success);
            }
        }else{
            return false;
        }
    }
    function forceLeave_success(dst_id, response){
        $('#forcedModal').modal('hide');
        $('#forced_message').val("");
        dtList_info_detail.reload(listen_summary_table);
    }
</script>

<script id="listen_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right">
        <thead>
        <tr>
            {{#each this.header}}
                <th>{{this.code}}</th>
            {{/each}}
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#equal length '0'}}0{{/equal}}{{content.listenerCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalGuestCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.managerCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.forcedCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalGoodCnt}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalBoosterCnt}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalGiftCnt}}건</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalCompleteMoonCnt}}건</td>
        </tbody>
    </table>
</script>
