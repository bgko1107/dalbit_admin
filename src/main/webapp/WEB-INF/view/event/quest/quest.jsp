<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-1 no-padding pull-right">
    <button type="button" class="btn btn-primary pull-right" onclick="questAdd();"><i class="fa fa-search"></i>등록</button>
</div>
<div class="widget-content col-md-12 no-padding">
    <table class="table table-sorting table-hover table-bordered datatable no-margin" id="table_quest_list">
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button type="button" class="btn btn-danger pull-left mb15" id="questDel" onclick="questDel();" >선택 삭제</button>

<!-- 보름달 완성 조건(DJ) -->
<div class="col-md-12 no-padding" id="detailInfo" style="display: none;">
    <span id="questDetail"></span>

    <div class="col-lg-12 form-inline mt15 no-padding">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3>설정상세</h3>
            </div>
            <div class="widget-content mt10">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="2%"/>
                        <col width="4%"/>
                        <col width="4%"/>
                        <col width="9%"/>
                        <col width="4%"/>
                        <col width="3%"/>
                        <col width="7%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="2%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>선택</th>
                        <th>순서변경</th>
                        <th>퀘스트명</th>
                        <th>퀘스트 상세내용</th>
                        <th>하루 최대 수치</th>
                        <th>한달목표</th>
                        <th>보상</th>
                        <th>보상이미지</th>
                        <th>팝업이미지</th>
                        <th>노출여부</th>
                    </tr>
                    </thead>
                    <tbody id="reward_tbody">
                    </tbody>
                </table>
            </div>
            <div class="widget-footer">
                <span>
                    <button class="btn btn-success" type="button" onclick="addReward();">추가</button>
                    <button class="btn btn-danger" type="button" onclick="delReward();">삭제</button>
                    <%--<button class="btn btn-default pull-right" type="button" onclick="rewardOrderUpd();">순서변경</button>--%>
                </span>
            </div>
        </div>
    </div>
    <button class="btn btn-default pull-right" type="button" onclick="questEdit();">저장하기</button>
</div>
<!-- //보름달 완성 조건(DJ) -->

