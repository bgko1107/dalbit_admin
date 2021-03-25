<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-1 no-padding pull-right">
    <button type="button" class="btn btn-primary pull-right" onclick="newrecordAdd();"><i class="fa fa-search"></i>등록</button>
</div>
<div class="widget-content col-md-12 no-padding">
    <table class="table table-sorting table-hover table-bordered datatable no-margin" id="table_newrecord_list">
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button type="button" class="btn btn-danger pull-left mb15" id="newrecordDel" onclick="newrecordDel();" >선택 삭제</button>

<!-- 보름달 완성 조건(DJ) -->
<div class="col-md-12 no-padding" id="detailInfo" style="display: none;">
    <span id="newrecordDetail"></span>

    <form id="condition1">
        <div class="col-lg-12 form-inline mt15 no-padding">
            <div class="widget widget-table">
                <div class="widget-header">
                    <h3>설정상세</h3>
                </div>
                <div class="widget-content mt10">
                    <table id="event_condition" class="table table-sorting table-hover table-bordered">
                        <colgroup>
                            <col width="1%"/>
                            <col width="2%"/>
                            <col width="4%"/>
                            <col width="3%"/>
                            <col width="4%"/>
                            <col width="2.5%"/>
                            <col width="15%"/>
                            <col width="15%"/>
                            <col width="2%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>선택</th>
                            <th>구분</th>
                            <th>달성 조건 설정</th>
                            <th>조건 세부 설정</th>
                            <th>혜택 설정</th>
                            <th>수량</th>
                            <th>문구</th>
                            <th>이미지URL</th>
                            <th>플레이타임(초)</th>
                        </tr>
                        </thead>
                        <tbody id="event_condition_tbody">
                        </tbody>
                    </table>
                </div>
                <div class="widget-footer">
                    <span>
                        <button class="btn btn-success" type="button" onclick="addEvent_condition();">추가</button>
                        <button class="btn btn-danger" type="button" onclick="delEvent_condition();">삭제</button>
                        <button class="btn btn-default pull-right" type="button" onclick="newrecordEdit();">저장하기</button>
                    </span>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- //보름달 완성 조건(DJ) -->

