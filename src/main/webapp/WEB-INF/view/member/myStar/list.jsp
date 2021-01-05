<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<label>ㆍMyStar : 내가 Fan으로 등록하거나, 방송 중 선물을 보낸 회원입니다.<br>ㆍFan: 타 회원이 Fan으로 등록하면 해당회원이 MyStar 가 됩니다.</label>
<div class="widget-content">
    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
        <li class="active"><a href="#mystar" role="tab" data-toggle="tab" id="getHistory_mystarDetail" onclick="getHistory_mystarDetail(this.id);"> My Star </a></li>
        <li><a href="#myfan" role="tab" data-toggle="tab" id="getHistory_myfanDetail" onclick="getHistory_myfanDetail(this.id);"> My Fan </a></li>
        <li><a href="#mynotice" role="tab" data-toggle="tab" id="getHistory_myNoticeDetail" onclick="getHistory_myNoticeDetail(this.id);"> 알림받기 회원 </a></li>
    </ul>
    <div class="tab-content">
        <label><input type="text" class="form-control" id="txt_starFanSearch"></label>
        <button type="submit" class="btn btn-success" id="bt_starFanSearch">검색</button>
        <div class="tab-pane fade in active" id="mystar">
            <div class="widget widget-table" id="mystar_table">
                <div class="widget-content">
                    <div class="col-md-12 no-padding mt10">
                        <span id="liveMystarTotal"></span>
                    </div>
                    <table id="list_mystar" class="table table-sorting table-hover table-bordered datatable">
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="myfan">
            <div class="widget widget-table" id="mysfan_table">
                <div class="widget-content">
                    <div class="col-md-12 no-padding mt10">
                        <span id="liveFanTotal"></span>
                    </div>
                    <table id="list_myfan" class="table table-sorting table-hover table-bordered datatable">
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="mynotice">
            <div class="widget widget-table" id="mynotice_table">
                <div class="widget-content">
                    <div class="col-md-12 no-padding mt10">
                        <span id="liveNoticeTotal"></span>
                    </div>
                    <table id="table" class="table table-sorting table-hover table-bordered datatable">
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
        $('input[id="txt_starFanSearch"]').keydown(function() {
            if (event.keyCode === 13) {
                getHistory_mystarDetail();
            };
        });
        <!-- 버튼 -->
        $('#bt_starFanSearch').click( function() {       //검색
            getHistory_mystarDetail();
        });
        <!-- 버튼 끝 -->
    });

    function getHistory_mystarDetail(tmp) {     // 상세보기
        if(!common.isEmpty(tmp)) {
            if (tmp == "getHistory_mystarDetail") {
                $("#txt_starFanSearch").val("");
            }
        }
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.searchText = $("#txt_starFanSearch").val();
        }
        dtList_info_detail = new DalbitDataTable($("#mystar").find("#list_mystar"), dtList_info_detail_data, MemberDataTableSource.mystar);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(fn_liveMystarTotal);

        // getHistory_myfanDetail();
    }

    var dtList_info_detail2;
    function getHistory_myfanDetail(tmp) {     // 상세보기
        if(!common.isEmpty(tmp)) {
            if (tmp == "getHistory_myfanDetail") {
                $("#txt_starFanSearch").val("");
            }
        }

        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.searchText = $("#txt_starFanSearch").val();
        }
        dtList_info_detail2 = new DalbitDataTable($("#myfan").find("#list_myfan"), dtList_info_detail_data, MemberDataTableSource.myfan);
        dtList_info_detail2.useCheckBox(false);
        dtList_info_detail2.useIndex(true);
        dtList_info_detail2.setPageLength(50);
        dtList_info_detail2.createDataTable(fn_liveFanTotal);
    }

    var dtList_info_detail3;
    function getHistory_myNoticeDetail(tmp) {     // 상세보기
        if(!common.isEmpty(tmp)) {
            if (tmp == "getHistory_myNoticeDetail") {
                $("#txt_starFanSearch").val("");
            }
        }

        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
            data.searchText = $("#txt_starFanSearch").val();
        }
        dtList_info_detail3 = new DalbitDataTable($("#mynotice").find("#table"), dtList_info_detail_data, MemberDataTableSource.mynotice);
        dtList_info_detail3.useCheckBox(false);
        dtList_info_detail3.useIndex(true);
        dtList_info_detail3.setPageLength(50);
        dtList_info_detail3.createDataTable(fn_liveNoticeTotal);
    }

    function fn_liveMystarTotal(json){
        $("#liveMystarTotal").text("현재 등록 My Star : " + json.summary);
    }

    function fn_liveFanTotal(json){
        $("#liveFanTotal").text("현재 등록 My Fan : " + json.summary);
    }

    function fn_liveNoticeTotal(json){
        $("#liveNoticeTotal").text("알림받기 설정 회원 : " + json.summary);
    }

</script>
