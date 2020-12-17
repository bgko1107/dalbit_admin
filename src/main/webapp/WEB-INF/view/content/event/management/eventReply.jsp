<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <!-- DATA TABLE -->
    <div class="row col-lg-12 form-inline">
        <div class="widget widget-table" id="eventReplyDataTable">
            <span id="event_summaryArea"></span>
            <div class="widget-content">
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_reply_delete" style="margin-left: 3px;"/>
    <!-- DATA TABLE END -->
</div>

<form id="noticeForm"></form>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    function initEventReply() {
        initEventReplyDataTable();
        //initEvent();
    };


    var dtList_info= "";
    function initEventReplyDataTable(){
        //=---------- Main DataTable ----------
        var dtList_info_data = function ( data ) {
            data.event_idx = $('#eventidx').val()
        };
        console.log(dtList_info_data)
        dtList_info = new DalbitDataTable($('#list_info'), dtList_info_data, EventDataTableSource.reply);
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(20);

        console.log('createDataTable start');
        dtList_info.createDataTable();
        console.log('createDataTable end');

        //initDataTableButton();
    };


    // DataTable Button
    function initDataTableButton() {
        var deleteReplyBtn = '<input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_reply_delete" style="margin-left: 3px;"/>'
        // var insertNoticeBtn = '<input type="button" value="바로 공지하기" class="btn btn-success btn-sm" id="btn_insertNotice" style="margin-left: 3px;"/>'
        // // var winnerDelBtn = '<input type="button" value="당첨취소" class="btn btn-danger btn-sm" id="btn_winnerDel" style="margin-left: 3px;"/>'
        // var excelBtn = '<button class="btn btn-default print-btn btn-sm" type="button" style="margin-left: 3px;"><i class="fa fa-print"></i>Excel Down</button>'
        //
        //
        divDataTable = $('#eventReplyDataTable').parent("div");
        //
        divDataTable.find(".footer-left").append(deleteReplyBtn);
        // divDataTable.find(".footer-left").append(insertNoticeBtn);
        // // this.divDataTable.find(".footer-right").append(winnerDelBtn);
        // divDataTable.find(".footer-right").append(excelBtn);
    };

    /*initEvent= function(){
        target.find("#btn_reply_delete").on("click", function () { //선택삭제
            deleteReplyEvent();
        });
    };*/

    //선택삭제
    checkDatas= "";
    function deleteReplyEvent() {
        checkDatas = dtList_info.getCheckedData();
        if(checkDatas.length <= 0){
            alert("삭제할 댓글을 선택해주세요.");
            return false;
        }
        if(confirm(checkDatas.length +'건을 삭제하시겠습니까?')) {
            for (var i = 0; i < checkDatas.length; i++) {
                util.getAjaxData('eventReply', "/rest/content/event/reply/delete", checkDatas[i], event_reply_delete_success, event_fail);
            }
        }
    };

    function event_reply_delete_success(dst_id, response){
        if(response.result == "fail"){
            return false;
        }
        dtList_info.reload();
    };
    function event_fail(dst_id, data){
        console.log(data.message);
    };

    $(document).on('click', '#btn_reply_delete', function(){
        deleteReplyEvent();
    });

</script>
