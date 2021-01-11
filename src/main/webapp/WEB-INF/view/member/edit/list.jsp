<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="widget-content">
            <div class="pull-right pt5" style="display: none;">
                <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                <button type="button" class="btn btn-success" id="bt_search">검색</button>
            </div>
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

    $("#editHistory").find("#searchText").keydown(function() {
        if (event.keyCode === 13) {
            $("#editHistory").find("#bt_search").click();
        };
    });

    $("#editHistory").find("#bt_search").on("click", function(){
        dtList_info_detail.reload();
    });

    function getHistory_editHistory (tmp, selectType) {     // 상세보기
        // alert(selectType)
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];

        var searchText = "";
        var searchType = "-1";
        if(selectType == 1){
            $("#editHistory").find("#searchText").val("프로필이미지");
            searchType = "1";
        }else if(selectType == 2){
            $("#editHistory").find("#searchText").val("배경이미지");
            searchType = "1";
        }else if(selectType == 3){
            $("#editHistory").find("#searchText").val("프로필메세지");
            searchType = "1";
        }else if(selectType == 4){
            $("#editHistory").find("#searchText").val("프로필이미지|배경이미지|프로필메세지");
            searchType = "2";
        }else if(selectType == 6){
            $("#editHistory").find("#searchText").val("환전");
            searchType = "1";
        }

        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.sortDate = 1;
            data.searchText = $("#editHistory").find("#searchText").val();
            data.searchType = searchType;
            // data.pageCnt=10;
        }

        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable();
    }

</script>
