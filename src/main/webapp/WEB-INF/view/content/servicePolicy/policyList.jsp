<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제/환불 > 결제내역 -->
<div class="widget-table mb10">
    <div class="col-md-1 no-padding">
        <select id="dateType" name="dateType" class="form-control" onchange="getPolicyList()">
            <option value="0">반영일자</option>
            <option value="1">최근 등록일자</option>
            <option value="2">최근 수정일자</option>
        </select>
    </div>
    <div class="col-md-1 no-padding">
        <span id="slctTypeArea" onchange="getPolicyList()"></span>
    </div>
    <div class="widget-content mt10">
        <table class="table table-bordered" id="list">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>

        <button class="btn btn-danger" type="button" id="deleteBtn">삭제하기</button>
        <button class="btn btn-success pull-right" type="button" id="newBtn">신규등록</button>
    </div>
</div>
<div class="col-md-12 no-padding">
    <form id="policyDetailform"></form>
    <span id="editHistorylist"></span>
</div>
<script type="text/javascript">
    $(document).ready(function (){
        $("#slctTypeArea").html(util.getCommonCodeSelect(-1, policy_slctType));

        $("#deleteBtn").on('click', function(){
            policyDelete();
        });
        $("#newBtn").on('click', function(){
            policyDetail();
        });
    });

    var dtList_info;
    function getPolicyList() {
        $("#policyDetailform").empty();
        $("#editHistorylist").empty();

        var dtList_info_data = function(data) {
            data.searchText = $("#searchText").val();
            data.dateType = $("#dateType").val();
            data.slctType = $("#slctType").val();
            data.searchType = 0;
        };

        dtList_info = new DalbitDataTable($("#list"), dtList_info_data, servicePolicyDataTableSource.policyList);
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable();

        // policyDetail();
    }

    function policyDetail(idx, type){
        console.log(idx);
        if(common.isEmpty(idx)){
            $("#editHistorylist").empty();
            var template = $("#tmp_policyDetail").html();
            var templateScript = Handlebars.compile(template);
            var context = '';
            var html = templateScript(context);
            $("#policyDetailform").html(html);

            util.editorInit("content-notice");

            applyDateCssSet();

            var sendDate = moment();

            // 캘린더 초기값
            $("#apply-div-date").find("#apply-input-date").val(sendDate.format('YYYY.MM.DD'));

            // 시간 Select CSS 적용
            $("#apply-div-date").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
            $("#apply-div-date").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());


            // 캘린더 초기값
            $("#event-div-startDate").find("#event-input-startDate").val(sendDate.format('YYYY.MM.DD'));
            // 시간 Select CSS 적용
            $("#event-div-startDate").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
            $("#event-div-startDate").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());

            // 캘린더 초기값
            $("#event-div-endDate").find("#event-input-endDate").val(sendDate.format('YYYY.MM.DD'));
            // 시간 Select CSS 적용
            $("#event-div-endDate").find("#timeHour").val(sendDate.hour().toString().length == 1?("0"+sendDate.hour()):sendDate.hour());
            $("#event-div-endDate").find("#timeMinute").val(sendDate.minute().toString().length == 1?("0"+sendDate.minute()):sendDate.minute());

            $("#insertBtn").on('click', function(){
                insertBtnClick();
            });

        }else{
            var data = {
                idx : idx
                , type : type
            };

            util.getAjaxData("detail", "/rest/content/service/policy/detail", data, fn_success_policyDetail);
        }
    }

    function fn_success_policyDetail(dst_id, response){

        var template = $("#tmp_policyDetail").html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $("#policyDetailform").html(html);

        util.editorInit("content-notice");

        $("#eventTr").hide();
        if(response.summary.slctType == "20" || response.summary.slctType == "21"){
            $("#eventTr").show();
        }

        applyDateCssSet();

        //OS 구분
        if(response.summary.osType == "111"){
            $("input[name='platform']").each(function () {
                this.checked = true;
            });
        }else {
            $("input[name='platform']").each(function () {
                this.checked = false;
            });

            var arrayPlatform = response.summary.osType.split('');
            for (var idx in arrayPlatform) {
                if (arrayPlatform[idx] == 1) {
                    var value = parseInt(idx) + 1;
                    $("input[name='platform'][id='platform" + value + "']").prop("checked", true);
                }
            }
        }

        var date = new Date(response.summary.apply_date);
        console.log(date.getFullYear() +'.'+ common.lpad(date.getMonth() + 1,2,'0') +'.'+ common.lpad(date.getDate(),2,'0') + " " + common.lpad(date.getHours(),2,'0') +":"+ common.lpad(date.getMinutes(),2,'0'));
        $("#apply-div-date").find("#apply-input-date").val(date.getFullYear() +'.'+ common.lpad(date.getMonth() + 1,2,'0') +'.'+ common.lpad(date.getDate(),2,'0'));
        $("#apply-div-date").find("#timeHour").val(common.lpad(date.getHours(),2,'0'));
        $("#apply-div-date").find("#timeMinute").val(common.lpad(date.getMinutes(),2,'0'));

        $("#insertBtn").on('click', function(){
            insertBtnClick();
        });

        var template = $("#tmp_policyHisroyDetail").html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $("#editHistorylist").html(html);
    }

    function applyDateCssSet(){
        $('.input-group.date').datetimepicker({
            format: 'L'
            , date: new Date()
        });

        // 시간 Select CSS 적용
        $('.input-group.date').find("#timeHour").attr("class", "select-time");
        $('.input-group.date').find("#timeMinute").attr("class", "select-time");


        $("input[name='platform']").change(function () {
            if ($(this).attr("id").indexOf("-1") > -1) {
                if ($(this).is(":checked")) {
                    $("input[name='platform']").each(function () {
                        this.checked = true;
                    });
                } else {
                    $("input[name='platform']").each(function () {
                        this.checked = false;
                    });
                }
            } else {
                if ($(this).is(":checked")) {
                    var cntTotal = $("input[name='platform']").length;
                    var cntChecked = $("input[name='platform']:checked").length;
                    if ((cntTotal) == (cntChecked + 1)) {
                        $("input[name='platform'][id='platform-1']").prop("checked", true);
                    }
                } else {
                    $("input[name='platform'][id='platform-1']").prop("checked", false);
                }
            }
        });

        $("#policy_slctType").on('change',function (){
            var val = $(this).val();
            $("#eventTr").hide();
            if(val == "20" || val == "21"){
                $("#eventTr").show();
            }
        });

        var scrollPosition = $("#policyDetailform").offset();
        util.scrollPostion(scrollPosition.top);
    }
    function insertBtnClick(){

        var platform = "";
        if($("#platform-1").is(":checked")){
            platform = "111";
        }else{
            var platformCnt = $("input[name=platform]").length;
            for(var i = 1; i < platformCnt; i++){
                if($("#platform"+(i)).is(":checked")){
                    platform += "1";
                }else{
                    platform += "0";
                }
            }
        }
        if(common.isEmpty(platform) || platform == "000"){
            alert("플랫폼을 선택하여 주시기 바랍니다.");
            return false;
        }
        if($("#policy_slctType").val() == "20" || $("#policy_slctType").val() == "21"){
            if($("#event_no").val() == "" || $("#event_no").val() == null){
                alert("이벤트 번호를 입력하여 주시기 바랍니다.");
                return false;
            }
        }

        var applyDateDiv = $("#apply-div-date");
        var applyDate = $("#apply-input-date").val() + " " + applyDateDiv.find("#timeHour").val() +":"+ applyDateDiv.find("#timeMinute").val() + ":00";

        var data = {
            idx : common.isEmpty($("#policyIdx").val()) ? 0 : $("#policyIdx").val()
            , osType : platform
            , slctType : $("#policy_slctType").val()
            , title : $("#title").val()
            , desc : $("#editor").summernote('code')
            , applyDate : applyDate
        };

        console.log(data);
        util.getAjaxData("insert", "/rest/content/service/policy/edit", data, function insertSuccess(dst_id, response){
            alert(response.message);
            $('#bt_search').click();
        });
    }

    function policyDelete(){
        if(dtList_info.getCheckedData().length <= 0){
            alert("삭제할 대상을 선택해주세요.");
            return;
        }
        if(confirm("삭제하시겠습니까?")){
            var idxList ="";
            var checkDatas = dtList_info.getCheckedData();
            for(var i=0;i<checkDatas.length;i++){
                idxList += checkDatas[i].idx + "@@";
            }
            var data = {};
            data.idxList = idxList;
            util.getAjaxData("delete", "/rest/content/service/policy/delete",data, function insertSuccess(dst_id, response){
                alert(response.message);
                $('#bt_search').click();
            });
        }else false;
    }
    $(document).on('click', '#contentDeleteBtn', function(){
        $('.note-editable').empty();
    });

