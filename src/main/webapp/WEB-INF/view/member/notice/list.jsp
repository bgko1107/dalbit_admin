<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script>
    $(document).ready(function() {
    });

    function getHistory_noticeDetail(tmp) {     // 상세보기
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

        var noteDelBtn = '<input type="button" value="선택삭제" class="btn btn-danger btn-sm" id="btn_noticeDel" style="margin-right: 3px;"/>'
        $("#" + tmp).find("#main_table").find(".footer-left").append(noteDelBtn);
        $("#btn_noticeDel").on("click", function () { //강제퇴장
            notiDelData();
        });
    }

    function notiDelData(){
        var checkDatas = dtList_info_detail.getCheckedData();
        if(checkDatas.length <= 0){
            alert("삭제할 공지사항을 선택해 주십시오");
            return;
        }

        if(confirm("공지를 삭제 하시겠습니까?")) {
            for(var i=0;i<checkDatas.length;i++){
                var data = new Object();
                data.mem_no = memNo;
                data.idx = checkDatas[i].idx;
                data.type = checkDatas[i].type;

                util.getAjaxData("delete", "/rest/member/notice/delete",data, noticeDel_success);
            }
        } return false;
    }

    function noticeDel_success(dst_id, response){
        alert(response.message);
        dtList_info_detail.reload();
    }


</script>
