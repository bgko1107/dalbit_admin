<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .lb_style{
        border: 1px solid #DDDDDD;
        background-color: #DCE6F2;
        height: 34px;
        padding-left: 0px;
        padding-right: 0px;
    }
</style>

<div id="select_memberBoostList">
    <div id="wrapper">
        <div class="modal fade" id="modal_select_member" tabindex="-1" role="dialog" aria-labelledby="memberModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="max-width: 100%; width: 70%; display: table;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body" style="height:320px">
                        <!-- serachBox -->
                        <div class="row col-lg-12 form-inline">
                            <div class="col-md-12 no-padding">
                                <div class="widget widget-table searchBoxArea">
                                    <div class="widget-header searchBoxRow">
                                        <h3 class="title"><i class="fa fa-search"></i> 회원 검색</h3>
                                        <div>
                                            <span id="searchType"></span>
                                            <label><input type="text" class="form-control" id="txt_search"></label>
                                            <button type="submit" class="btn btn-success" id="bt_modal_search">검색</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 no-padding">
                                <div class="widget-content">
                                    <table id="modal_member_list_info" class="table table-sorting table-hover table-bordered">
                                        <thead>
                                        </thead>
                                        <tbody id="modalTableBody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- //serachBox -->
                    </div>
                    <div class="modal-footer" style="border-width:0px;">
                        <%--<button type="button" class="btn" data-dismiss="modal">닫기</button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var memberModalId = "select_memberBoostList";

    $(document).ready(function () {
        $("#"+memberModalId).find('input[id="txt_search"]').keydown(function() {
            if (event.keyCode === 13) {
                getModalUserInfo();
            };
        });
        <!-- 버튼 -->
        $("#"+memberModalId).find('#bt_modal_search').click( function() {       //검색
            getModalUserInfo();
        });
        <!-- 버튼 끝 -->

        $("#"+memberModalId).find("#searchType").html(util.getCommonCodeSelect(-1, member_saerch_type));
    });

    var callbackFn;
    var validFn;
    function showPopMemberList(fn, fnIsValid) {
        callbackFn = fn;
        validFn = fnIsValid;
        $("#"+memberModalId).find("#modal_select_member").modal();
    }

    var dtList_modal_info_detail;
    var dtList_info_detail_data = function (data) {
        data.searchType = $("#"+memberModalId).find("select[name='searchType']").val();          // 검색구분
        data.searchText = $("#"+memberModalId).find('#txt_search').val();                        // 검색명
    }


    /**/


    function setModalMemberData(index){
        var data = dtList_modal_info_detail.getDataRow(index);
        // var obj = new Object();
        console.log(data);
        console.log(data.mem_no);

        if(!common.isEmpty(validFn)){
            if(!validFn(data)){
                event.stopPropagation();
                return false;
            }
        }

        //callback
        callbackFn(data);

    }
    function getModalUserInfo() {                 // 검색
        var inputText = $("#"+memberModalId).find('#txt_search').val();

        if(common.isEmpty(inputText)){
            alert("검색어(1자 이상)를 입력하여 주시기 바랍니다.");
            return false;
        }

        if(inputText.length < 1){
            alert("검색어는 최소 1자 이상 입력하여 주셔야 합니다.");
            return false;
        }

        dtList_modal_info_detail = new DalbitDataTable($("#"+memberModalId).find("#modal_member_list_info"), dtList_info_detail_data, UtilDataTableSource.modalMemberBoosterList);
        dtList_modal_info_detail.useCheckBox(false);
        dtList_modal_info_detail.useIndex(true);
        dtList_modal_info_detail.createDataTable();
    }
    function bt_x(){

    };

    $(document).on('click', '#bt_boostAdd', function(){

        var boostCnt = $(this).parent().find('.txt_boostAddCnt');
        var boostPlusMinus = $(this).parent().find('.boostPlusMinus');

        if(common.isEmpty(boostCnt.val())){
            alert('부스터 갯수를 입력해주세요.');
            boostCnt.focus();
            return;
        }else if(isNaN(boostCnt.val())){
            alert('부스터 갯수는 숫자로만 입력해주세요.');
            boostCnt.focus();
            return;
        }

        if(boostPlusMinus.val() == '3' && $(this).data('boostcnt') < Number(boostCnt.val())){
            alert('보유수량보다 많은 수량을 차감할 수 없습니다.');
            return;
        }

        if(boostPlusMinus.val() == '1' && 9999 < Number($(this).data('boostcnt')) + Number(boostCnt.val())){
            alert('아이템 갯수는 9999까지만 가능합니다.');
            return;
        }

        var msg = '부스터 ' + boostCnt.val() +'개를 지급하시겠습니까?';
        var dst_id = 'boostAdd';
        if(boostPlusMinus.val() == '3'){
            msg = '부스터 ' + boostCnt.val() +'개를 차감하시겠습니까?';
            dst_id = 'boostSubtract';
        }

        if(confirm(msg)){
            var data = {
                mem_no : $(this).data('memno')
                , itemType : 1
                , slctType : boostPlusMinus.val()
                , itemCnt : boostCnt.val()
            }

            util.getAjaxData(dst_id, "/rest/member/member/boostItemChange", data, function(dst_id, response){
                var responseMsg = '부스터 ' + boostCnt.val() + '개를 지급하였습니다.';
                if(boostPlusMinus.val() == '3'){
                    responseMsg = '부스터 ' + boostCnt.val() + '개를 차감하였습니다.';
                }
                alert(responseMsg);
                //location.reload();
                getModalUserInfo();
                $("#bt_search").click();
            });
        }
    });

</script>