<div class="modal fade" id="questModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <img id="imageViewer" class="thumbnail fullSize_background no-margin no-padding" style="max-width: 1000px;max-height: 1000px;" src="" alt="" /></a>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<script>

    var questIdx = 0;

    var dtList_quest;
    function questList() {

        $("#detailInfo").hide();
        var dtList_info_data = function (data) {
        };
        dtList_quest = new DalbitDataTable($("#table_quest_list"), dtList_info_data, questDataTableSource.questList);
        dtList_quest.useCheckBox(true);
        dtList_quest.useIndex(true);
        dtList_quest.setPageLength(50);
        dtList_quest.createDataTable();
    }

    function questAdd(){
        $("#detailInfo").show();

        questIdx = 0;

        var template = $('#tmp_reward_detail').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#questDetail").html(html);

        var template = $('#tmp_reward_tbody').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#reward_tbody").html(html);

        recordFromObjectEvent();
    }
    function questDetail(idx){
        var data = dtList_quest.getDataRow(idx);
        util.getAjaxData("quest", "/rest/event/quest/detail", data, fn_questDetail_success);
    }

    function fn_questDetail_success(dst_id, response, param){
        questIdx = param.idx;
        $("#detailInfo").show();

        var i=1;
        var tmp = response.summary.rewardTypeList.split("|");
        var rewardTypeList = [];
        tmp.forEach(function(value, index){
            if(value > 0){
                var obj = {
                    rewardTypeCnt : value
                    , rewardType : index+1
                    , rewardTypeId :  "rewardType" + i
                    , rewardTypeCntId : "rewardTypeCnt" + i
                };
                rewardTypeList.push(obj);
                ++i;
            }
        });
        response.summary.rewardTypeList = rewardTypeList;

        var template = $('#tmp_reward_detail').html();
        var templateScript = Handlebars.compile(template);
        var data = response.summary;
        var html = templateScript(data);
        $("#questDetail").html(html);

        var template = $('#tmp_reward_tbody').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#reward_tbody").html(html);

        $(".monthDate").val(response.summary.questDate);

        resetNo();
    }

    function questEdit(){
        var questNameList = "";
        var questNoList = "";
        var questOrderList = "";
        var questDescList = "";
        var dayCntList = "";
        var goalCntList = "";
        var rewardDalList = "";
        var rewardByeolList = "";
        var rewardExpList = "";
        var rewardBoosterList = "";
        var rewardCouponList = "";
        var imageRewardList = "";
        var imagePopupList = "";
        var viewYnList = "";

        var isValid = true;


        if($("#rewardType1").val() == $("#rewardType2").val()){
            alert('보너스 선물 중복');
            isValid = false;
            return false;
        }

        if(common.isEmpty($("#rewardTypeCnt1").val())){
            alert('보너스 선물을 입력해주세요.');
            isValid = false;
            return false;
        }
        if(common.isEmpty($("#rewardTypeCnt2").val())){
            alert('보너스 선물을 입력해주세요.');
            isValid = false;
            return false;
        }
        if(common.isEmpty($("#imageReward").val())){
            alert('보너스 선물 이미지를 입력해주세요.');
            isValid = false;
            return false;
        }

        var questDetailIdx = 0;
        $("#reward_tbody").find("._noTr").each(function () {
            ++questDetailIdx;
            questNameList += questNameList == "" ? $(this).find("#questName option:checked").text() : "|" + $(this).find("#questName option:checked").text();
            questNoList += questNoList == "" ? $(this).find('#questName').val() : "|" + $(this).find('#questName').val();
            questOrderList += questDetailIdx == 1 ? questDetailIdx : "|" + questDetailIdx;


            var questDesc = $(this).find('#questDesc').val();
            if(common.isEmpty(questDesc)){
                alert('퀘스트 상세 내용을 입력해주세요.');
                isValid = false;
                return false;
            }
            questDescList += questDescList == "" ? $(this).find('#questDesc').val() : "|" + $(this).find('#questDesc').val();

            var dayCnt = $(this).find('#dayCnt').val();
            if(common.isEmpty(dayCnt)){
                alert('하루 최대 수치를 입력해주세요.');
                isValid = false;
                return false;
            }
            dayCntList += dayCntList == "" ? $(this).find('#dayCnt').val() : "|" + $(this).find('#dayCnt').val();

            var goalCnt = $(this).find('#goalCnt').val();
            if(common.isEmpty(goalCnt)){
                alert('한달 목표를 입력해주세요.');
                isValid = false;
                return false;
            }
            goalCntList += goalCntList == "" ? $(this).find('#goalCnt').val() : "|" + $(this).find('#goalCnt').val();

            var rewardTypeCnt = $(this).find('#rewardTypeCnt').val();
            if(common.isEmpty(rewardTypeCnt)){
                alert('보상을 입력해 주세요.');
                isValid = false;
                return false;
            }
            rewardDalList += $(this).find("#selQuestReward").val() == "1" ?   "|" + $(this).find('#rewardTypeCnt').val() : "|" + 0;
            rewardByeolList += $(this).find("#selQuestReward").val() == "2" ?   "|" + $(this).find('#rewardTypeCnt').val() : "|" + 0;
            rewardExpList += $(this).find("#selQuestReward").val() == "3" ?   "|" + $(this).find('#rewardTypeCnt').val() : "|" + 0;
            rewardBoosterList += $(this).find("#selQuestReward").val() == "4" ?   "|" + $(this).find('#rewardTypeCnt').val() : "|" + 0;
            rewardCouponList += $(this).find("#selQuestReward").val() == "5" ?   "|" + $(this).find('#rewardTypeCnt').val() : "|" + 0;

            var imageReward = $(this).find('#imageReward').val();
            if(common.isEmpty(imageReward)){
                alert('보상 이미지를 입력해 주세요.');
                isValid = false;
                return false;
            }
            imageRewardList += imageRewardList == "" ? $(this).find('#imageReward').val() : "|" + $(this).find('#imageReward').val();

            var imagePopup = $(this).find('#imagePopup').val();
            if(common.isEmpty(imagePopup)){
                alert('팝업 이미지를 입력해 주세요.');
                isValid = false;
                return false;
            }
            imagePopupList += imagePopupList == "" ? $(this).find('#imagePopup').val() : "|" + $(this).find('#imagePopup').val();

            viewYnList += $(this).find(".onoffswitch-checkbox").prop('checked') ?  "|" + 1 :  "|" + 0;

        });

        if(questDetailIdx == 0){
            alert('퀘스트 설정 상세를 추가하세요.');
            isValid = false;
            return false;
        }
        var rewardDal = 0;
        var rewardByeol = 0;
        var rewardExp = 0;
        var rewardBooster = 0;
        var rewardCoupon = 0;

        if(isValid){
            if($("#rewardType1").val() == "1"){
                rewardDal = $("#rewardTypeCnt1").val();
            }else if($("#rewardType1").val() == "2"){
                rewardByeol = $("#rewardTypeCnt1").val();
            }else if($("#rewardType1").val() == "3"){
                rewardExp = $("#rewardTypeCnt1").val();
            }else if($("#rewardType1").val() == "4"){
                rewardBooster = $("#rewardTypeCnt1").val();
            }else if($("#rewardType1").val() == "5"){
                rewardCoupon = $("#rewardTypeCnt1").val();
            }

            if($("#rewardType2").val() == "1"){
                rewardDal = $("#rewardTypeCnt2").val();
            }else if($("#rewardType2").val() == "2"){
                rewardByeol = $("#rewardTypeCnt2").val();
            }else if($("#rewardType2").val() == "3"){
                rewardExp = $("#rewardTypeCnt2").val();
            }else if($("#rewardType2").val() == "4"){
                rewardBooster = $("#rewardTypeCnt2").val();
            }else if($("#rewardType2").val() == "5"){
                rewardCoupon = $("#rewardTypeCnt2").val();
            }


            var data = {
                // 메인
                questDate : $(".monthDate").val()
                , viewYn : $("#detail_show_yn").prop('checked') ? 1 : 0
                , rewardDal : rewardDal
                , rewardByeol : rewardByeol
                , rewardExp : rewardExp
                , rewardBooster : rewardBooster
                , rewardCoupon : rewardCoupon
                , imageReward : $("#imageReward").val()
                , goalCnt : questDetailIdx          // 이벤트 수

                // 목록
                , questNameList : questNameList
                , questNoList : questNoList
                , questOrderList : questOrderList
                , questDescList : questDescList
                , dayCntList : dayCntList
                , goalCntList : goalCntList
                , rewardDalList : rewardDalList.substr(1)
                , rewardByeolList : rewardByeolList.substr(1)
                , rewardExpList : rewardExpList.substr(1)
                , rewardBoosterList : rewardBoosterList.substr(1)
                , rewardCouponList : rewardCouponList.substr(1)
                , imageRewardList : imageRewardList
                , imagePopupList : imagePopupList
                , viewYnList : viewYnList.substr(1)
            };

            console.log(data);

            util.getAjaxData("quest", "/rest/event/quest/edit", data, fn_questEdit_success);
        }
    }

    function fn_questEdit_success(dst_id, response){
        if(response.result =="success"){
            alert('퀘스트 이벤트 등록 성공');
            questList();
        }else{
            alert('등록 실패');
        }
    }

    function questDel() {

        var checkDatas = dtList_quest.getCheckedData();

        if(checkDatas.length == 0){
            alert('삭제할 퀘스트 이벤트를 Check 하세요.');
            return;
        }
        if(confirm('선택한 퀘스트 이벤트를 삭제 하시겠습니까?')){
            var idxList = "";
            for(var i=0;i<checkDatas.length;i++){
                idxList += checkDatas[i].idx + "@@";
            }
            var data = {
                idxList : idxList
            };

            util.getAjaxData("quest", "/rest/event/quest/delete", data, function(dst_id, response){
                questList();
            });
        }
    }

    function addReward(){

        var template = $('#tmp_reward_tbody_new').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#reward_tbody").append(html);

        resetNo();

    }

    function delReward(){
        var checked = $("#reward_tbody").find('._check:checked');

        if (0 == checked.length) {
            alert("삭제할 퀘스트를 선택해주세요.");
            return;
        }

        if (confirm('삭제하시겠습니까?')) {
            var checked = $("#reward_tbody").find('._check:checked');
            checked.closest('tr').remove();

            resetNo();
            // window.resizeTo(window.outerWidth, $(".container").height()+100);
        }
    }

    // function rewardOrderUpd(){
    //     var questNoList;
    //
    //     $("#reward_tbody").find("._noTr").each(function () {
    //         questNoList += questNoList == "" ? $(this).find('#questName').val() : "|" + $(this).find('#questName').val();
    //
    //     });
    //
    //     var data = {
    //         questNoList : questNoList
    //     };
    //
    //     util.getAjaxData("quest", "/rest/event/quest/order/update", data, function(dst_id, response){
    //         questList();
    //     });
    // }


    $(document).on('click', '._down', function () {
        var targetTr = $(this).closest('tr');
        var nextTr = targetTr.next();
        targetTr.insertAfter(nextTr);
        resetNo();
        btnSet();
    });

    $(document).on('click', '._up', function () {
        var targetTr = $(this).closest('tr');
        var prevTr = targetTr.prev();
        targetTr.insertBefore(prevTr);
        resetNo();
        btnSet();
    });

    function resetNo() {
        $("#reward_tbody").find('._noTd').each(function (index) {
            var html = '<input type="hidden" name="sortNo" value="'+(index+1)+'">';
            html += (index+1);
            $(this).html(html);
        });

        $("#reward_tbody").find('._noTr').each(function (index) {
            $(this).attr("id", "row_" + (index + 1));
        });

        recordFromObjectEvent();
    };

    function getImg(gubun){
        $("#questModal").modal('show');
        var imageUrl = "";
        if(gubun == 1){
            imageUrl = $("#imageReward").val();
        }else{
            imageUrl = gubun;
        }

        $("#imageViewer").attr('src',imageUrl);

    }

    function recordFromObjectEvent(){
        $(".rewardImageUrlPreviewButton").on('click', function(){
            var parents = $(this).parents("tr").attr('id');
            getImg($("#"+parents+"").find("#imageReward").val());
        });

        $(".rewardImagePopupUrlPreviewButton").on('click', function(){
            var parents = $(this).parents("tr").attr('id');
            getImg($("#"+parents+"").find("#imagePopup").val());
        });

        $('.monthDate').datepicker({
            minViewMode: 'months',
            format: 'yyyy-mm',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            language: 'kr',
        });

        btnSet();
    }

    function btnSet() {
        $("#reward_tbody").find('.btn._up').prop('disabled', false);
        $("#reward_tbody").find('.btn._down').prop('disabled', false);

        $("#reward_tbody").find('.btn._down:last').prop('disabled', true);
        $("#reward_tbody").find('.btn._up:first').prop('disabled', true);
    }

