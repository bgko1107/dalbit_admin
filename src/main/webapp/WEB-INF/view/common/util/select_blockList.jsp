<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<style>
    .lb_style{
        border: 1px solid #DDDDDD;
        background-color: #DCE6F2;
        height: 34px;
        padding-left: 0px;
        padding-right: 0px;
    }
</style>

<div id="select_blockList">
    <div id="wrapper">
        <div class="modal fade" id="modal_select_block" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="bt_x();">&times;</button>
                    </div>

                    <div class="modal-body" style="height:300px; width:600px;">
                        <form id="blockForm">

                        <div class="row col-lg-12 form-inline">
                            <div class="col-md-12 no-padding">
                                <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
                                        <tr>
                                            <th>차단 유형</th>
                                            <td><span id="modalBlockType"></span></td>
                                        </tr>
                                        <tr>
                                            <th>ip/Uuid</th>
                                            <td><input type="text" class="form-control" id="block_text" name="block_text"></td>
                                        </tr>
                                        <tr>
                                            <th>정지 일 수</th>
                                            <td><span id="modalBlockDay"></span></td>
                                        </tr>
                                        <tr>
                                            <th>신고 메시지</th>
                                            <td colspan="5" style="text-align: left;height: 142px;">
                                                <textarea type="textarea" class="form-control" id="adminMemo" name="adminMemo" style="width: 100%;height: 100%"></textarea>
                                            </td>
                                        </tr>
                                </table>
                            </div>
                        </div>
                        </form>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="ipUuidBlockBtn" data-dismiss="modal">차단</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/code/customer/blockAdmCodeList.js?${dummyData}"></script>
<script>

    var targetId = "select_blockList";

    $(document).ready(function () {
        // $("#"+targetId).find('input[id="modalSearch"]').keydown(function() {
        //     if (event.keyCode === 13) {
        //         getModalUserInfo();
        //     };
        // });
        // <!-- 버튼 -->
        // $("#"+targetId).find('#bt_search').click( function() {       //검색
        //     getModalUserInfo();
        // });
        // <!-- 버튼 끝 -->

        $("#"+targetId).find("#modalBlockType").html(util.getCommonCodeRadio('1', block_blockRadio));
        $("#"+targetId).find("#modalBlockDay").html(util.getCommonCodeRadio('1', block_blockDay, 'Y'));
    });

    var callbackFn;
    function showBlockPop(fn) {
        callbackFn = fn;
        $("#"+targetId).find("#modal_select_block").modal("show");
    }

    function bt_x(){

    }

</script>