<div class="modal fade" id="newRecordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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

    var newRecordIdx = 0;

    var dtList_record;
    function newrecordList() {
        $("#detailInfo").hide();
        var dtList_info_data = function (data) {
            data.searchText = $("#searchText").val();
            data.searchType = 1;                        // 신기록
        };
        dtList_record = new DalbitDataTable($("#table_newrecord_list"), dtList_info_data, ggamggameDataTableSource.newrecordList);
        dtList_record.useCheckBox(true);
        dtList_record.useIndex(true);
        dtList_record.setPageLength(50);
        dtList_record.createDataTable();

    }

    function newrecordAdd(){
        $("#detailInfo").show();

        newRecordIdx = 0;

        var template = $('#tmp_event_record_detail').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#newrecordDetail").html(html);

        var template = $('#tmp_event_condition_tbody').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#event_condition_tbody").html(html);
    }
    function newrecordDetail(idx){
        var data = dtList_record.getDataRow(idx);
        data.eventType = 1;
        util.getAjaxData("newrecord", "/rest/content/event/ggamggame/newrecord/detail", data, fn_newrecordDetail_success);
    }

    function fn_newrecordDetail_success(dst_id, response, param){

        newRecordIdx = param.idx;

        $("#detailInfo").show();

        var template = $('#tmp_event_record_detail').html();
        var templateScript = Handlebars.compile(template);
        var data = response.summary;
        var html = templateScript(data);
        $("#newrecordDetail").html(html);

        var template = $('#tmp_event_condition_tbody').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#event_condition_tbody").html(html);

        resetNo();
    }

    function newrecordEdit(){
        var typeList = "";
        var achieveTypeList = "";
        var achieveCntList = "";
        var rewardTypeList = "";
        var rewardCntList = "";
        var completeTextList = "";
        var imageUrlList = "";
        var imageTimeList = "";

        var isValid = true;
        $("#event_condition_tbody").find("._noTr").each(function () {

            var conGubun = $(this).find('#conGubun').val();
            if(common.isEmpty(conGubun)){
                alert('구분을 선택해주세요.');
                isValid = false;
                return false;
            }
            typeList += typeList == "" ? $(this).find('#conGubun').val() : "|" + $(this).find('#conGubun').val();

            var conCondition = $(this).find('#conCondition').val();
            if(common.isEmpty(conCondition)){
                alert('달성 조건 설정을 선택해주세요.');
                isValid = false;
                return false;
            }
            achieveTypeList += achieveTypeList == "" ? $(this).find('#conCondition').val() : "|" + $(this).find('#conCondition').val();

            var txt_conSetting = $(this).find('#txt_conSetting').val();
            if(common.isEmpty(txt_conSetting)){
                alert('달성 세부 설정을 입력해주세요.');
                isValid = false;
                return false;
            }
            achieveCntList += achieveCntList == "" ? $(this).find('#txt_conSetting').val() : "|" + $(this).find('#txt_conSetting').val();

            var conReward = $(this).find('#conReward').val();
            if(common.isEmpty(conReward)){
                alert('혜택 설정을 선택해주세요.');
                isValid = false;
                return false;
            }
            rewardTypeList += rewardTypeList == "" ? $(this).find('#conReward').val() : "|" + $(this).find('#conReward').val();

            var txt_conRewardCnt = $(this).find('#txt_conRewardCnt').val();
            if(common.isEmpty(txt_conRewardCnt)){
                alert('수량을 입력해주세요.');
                isValid = false;
                return false;
            }
            rewardCntList += rewardCntList == "" ? $(this).find('#txt_conRewardCnt').val() : "|" + $(this).find('#txt_conRewardCnt').val();

            var txt_conContent = $(this).find('#txt_conContent').val();
            if(common.isEmpty(txt_conContent)){
                alert('문구를 입력해주세요.');
                isValid = false;
                return false;
            }
            completeTextList += completeTextList == "" ? $(this).find('#txt_conContent').val() : "|" + $(this).find('#txt_conContent').val();

            var txt_imageUrl = $(this).find('#txt_imageUrl').val();
            if(common.isEmpty(txt_imageUrl)){
                alert('이미지URL을 입력해주세요.');
                isValid = false;
                return false;
            }
            imageUrlList += imageUrlList == "" ? $(this).find('#txt_imageUrl').val() : "|" + $(this).find('#txt_imageUrl').val();

            var play_time = $(this).find('#play_time').val();
            if(common.isEmpty(play_time)){
                alert('플레이타임을 입력해주세요.');
                isValid = false;
                return false;
            }
            imageTimeList += imageTimeList == "" ? $(this).find('#play_time').val() : "|" + $(this).find('#play_time').val();
        });

        if(isValid){
            var data = {
                idx : newRecordIdx
                , slctType : 1
                , type :  $("#targetType").val()
                , eventName : $("#txt_title").val()
                , eventNo : $("#conEvent").val()
                , viewYn : $("#detail_viewYn").prop('checked') ? 1 : 0
                , typeList : typeList
                , achieveTypeList : achieveTypeList
                , achieveCntList : achieveCntList
                , rewardTypeList : rewardTypeList
                , rewardCntList : rewardCntList
                , completeTextList : completeTextList
                , imageUrlList : imageUrlList
                , imageTimeList : imageTimeList
            };

            console.log(data);

            util.getAjaxData("newrecord", "/rest/content/event/ggamggame/newrecord/edit", data, fn_newrecordEdit_success);
        }
    }

    function fn_newrecordEdit_success(dst_id, response){
        if(response.result =="success"){
            alert('신기록 이벤트 등록 성공');
            newrecordList();
        }else{
            alert('구분, 달성 조건 설정, 혜택 설정이 중복되었습니다.');
        }
    }

    function newrecordDel() {

        var checkDatas = dtList_record.getCheckedData();

        if(checkDatas.length == 0){
            alert('삭제할 신기록 이벤트를 Check 하세요.');
            return;
        }
        if(confirm('선택한 신기록 이벤트를 삭제 하시겠습니까?')){
            var idxList = "";
            for(var i=0;i<checkDatas.length;i++){
                idxList += checkDatas[i].idx + "@@";
            }
            var data = {
                idxList : idxList
            };

            util.getAjaxData("newrecord", "/rest/content/event/ggamggame/newrecord/delete", data, function(dst_id, response){
                newrecordList();
            });
        }
    }

    function addEvent_condition(){

        var template = $('#tmp_event_condition_tbody_new').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        console.log(html);
        $("#event_condition_tbody").append(html);

        resetNo();

    }

    function delEvent_condition(){
        var checked = $("#event_condition_tbody").find('._check:checked');

        if (0 == checked.length) {
            alert("삭제할 카테고리를 선택해주세요.");
            return;
        }

        if (confirm('삭제하시겠습니까?')) {
            var checked = $("#event_condition_tbody").find('._check:checked');
            checked.closest('tr').remove();
            resetNo();
            // window.resizeTo(window.outerWidth, $(".container").height()+100);
        }
    }

    function resetNo() {
        $("#event_condition_tbody").find('._noTd').each(function (index) {
            var html = '<input type="hidden" name="sortNo" value="'+(index+1)+'">';
            html += (index+1);
            $(this).html(html);
        });

        $("#event_condition_tbody").find('._noTr').each(function (index) {
            $(this).attr("id", "row_" + (index + 1));
        });
        recordFromObjectEvent();
    };

    function getImg(){
        $("#newRecordModal").modal('show');
        $("#imageViewer").attr('src',$("#txt_imageUrl").val());
    }

    function recordFromObjectEvent(){
        $('select[name="conReward"]').on('change', function(){
            var selectBox = $(this);
            var val = selectBox.val();
            var parents = selectBox.parents("tr").attr('id');
            if(val == "99"){
                $("#"+parents+"").find("#txt_conRewardCnt").attr("disabled",true).attr("readonly",false);
                $("#"+parents+"").find("#txt_conRewardCnt").val('0');
            }else{
                $("#"+parents+"").find("#txt_conRewardCnt").attr("disabled",false).attr("readonly",false);
            }
        });
    }