</script>


<script type="text/x-handlebars-template" id="tmp_policyDetail">
    <div class="col-md-12 no-padding">
        <div>
            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                <li class="active"><a href="#" role="tab" data-toggle="tab">서비스 정책 상세</a></li>
                <button class="btn btn-default pull-right" type="button" id="insertBtn">등록하기</button>
            </ul>
        </div>
    </div>
    <table class="table table-bordered table-dalbit no-margin">
        <colgroup>
            <col width="5.25%" />
            <col width="10.25%" />
            <col width="5.25%" />
            <col width="10.25%" />
            <col width="5.25%" />
            <col width="10.25%" />
            <col width="5.25%" />
            <col width="10.25%" />
        </colgroup>
        <tr>
            <input type="text" class="hide" id="policyIdx" value="{{idx}}" />
            <th>No</th>
            <td>{{idx}}</td>
            <th>플랫폼</th>
            <td>{{{getCommonCodeHorizontalCheck osType 'content_platform2'}}}</td>
            <th>등록 일시<br />수정 일시</th>
            <td>{{reg_date}}<br/>{{upd_date}}</td>
            <th>등록자<br/>수정자</th>
            <td>{{reg_op_name}}<br/>{{upd_op_name}}</td>
        </tr>
        <tr>
            <th>서비스 구분</th>
            <td>{{{getCommonCodeSelect slctType 'policy_slctType' 'Y' 'policy_slctType'}}}</td>
            <th>주요사안<br/>(제목)</th>
            <td colspan="3"><input type="text" class="form-control" id="title" value="{{title}}"> </td>
            <th>반영일자</th>
            <td>
                <div class="input-group date" id="apply-div-date">
                    <span class="input-group-addon" id="apply-date"><i class="fa fa-calendar"></i></span>
                    <input type="text" class="form-control" name="startDate" id="apply-input-date" style="width:100px; background:white; height: 34px">
                    {{{getCommonCodeSelect 00 'timeHour'}}}
                    <span> : </span>
                    {{{getCommonCodeSelect 00 'timeMinute'}}}
                </div>
            </td>
        </tr>
        <tr>
            <th colspan="8">
                변경내용
                <button class="btn btn-danger pull-right" type="button" id="contentDeleteBtn">내용삭제</button>
            </th>
        </tr>
        <tr>
            <td colspan="8"><div class="_editor" id="editor" name="editor">{{{replaceHtml desc}}}</div></td>
        </tr>
    </table>
