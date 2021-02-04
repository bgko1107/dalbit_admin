<%@ page import="lombok.var" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="row col-lg-12 form-inline" id="winnerApplicant_table">
    <div class="widget widget-table">
        <div class="widget-content">
            <table class="table table-bordered table-summary" id="list_winnerInfo" style="width: 500px">
                <thead></thead>
                <tbody></tbody>
            </table>

            <span id="winner_sortSlct"></span>
            <span id="winner_winSlct"></span>
            <label for="winner_duplicate"><input type="checkbox" id="winner_duplicate" name="winner_duplicate"/> 중복응모 숨기기</label>
            <%-- 0: 다보임, 1: 숨김 --%>

            <table id="list_eventWinnerApplicant" class="table table-sorting table-hover table-bordered">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="widget-footer">
            <span>
                <button class="btn btn-default btn-sm print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
            </span>
        </div>
    </div>
</div>

<div class="row col-lg-12 form-inline mt15 mb15" id="winner_table">
    <div>• 당첨자 리스트</div>
    <div class="widget widget-table">
        <div class="widget-content">
            <div class="mt15" id="winnerArea">
                <div>• 당첨자 추가</div>
                <div id="winnerRegieterArea"></div>
            </div>
            <div class="mb15 mt15 form-inline pull-right" id="reSave">
                <button class="btn btn-default btn-sm mr10" type="button" id="bt_reSaveWinner">재선정</button>
            </div>
            <table id="list_eventWinner" class="table table-sorting table-hover table-bordered">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="widget-footer" id="complete_no">
            <div class="mb15 form-inline pull-left">
                <button class="btn btn-danger btn-sm" type="button" id="bt_cancelEventWinner">당첨 취소</button>
            </div>
            <div class="mb15 form-inline pull-right">
                <button class="btn btn-default btn-sm" type="button" id="bt_completeSaveWinner">선정 완료</button>
            </div>
        </div>
        <div class="widget-footer" id="complete_yes">
            <div class="mb15 form-inline pull-left">
                <button class="btn btn-default btn-sm _bt_complete_yes" type="button" id="bt_sendComplete">발송 완료</button>
            </div>
            <div class="mb15 ml15 form-inline pull-left">
                <button class="btn btn-default btn-sm _bt_complete_yes" type="button" id="bt_depositComplete">입금 확인</button>
            </div>
        </div>
    </div>
</div>
<!-- DATA TABLE END -->

<!-- 댓글, 사진 등 추가 정보 확인 팝업창 -->
<div class="modal fade" id="modal_select_applyAddInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 100%; width: auto;  height: auto; display: table;">
        <div id="applyAddInfoDetail"></div>
    </div>
</div>
<!-- //댓글, 사진 등 추가 정보 확인 팝업창 -->

<!-- 연락처, 신분증 등 추가 정보 확인 팝업창 -->
<div class="modal fade" id="modal_select_winnerAddInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 100%; width: auto;  height: auto; display: table;">
        <div id="winnerAddInfoDetail"></div>
    </div>
