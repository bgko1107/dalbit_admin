<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .modal-dialog {
        overflow-y: initial !important
    }
    .modal-body {
        height: 100%;
        overflow-y: auto;
    }
</style>

<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
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

<!-- 팬보드 댓글 보기 -->
<div class="modal fade" id="fanboardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;display: table;">
        <div class="modal-content">
            <div class="modal-header no-padding">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="col-md-12 no-padding" id="div_fanboard" style="margin-bottom: 7px"></div><br/>
                <div class="col-md-12 no-padding" id="div_replyArea"></div>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<div id="imageFullSize_fanboard"></div>

<script>
    $(document).ready(function() {
    });

    function getHistory_fanbroadDetail(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(true);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable();

        var fanboardDelBtn = '<input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_fanboardDel" style="margin-right: 3px;"/>'
        $("#" + tmp).find("#main_table").find(".footer-left").append(fanboardDelBtn);
        $("#btn_fanboardDel").on("click", function () { //강제퇴장
            fanboardDelData();
        });
    }

    function fanboardDelData(){
        var checkDatas = dtList_info_detail.getCheckedData();
        if(checkDatas.length <= 0){
            alert("삭제할 팬보드를 선택해 주십시오");
            return;
        }
        if(confirm("선택하신 팬보드를 삭제 하시겠습니까?")){
            for(var i=0;i<checkDatas.length;i++){
                var data = new Object();
                data.mem_no = memNo;
                data.idx = checkDatas[i].board_no;
                util.getAjaxData("delete", "/rest/member/fanboard/delete",data, fanboardDel_success);
            }
        }else return false;
    }

    function fanboardDel_success(dst_id, response){
        alert(response.message);
        dtList_info_detail.reload();
    }

    function Fanboard(index){
        var data = dtList_info_detail.getDataRow(index);
        if(data.replyCnt > 0){
            var obj = new Object();
            obj.mem_no = memNo;
            obj.board_no = data.board_no;
            // dalbitLog(obj);
            util.getAjaxData("info", "/rest/member/fanboard/replyList", obj, replyList_success, fn_fail);
        }
    }

    function replyList_success(dst_id, response) {
        $('#div_replyArea').empty();
        $('#div_fanboard').empty();

        for(var i=0 ; i<response.data.length; i++){

            if(response.data[i].inner == 1){
                var tmp = '<div class="col-md-12 no-padding bg-testMember" style="margin-bottom: 10px;">';
            }else{
                var tmp = '<div class="col-md-12 no-padding" style="margin-bottom: 10px;">';
            }
            tmp +=    '<div class="col-md-2">';
            tmp +=      '<form id="profileImg' + i + '" method="post" enctype="multipart/form-data">';
            tmp +=          '<img class="pull-right" id="image_section' + i + '" src="" alt="your image" style="width: 60px;height: 60px"/>';
            tmp +=      '</form>';
            tmp +=     '</div>';
            tmp +=     '<div class="col-md-10">';
            tmp +=      '<label id="nickName' + i + '"></label>';
            if(response.data[i].view_yn == "0"){
                tmp +=      '<i class="fa fa-lock" style="padding-left: 3px;padding-right: 3px"></i>';
            }
            tmp +=      '<label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp +=      '<lable id="contents' + i + '"></label><br>';
            tmp +=     '</div>';
            tmp +=     '</div>';
            if(response.data[i].depth == "1"){          // fanboard
                $('#div_fanboard').append(tmp + "<br/>");
            }else{                                      // reply
                $('#div_replyArea').append(tmp);
                $('#image_section' + i).attr('style', "width: 40px;height: 40px");
            }

            $('#nickName' + i).text(response.data[i].nickName);
            $('#userId' + i).text(response.data[i].userId);
            $('#writeDateFormat' + i).text(response.data[i].writeDateFormat);
            $('#contents' + i).text(response.data[i].contents);
            $('#image_section' + i).prop("src" ,common.profileImage(PHOTO_SERVER_URL,response.data[i].profileImage,memSex));

            $('#fanboardModal').modal("show");
        }
    }
</script>