</script>


<script id="tmp_reward_detail" type="text/x-handlebars-template">
    <table id="reward_detail" class="table table-sorting table-hover table-bordered no-margin">
        <colgroup>
            <col width="5%"/><col width="5%"/><col width="5%"/><col width="20%"/>
            <col width="15%"/><col width="5%"/><col width="5%"/>
        </colgroup>
        <tr>
            <th>퀘스트 기간</th>
            <td>
                <div class="input-group date" id="monthDatepicker">
                    <label for="monthDate" class="input-group-addon">
                        <span><i class="fa fa-calendar"></i></span>
                    </label>
                    <input id="monthDate" type="text" class="form-control monthDate" style="width: 196px;" value="{{questDate}}"/>
                </div>
            </td>
            <th>보너스 선물</th>
            <td>
                {{#each this.rewardTypeList as |data|}}
                    {{{getCommonCodeSelect rewardType 'questReward' 'N' rewardTypeId}}}
                    <input type="text" class="form-control" id="{{rewardTypeCntId}}" style="width: 100px;" value="{{rewardTypeCnt}}">
                {{else}}
                    {{{getCommonCodeSelect rewardType 'questReward' 'N' 'rewardType1'}}}
                    <input type="text" class="form-control" id="rewardTypeCnt1" style="width: 100px;" value="{{rewardTypeCnt}}">
                    {{{getCommonCodeSelect rewardType 'questReward' 'N' 'rewardType2'}}}
                    <input type="text" class="form-control" id="rewardTypeCnt2" style="width: 100px;" value="{{rewardTypeCnt}}">
                {{/each}}
            </td>
            <td>
                <input type="text" class="form-control pull-left" id="imageReward" style="width: 80%;" value="{{imageReward}}">
                <input type="button" class="pull-right btn-default" value="미리보기" onclick="getImg(1);" style="margin-top: 3px;">
            </td>
            <th>노출여부</th>
            <td>{{{getOnOffSwitch viewYn 'show_yn'}}}</td>
        </tr>
        <tr>
            <th>등록자</th>
            <td>{{opName}}</td>
            <th>등록일</th>
            <td>{{regDate}}</td>
            <td></td>
            <th>수정일</th>
            <td>{{lastUpdDate}}</td>
        </tr>
    </table>
</script>


<script id="tmp_reward_tbody_new" type="text/x-handlebars-template">
    <tr class="_noTr" id="row_{{sortNo}}" >
        <td>
            <input type="checkbox" class="_check" data-idx="{{idx}}"/>
        </td>
        <td>
            <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
        <td>
            {{{getCommonCodeSelect 0 'questName' 'Y' 'questName'}}}
        </td>
        <td><input type="text" class="form-control" id="questDesc" style="width: 100%;" value="{{questDesc}}"></td>
        <td><input type="text" class="form-control" id="dayCnt" style="width: 100%;" value="{{dayCnt}}"></td>
        <td><input type="text" class="form-control" id="goalCnt" style="width: 100%;" value="{{goalCnt}}"></td>
        <td>
            {{{getCommonCodeSelect rewardType 'questReward' 'N' 'selQuestReward'}}}
            <input type="text" class="form-control" id="rewardTypeCnt" style="width: 55px;" value="{{rewardTypeCnt}}">
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="imageReward" style="width: 70%;" value="{{imageReward}}">
            <input type="button" class="pull-right btn-default rewardImageUrlPreviewButton" value="미리보기" style="margin-top: 3px;">
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="imagePopup" style="width: 70%;" value="{{imagePopup}}">
            <input type="button" class="pull-right btn-default rewardImagePopupUrlPreviewButton" value="미리보기" style="margin-top: 3px;">
        </td>
        <td>{{{getOnOffSwitch viewYn orderNo}}}</td>
    </tr>
</script>

<script id="tmp_reward_tbody" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr class="_noTr" id="row_{{orderNo}}" >
        <td>
            <input type="checkbox" class="_check" data-idx="{{questNo}}"/>
        </td>
        <td>
            <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
        <td>
            {{{getCommonCodeSelect questNo 'questName' 'Y' 'questName'}}}
        </td>
        <td><input type="text" class="form-control" id="questDesc" style="width: 100%;" value="{{questDesc}}"></td>
        <td><input type="text" class="form-control" id="dayCnt" style="width: 100%;" value="{{dayCnt}}"></td>
        <td><input type="text" class="form-control" id="goalCnt" style="width: 100%;" value="{{goalCnt}}"></td>
        <td>
            {{{getCommonCodeSelect rewardType 'questReward' 'N' 'selQuestReward'}}}
            <input type="text" class="form-control" id="rewardTypeCnt" style="width: 55px;" value="{{rewardTypeCnt}}">
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="imageReward" style="width: 70%;" value="{{imageReward}}">
            <input type="button" class="pull-right btn-default rewardImageUrlPreviewButton" value="미리보기" style="margin-top: 3px;">
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="imagePopup" style="width: 70%;" value="{{imagePopup}}">
            <input type="button" class="pull-right btn-default rewardImagePopupUrlPreviewButton" value="미리보기" style="margin-top: 3px;">
        </td>
        <td>{{{getOnOffSwitch viewYn orderNo}}}</td>
    </tr>
    {{/each}}
</script>