</div>
<!-- //연락처, 신분증 등 추가 정보 확인 팝업창 -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var sortSlct = 0;
    var winSlct = 0;
    var duplicateHide = 0;
    function initWinnerApplicant() {
        // 응모자/당첨자 정보
        winnerInfo();

        $('#winner_sortSlct').html(util.getCommonCodeSelect(0, event_winnerSortSlct));
        $('#winner_winSlct').html(util.getCommonCodeSelect(0, event_winnerWinSlct));

        applicantList();

        $('#sortSlct').on('change', function() {
            sortSlct = $('select[name="sortSlct"]').val();
            applicantList(sortSlct, winSlct, duplicateHide);
        });
        $('#winSlct').on('change', function() {
            winSlct = $('select[name="winSlct"]').val();
            applicantList(sortSlct, winSlct, duplicateHide);
        });
        $('#winner_duplicate').on('change', function() {
            duplicateHide = $('input[name="winner_duplicate"]').is(":checked") ? "1" : "0";
            applicantList(sortSlct, winSlct, duplicateHide);
        });
    }

    function applicantList(sortSlct, winSlct,duplicateHide) {
        var dtList_info_data = function(data) {
            data.eventIdx = $("#eventidx").val();
            data.sortSlct = sortSlct;
            data.winSlct = winSlct;
            data.duplicateHide = duplicateHide
        };
        var dtList_info = new DalbitDataTable($('#list_eventWinnerApplicant'), dtList_info_data, EventDataTableSource.eventWinnerApplicant);
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();
    }


    var winnerInfoPrizeYn;
    function winnerInfo() {
        var data = {
            eventIdx : $("#eventidx").val()
        };
        util.getAjaxData("eventWinnerInfo", "/rest/content/event/management/winner/info", data, function fn_eventWinnerInfo_success(dst_id, response) {
            var template = $('#tmp_list_winnerInfo').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data.infoList;
            var html = templateScript(context);

            $('#list_winnerInfo').empty().html(html);

            var prizeWinner = 0;
            try{
                prizeWinner = response.data.winnerInfoPrizeYn.prizeWinner;    
            }catch (e) {}

            winnerInfoPrizeYn = common.isEmpty(prizeWinner) ? 0 : prizeWinner;
            var template1 = $('#tmp_winnerRegieterArea').html();
            var templateScript1 = Handlebars.compile(template1);
            var context1 = response.data.infoList;
            var html1 = templateScript1(context1);
            $('#winnerRegieterArea').html(html1);

            // 당첨자 리스트
            winnerList(winnerInfoPrizeYn);
        });
    }


    function winnerList(winnerInfoPrizeYn) {
        var dtList_info_data = function (data) {
            data.eventIdx = $("#eventidx").val();
        };
        var dtList_info_winner = new DalbitDataTable($('#list_eventWinner'), dtList_info_data, EventDataTableSource.eventWinner);
        dtList_info_winner.useCheckBox(true);
        dtList_info_winner.useIndex(false);
        dtList_info_winner.createDataTable();


        if(winnerInfoPrizeYn == 1) {
            // 선정완료돼서 발송완료/입금확인/재선정버튼이 보여야 함
            $('#winnerArea').hide();
            $('#complete_no').hide();

            $('#complete_yes').show();
            $('#reSave').show();
        } else if(winnerInfoPrizeYn == 0) {
            // 선정 중이라서 당첨자추가/선정취소/선정완료가 보여야 함
            $('#winnerArea').show();
            $('#complete_no').show();

            $('#complete_yes').hide();
            $('#reSave').hide();
        }
    }

    $(document).on('click','#bt_registerEventWinner', function() {
        var winnerVal = $('#registerEventWinner').val();
        if(common.isEmpty(winnerVal)) {
            alert('당첨자 회원번호를 입력해주세요.');
            return false;
        }

        if(winnerVal.substr(winnerVal.length-1, 1) == "|") {
            winnerVal = winnerVal.slice(0,-1);
        }

        var winner = winnerVal.split("|");
        var winnerCount = winner.length;

        if(confirm(winnerCount + "건의 당첨자 리스트를 추가하시겠습니까?")) {
            var data = {
                eventIdx : $('#eventidx').val()
                , prizeIdx : $('select[name="prizeRank"]').find('option:selected').data('prizeidx')
                , memNoList : winnerVal
            };
            util.getAjaxData("EventWinnerAdd", "/rest/content/event/management/winner/add", data, function fn_eventWinnerAdd_success(dst_id, response) {
               alert(response.message);
               initWinnerApplicant();
                $('#tab_eventWinnerApplicant').click();
            });
        }
    });

    $('#bt_cancelEventWinner').on('click', function() {
        var checked = $('#list_eventWinner > tbody > tr > td > input[type=checkbox]:checked');

        if(checked.length == 0) {
            alert('당첨 취소할 사항을 선택해주세요.');
            return false;
        }

        if(confirm(checked.length + "건의 사항을 취소하시겠습니까?")) {
            var winnerIdxs = '';
            checked.each(function() {
                winnerIdxs +=  $(this).parent().parent().find('._getWinnerDetail').data('winneridx') + "|";
            });
            if(winnerIdxs.substr(winnerIdxs.length-1, 1) == "|") {
                winnerIdxs = winnerIdxs.slice(0,-1);
            }

            var data = {
                eventIdx : $('#eventidx').val()
                , winnerIdxList : winnerIdxs
            };
            util.getAjaxData("EventWinnerCancel", "/rest/content/event/management/winner/delete", data, function fn_eventWinnerDelete_success(dst_id, response) {
               alert(response.message);
                initWinnerApplicant();
                $('#tab_eventWinnerApplicant').click();
            });
        }

    });

    $('#bt_completeSaveWinner').on('click', function() {
       if(confirm("당첨자 선정을 완료하시겠습니까?")) {
           var data = {
               eventIdx : $('#eventidx').val()
               , completeSlct : 1
           };
           util.getAjaxData("EventWinnerComplete", "/rest/content/event/management/winner/complete", data, function fn_eventWinnerComplete_success(dst_id, response) {
               alert(response.message);
               // 당첨자 발표 탭으로 갈 수 있게 별도 처리
               $('#tab_eventWinnerAnnounce').removeAttr('disabled');
               initWinnerApplicant();
               $('#tab_eventWinnerApplicant').click();
               initDetail();
           });
       }
    });

    $('#bt_reSaveWinner').on('click', function() {
        if(confirm("당첨자를 재선정하시겠습니까?")) {
            var data = {
                eventIdx : $('#eventidx').val()
                , completeSlct : 0
            };
            util.getAjaxData("EventWinnerComplete", "/rest/content/event/management/winner/complete", data, function fn_eventWinnerComplete_success(dst_id, response) {
                //alert(response.message);
                // 당첨자 발표 탭으로 갈 수 없게 별도 처리
                $('#tab_eventWinnerAnnounce').attr('disabled', true);
                initWinnerApplicant();
                $('#tab_eventWinnerApplicant').click();
                initDetail();
            });
        }
    });

    $('._bt_complete_yes').on('click', function() {
        var checked = $('#list_eventWinner > tbody > tr > td > input[type=checkbox]:checked');

        if(checked.length == 0) {
            alert('처리할 사항을 선택해주세요.');
            return false;
        }

        var Idxs = '';
        checked.each(function() {
            Idxs += $(this).parent().parent().find('._getWinnerDetail').data('winneridx') + ",";
        });

        if($(this).prop('id') == 'bt_depositComplete') {
            if(confirm(checked.length + "건의 사항을 입금 확인 처리하시겠습니까?")) {
               var data = {
                   eventIdx : $('#eventidx').val()
                   , winnerIdxs : Idxs
                   , updateSlct : 1
               };
                util.getAjaxData("EventWinnerStateUpdate", "/rest/content/event/management/winner/update", data, fn_eventWinnerUpdate_success);
           }
        } else if($(this).prop('id') == 'bt_sendComplete') {
            if(confirm(checked.length + "건의 사항을 발송 완료 처리하시겠습니까?")) {
                var data = {
                    eventIdx : $('#eventidx').val()
                    , winnerIdxs : Idxs
                    , updateSlct : 2
                };
                util.getAjaxData("EventWinnerStateUpdate", "/rest/content/event/management/winner/update", data, fn_eventWinnerUpdate_success);
            }
        }
    });
    function fn_eventWinnerUpdate_success(dst_id, response) {
        alert(response.message);
        initWinnerApplicant();
        $('#tab_eventWinnerApplicant').click();
    }


    $(document).on('click', '._getAddInfoDetail', function() {
        console.log($(this).data('addidx') + ", " + $(this).data('applyidx') + ", " + $(this).data('memno'));

        var template = $('#tmp_applyAddInfoDetail').html();
        var templateScript = Handlebars.compile(template);
        // var context = response.data;
        // var html = templateScript(context);

        $('#applyAddInfoDetail').html(templateScript);

        $('#modal_select_applyAddInfo').modal('show');
    });


    $(document).on('click', '._getWinnerAddInfoDetail', function() {

        var data = {
            eventIdx : $('#eventidx').val()
            , prizeIdx : $(this).data('prizeidx')
            , winner_mem_no : $(this).data('memno')
        };
        console.log(data);
        util.getAjaxData("getWinnerAddInfoDetail", "/rest/content/event/management/winner/winnerAddInfoDetail", data,  function fn_winnerAddInfoDetail_success(dst_id, response) {
            if(common.isEmpty(response.data)){
                alert('당첨자가 추가 정보를 입력하지 않았습니다.');
                return false;
            }
            var template = $('#tmp_winnerAddInfoDetail').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#winnerAddInfoDetail').html(html);

            $('#modal_select_winnerAddInfo').modal('show');
        });
    });



    // /*=---------- 엑셀 ----------*/
    $('#excelDownBtn').on('click', function() {
       var formData = new FormData();
       formData.append("eventIdx", $('#eventidx').val());
       formData.append("sortSlct", $('#sortSlct').val());
       formData.append("winSlct", $('#winSlct').val());
       formData.append("duplicateHide", $('input[name="winner_duplicate"]').is(":checked") ? "1" : "0");

       util.excelDownload($(this), "/rest/content/event/management/winner/listExcel", formData, function fn_success_excel() {
           console.log("fn_success_excel");
       });
    });
    /*----------- 엑셀 ---------=*/

    function photoSubmit(me) {
        var formData = new FormData();
        formData.append('uploadType', 'eventWinner');

        var files = $('#' + $(me).attr('id'))[0].files;
        for(var i=0; i<files.length; i++) {
            console.log(files[i]);
            formData.append('file', files[i]);
        }
        $.ajax({
            url: PHOTO_SERVER_URL + "/upload",
            method: 'POST',
            processData: false,
            contentType: false,
            data: formData,
            success: function (response) {
                // console.log(JSON.parse(response));
                response = JSON.parse(response);
                alert(response.message);
                if (response.result == "success") {
                    me.parent().find('img.thumbnail').attr('src', response.data.url);
                    me.parent().find('input._hidden_filename').val(response.data.path);
                    pathChange();
                }
            },
            error: function (e) {
                console.log(e);
                alert("error : " + e);
            }
        });
    }

    function pathChange() {
        // winnerAddFile1 upload -> done
        if($('#winnerAddFile1').val().indexOf('_1/') >= 0) {
            var data = {
                'tempFileURI' : $('#winnerAddFile1').val()
            };
            util.getAjaxData("winnerAddFile1", PHOTO_SERVER_URL + "/done", data, fn_pathChange_success);
        }

        // winnerAddFile2 upload -> done
        if($('#winnerAddFile2').val().indexOf('_1/') >= 0) {
            var data = {
                'tempFileURI' : $('#winnerAddFile2').val()
            };
            util.getAjaxData("winnerAddFile2", PHOTO_SERVER_URL + "/done", data, fn_pathChange_success);
        }
    }

    function fn_pathChange_success(dst_id, response) {
        $("#"+dst_id).val(response.data.path);
        $("#"+dst_id).parent().find('img.thumbnail').attr('src', response.data.url);
    }


