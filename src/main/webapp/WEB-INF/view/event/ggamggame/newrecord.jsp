<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-md-1 no-padding pull-right">
    <button type="button" class="btn btn-primary pull-right" onclick="newrecordAdd();"><i class="fa fa-search"></i>등록</button>
</div>
<div class="widget-content col-md-12 no-padding">
    <table class="table table-sorting table-hover table-bordered datatable" id="table_newrecord_list">
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button type="button" class="btn btn-danger pull-left" id="newrecordDel" onclick="newrecordDel();">선택 삭제</button>

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
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>이벤트 선택</th>
                            <th>달성 조건 설정</th>
                            <th>주건 세부 설정</th>
                            <th>구분</th>
                            <th>달성 조건 설정</th>
                            <th>혜택 설정</th>
                            <th>수량</th>
                        </tr>
                        </thead>
                        <tbody id="event_condition_tbody">
                        </tbody>
                    </table>
                </div>
                <div class="widget-footer">
                    <span>
                        <button class="btn btn-success" type="button" onclick="addEvent_condition();">추가</button>
                        <button class="btn btn-default pull-right" type="button" onclick="newrecordEdit();">저장하기</button>
                    </span>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- //보름달 완성 조건(DJ) -->

<script>

    var dtList_record;
    function newrecordList() {
        $("#detailInfo").hide();
        var dtList_info_data = function (data) {
            data.searchText = $("#searchText").val();
        };
        dtList_record = new DalbitDataTable($("#table_newrecord_list"), dtList_info_data, ggamggameDataTableSource.newrecordList);
        dtList_record.useCheckBox(true);
        dtList_record.useIndex(true);
        dtList_record.setPageLength(50);
        dtList_record.createDataTable();

    }

    function newrecordAdd(){

        var template = $('#tmp_newrecordInfo').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#newrecordInfo").html(html);

    }
    function newrecordDetail(idx){
        var data = dtList_record.getDataRow(idx);
        util.getAjaxData("newrecord", "/rest/event/ggamggame/newrecord/detail", data, fn_newrecordDetail_success);
    }

    function fn_newrecordDetail_success(dst_id, response){

        $("#detailInfo").show();

        var template = $('#tmp_event_record_detail').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#newrecordDetail").html(html);

        var template = $('#tmp_event_condition_tbody').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#event_condition_tbody").html(html);

    }

    function newrecordEdit(){
        var data = {

        };
    }

    function newrecordDel() {

        var checkDatas = dtList_record.getCheckedData();

        if(checkDatas.length == 0){
            alert('삭제할 신기록 이벤트를 Check 하세요.');
            return;
        }
        if(confirm('선택한 신기록 이벤트를 삭제 하시겠습니까?')){
            var memNoList = "";
            for(var i=0;i<checkDatas.length;i++){
                memNoList += checkDatas[i].mem_no + "@@";
            }
            var data = {
                memNoList : memNoList
            };

            util.getAjaxData("newrecord", "/rest/event/ggamggame/newrecord/delete", data, function(dst_id, response){
                newrecordList();
            });
        }
    }

    function addEvent_condition(){

        var template = $('#tmp_event_condition_tbody').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#event_condition_tbody").append(html);
    }
</script>


<script id="tmp_event_record_detail" type="text/x-handlebars-template">
    <table id="event_record_detail" class="table table-sorting table-hover table-bordered">
        <colgroup>
            <col width="5%"/>
            <col width="10%"/>
            <col width="5%"/>
            <col width="10%"/>
        </colgroup>
        <tr>
            <th>이벤트 제목</th>
            <td>
                <input type="text" class="form-control" id="txt_title" style="width: 100%;" value="{{eventName}}">
            </td>
            <th>노출여부</th>
            <td>{{{getOnOffSwitch viewYn slctType}}}</td>
        </tr>
        <tr>
            <th>등록자</th>
            <td>{{regOpName}}</td>
            <th>등록일</th>
            <td>{{regDate}}</td>
        </tr>
        <tr>
            <th>수정자</th>
            <td>{{updOpName}}</td>
            <th>수정일</th>
            <td>{{updDate}}</td>
        </tr>
    </table>
</script>
<script id="tmp_event_condition_tbody" type="text/x-handlebars-template">
    <tr>
        <td>
            <select id="conGubun" name="conGubun" class="form-control" style="width: 100%;">
                <option value="1" selected="selected">DJ</option>
                <option value="2">청취자</option>
            </select>
        </td>
        <td>
            <select id="conEvent" name="conEvent" class="form-control" style="width: 100%;">
                <option value="1" selected="selected">좋아요</option>
                <option value="2">누적 청취자</option>
                <option value="3">선물(별)</option>
            </select>
        </td>
        <td>
            <select id="conCondition" name="conCondition" class="form-control" style="width: 100%;">
                <option value="1" selected="selected">첫 달성 조건</option>
                <option value="2">신기록 달성 조건</option>
            </select>
        </td>
        <td>
            <input type="text" class="form-control" id="txt_conSetting" style="width: 100%;">
        </td>


        <td>
            <select id="conConReward" name="conConReward" class="form-control" style="width: 100%;">
                <option value="1" selected="selected">첫 달성 혜택</option>
                <option value="2">신기록 달성 혜택</option>
            </select>
        </td>
        <td>
            <select id="conReward" name="conReward" class="form-control" style="width: 100%;">
                <option value="1" selected="selected">무료부스터</option>
                <option value="2">룰렛 응모권</option>
                <option value="3">방송시간 연장</option>
            </select>
        </td>
        <td>
            <input type="text" class="form-control" id="txt_conRewardCnt" style="width: 100%;">
        </td>
        <td>
            <input type="text" class="form-control" id="txt_conContent" style="width: 100%;">
        </td>
    </tr>
</script>