</script>

<script type="text/x-handlebars-template" id="tmp_policyHisroyDetail">
    <table class="table table-bordered">
        <colgroup>
            <col width="3%" />
            <col width="5%" />
            <col width="15%" />
            <col width="25%" />
            <col width="4%" />
            <col width="4%" />
            <col width="3%" />
            <col width="3%" />
            <col width="4%" />
            <col width="4%" />
        </colgroup>
        <thead>
        <tr>
            <th colspan="6" style="background-color: #dce6f2;">
                <label class="font-bold">[{{{getCommonCodeLabel summary.slctType 'policy_slctType'}}}] </label>
                변경이력
            </th>
        </tr>
        <tr>
            <th>반영일자</th>
            <th>플랫폼</th>
            <th>제목</th>
            <th>내용</th>
            <th>등록/수정일시</th>
            <th>등록/수정자</th>
        </tr>
        </thead>
        <tbody>
        {{#each this.data }}
        <tr>
            <td>{{substr apply_date 0 19}}</td>
            <td>{{{getCommonCodeLabel platform 'content_platform6'}}}</td>
            <td><a href="javascript://" onclick="policyDetail($(this).data().idx, '1');" data-idx="{{idx}}" >{{title}}</a></td>
            <td>{{{replaceHtml desc}}}</td>
            <td>
                {{#dalbit_if upd_date '!=' ''}}
                    {{substr upd_date 0 19}}
                {{else}}
                    {{substr reg_date 0 19}}
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if upd_date '!=' ''}}
                    {{upd_op_name}}
                {{else}}
                    {{reg_op_name}}
                {{/dalbit_if}}
            </td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>