</script>

<script id="tmp_list_winnerInfo" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered mt10">
        <thead>
            <tr class="align-middle">
                {{#each this as |info|}}
                    <th>{{info.prizeRank}}등 ({{info.prizeName}})</th>
                {{/each}}
            </tr>
        </thead>
        <tbody>
            <tr class="align-middle">
                {{#each this as |info|}}
                    <td>{{info.winCnt}} / {{info.prizeCnt}}</td>
                {{/each}}
            </tr>
        </tbody>
    </table>
</script>

<script id="tmp_winnerRegieterArea" type="text/x-handlebars-template">
    <select id="prizeRank" name="prizeRank" class="form-control searchType">
        {{#each this as |info|}}
            {{#equal info.prizeRank '0'}}
            <option data-prizeidx="{{info.prizeIdx}}">일괄지급</option>
            {{else}}
            <option data-prizeidx="{{info.prizeIdx}}">{{info.prizeRank}}등</option>
            {{/equal}}
        {{/each}}
    </select>
    <input type="text" class="form-control _trim" id="registerEventWinner" style="width:50%;" placeholder="여러 회원번호를 업로드할 경우 '|'로 구분해주세요.">
    <button type="button" class="btn btn-default btn-sm mt15 mb15" id="bt_registerEventWinner">당첨자 추가</button>
</script>

<script id="tmp_applyAddInfoDetail" type="text/x-handlebars-template">
    <div class="modal-content" style="width:400px;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="bt_x();">&times;</button>
        </div>
        <div class="modal-body" style="height: 400px;">
            <div class="row col-lg-12 form-inline">
                <div class="widget-content">
                    <table class="table table-sorting table-hover table-bordered no-padding">
                        <tbody id="tableBody">
                        <tr>
                            <th>추가 정보</th>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal-footer">
        </div>
    </div>
</script>


<script id="tmp_winnerAddInfoDetail" type="text/x-handlebars-template">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="layerCloseBtn">&times;</button>
                    <h4 class="modal-title" id="_layerTitle">상세보기</h4>
                </div>
                <div class="modal-body" style="height: 500px; width: 400px;">
                    <form id="winnerDetailForm">
                        <div class="row col-lg-12 form-inline">
                            <div class="widget-content">
                                <table id="list_info" class="table table-sorting table-hover table-bordered">
                                    <tbody id="detail_tableBody">
                                    <tr>
                                        <th>실명</th>
                                        <td>{{winnerName}}</td>
                                    </tr>
                                    <tr>
                                        <th>휴대폰 번호</th>
                                        <td>
                                            {{winnerPhone}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>이메일</th>
                                        <td>
                                            <input type="text" class="form-control" style="width:100%; text-align: center;" value="{{winnerEmail}}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>미성년자 여부</th>
                                        <td>
                                        {{#equal minorYn '1'}}
                                        <span style="color:red">미성년자</span>
                                        {{else}}
                                        -
                                        {{/equal}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>상품수령 주소</th>
                                        <td>
                                            <input type="text" class="form-control" style="width:100%;" value="{{winnerPostCode}}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>상세주소</th>
                                        <td>
                                            <input type="text" class="form-control" style="width:100%;" value="{{winnerAddress1}}"/>
                                            <br/>
                                            <input type="text" class="form-control" style="width:100%;" value="{{winnerAddress2}}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>신분증 사본</th>
                                        <td>
                                            <img src="{{renderImage winnerAddFile1}}" style="max-width:100px; max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                            <%--<input id="file1" type="file" onchange="photoSubmit($(this))">--%>
                                            <%--<input type="hidden" class="_hidden_filename" name="winnerAddFile1" id="winnerAddFile1" value="" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>가족관계 증명서</th>
                                         <td>
                                        {{^equal winnerAddFile2 ''}}
                                            <img src="{{renderImage ../winnerAddFile2}}" style="max-width:100px;max-height:150px;" class="_fullWidth _openImagePop thumbnail" />
                                        {{else}}
                                            -
                                        {{/equal}}
                                            <%--<input id="file2" type="file" onchange="photoSubmit($(this))">--%>
                                            <%--<input type="hidden" class="_hidden_filename" name="winnerAddFile2" id="winnerAddFile2" value="" />--%>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
                </div>
            </div>
        </div>
    </form>
</script>