</script>


<script id="tmp_event_record_detail" type="text/x-handlebars-template">
    <table id="event_record_detail" class="table table-sorting table-hover table-bordered no-margin">
        <colgroup>
            <col width="3%"/><col width="3%"/><col width="3%"/><col width="3%"/><col width="3%"/>
            <col width="15%"/><col width="3%"/><col width="3%"/>
        </colgroup>
        <tr>
            <th>이벤트 선택</th>
            <td>{{{getCommonCodeSelect eventNo 'conEvent'}}}</td>
            <th>기준</th>
            <td>{{{getCommonCodeSelect type 'conGubun' 'Y' 'targetType'}}}</td>
            <th>이벤트 제목</th>
            <td>
                <input type="text" class="form-control" id="txt_title" style="width: 100%;" value="{{eventName}}">
            </td>
            <th>노출여부</th>
            <td>{{{getOnOffSwitch viewYn 'viewYn'}}}</td>
        </tr>
        <tr>
            <th>등록자</th>
            <td>{{regOpName}}</td>
            <th>등록일</th>
            <td>{{regDate}}</td>
            <th>수정자</th>
            <td>{{updOpName}}</td>
            <th>수정일</th>
            <td>{{updDate}}</td>
        </tr>
    </table>
</script>


<script id="tmp_event_condition_tbody_new" type="text/x-handlebars-template">
    <tr class="_noTr" id="row_{{sortNo}}" >
        <td>
            <input type="checkbox" class="_check" data-idx="{{idx}}"/>
        </td>
        <td>{{{getCommonCodeSelect type 'conGubun'}}}</td>
        <td>{{{getCommonCodeSelect achieve_type 'conCondition'}}}</td>
        <td>
            <input type="text" class="form-control" id="txt_conSetting" style="width: 100%;" value="{{achieve_cnt}}">
        </td>
        <td>{{{getCommonCodeSelect reward_type 'conReward'}}}</td>
        <td>
            <input type="text" class="form-control" id="txt_conRewardCnt" style="width: 100%;" value="{{reward_cnt}}">
        </td>
        <td>
            <textarea class="form-control" id="txt_conContent" style="width: 100%;" maxlength="200">{{{replaceTextarea complete_text}}}</textarea>
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="txt_imageUrl" style="width: 80%;" value="{{image_url}}">
            <input type="button" class="pull-right btn-default" value="미리보기" onclick="getImg();" style="margin-top: 3px;">
        </td>
        <td>
            <input type="text" class="form-control" id="play_time" style="width: 100%;" value="{{image_time}}">
        </td>
    </tr>
</script>

<script id="tmp_event_condition_tbody" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr class="_noTr" id="row_{{sortNo}}" >
        <td>
            <input type="checkbox" class="_check" data-idx="{{idx}}"/>
        </td>
        <td>{{{getCommonCodeSelect type 'conGubun'}}}</td>
        <td>{{{getCommonCodeSelect achieve_type 'conCondition'}}}</td>
        <td>
            <input type="text" class="form-control" id="txt_conSetting" style="width: 100%;" value="{{achieve_cnt}}">
        </td>
        <td>{{{getCommonCodeSelect reward_type 'conReward'}}}</td>
        <td>
            <input type="text" class="form-control" id="txt_conRewardCnt" style="width: 100%;" value="{{reward_cnt}}">
        </td>
        <td>
            <textarea class="form-control" id="txt_conContent" style="width: 100%;" maxlength="200">{{{replaceTextarea complete_text}}}</textarea>
        </td>
        <td>
            <input type="text" class="form-control pull-left" id="txt_imageUrl" style="width: 80%;" value="{{image_url}}">
            <input type="button" class="pull-right btn-default" value="미리보기" onclick="getImg();" style="margin-top: 3px;">
        </td>
        <td>
            <input type="text" class="form-control" id="play_time" style="width: 100%;" value="{{image_time}}">
        </td>
    </tr>
    {{/each}}
</script>