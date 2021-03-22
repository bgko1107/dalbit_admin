<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />

<form id="condition5">
    <div class="col-lg-12 no-padding form-inline mt15 mb15">
        <div class="widget widget-table">
            <div class="widget-header">
                <h3>영상대화 차감관리</h3>
            </div>
            <div class="widget-content mt10">
                <table id="videoSetting" class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="2%"/>
                        <col width="10%"/>
                        <col width="2%"/>
                        <col width="3%"/>
                        <col width="3%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>No</th>
                        <th>구분</th>
                        <th>개수(달)</th>
                        <th>최근 수정일</th>
                        <th>수정자명</th>
                    </tr>
                    </thead>
                    <tbody id="videoSettingCondition">
                    </tbody>
                </table>
            </div>
            <div class="widget-footer" style="text-align: right">
                <span>
                    <button class="btn btn-default full-right" type="button" id="bt_videoSettingEdit">수정하기</button>
                </span>
            </div>
        </div>
    </div>
</form>
    <div id="videoSettingDetail">
    </div>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var beforeData;

    $(document).ready(function() {
        videoSettingCondition();
    });

    function videoSettingCondition(){
        var data = {}
        util.getAjaxData("videoSettingList", "/rest/content/video/setting/list", data, function(dst_id, response) {
            var template = $("#tmp_videoSettingCondition").html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#videoSettingCondition").html(html);

            beforeData = response.data;
        });
    }

    function videoSettingDetail(data){
        var data = {
           index : data.idx
        }
        util.getAjaxData("videoSettingDetail", "/rest/content/video/setting/detail", data, fn_success_videoSettingDetail);
    }

    function fn_success_videoSettingDetail(dst_id, response, param) {
        response.data.rowNum = param.rowNum;
        var template = $('#tmp_videoSettingDetailTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#videoSettingDetail').html(html);
    }

    $('#bt_videoSettingEdit').on('click', function(){
        var data = {
            index_1 : $('#index_1').text()
            , index_2 : $('#index_2').text()
            , index_3 : $('#index_3').text()
            , dal_1 : $('#dal_1').val()
            , dal_2 : $('#dal_2').val()
            , dal_3 : $('#dal_3').val()
            , beforeDal_1 : beforeData[0].dal
            , beforeDal_2 : beforeData[1].dal
            , beforeDal_3 : beforeData[2].dal

        }
        if(confirm('수정하시겠습니까?')) {
            util.getAjaxData("videoSettingDetail", "/rest/content/video/setting/edit", data, fn_success_videoSettingEdit);
        }
    });

    function fn_success_videoSettingEdit(dst_id, response, param){
        $('#videoSettingDetail').empty();
        videoSettingCondition();
    }

</script>

<script id="tmp_videoSettingCondition" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td id="index_{{idx}}" name="index_{{idx}}">{{idx}}</td>
            <td><a href="javascript://" onclick="videoSettingDetail($(this).data())" data-idx="{{idx}}">{{gubun}}</a></td>
            <td>
                <input type="text" class="form-control pull-left ml15" style="width: 30%;" value="{{dal}}" id="dal_{{idx}}" name="dal_{{idx}}"/>
                <span class="pull-left ml5">개
                    {{#dalbit_if idx '==' 2}}이상{{/dalbit_if}}
                    {{#dalbit_if idx '==' 3}}이하{{/dalbit_if}}
                </span>
            </td>
            <td>{{moment last_upd_date 'YYYY-MM-DD HH:mm:ss'}}</td>
            <td>{{op_name}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_videoSettingDetailTable" type="text/x-handlebars-template">
    <div class="col-lg-12 no-padding">
        <div class="widget-content">
            <div id="tabContainer">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li class="active"><a href="#" role="tab" data-toggle="tab" id="tab_condition" class="_videoSettingTab">수정 관리</a></li>
                </ul>
            </div>

            <div class="col-lg-12 no-padding">
                <br/><span class="font-bold">운영자에 의해 정보가 수정된 일시를 확인할 수 있습니다.</span>
            </div>
        </div>
    </div>
    <table class="table table-sorting table-hover table-bordered mt10">
        <colgroup>
            <col width="2%"/>
            <col width="4%"/>
            <col width="10%"/>
            <col width="3%"/>
        </colgroup>
        <thead>
        <tr>
            <th>No</th>
            <th>수정일자</th>
            <th>수정내용</th>
            <th>처리자명</th>
        </tr>
        </thead>
        <tbody>
        {{#each this}}
            <tr>
                <td>{{rowNumDesc ../length @index}}</td>
                <td>{{moment last_upd_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                <td>{{replaceHtml desc}}</td>
                <td>{{op_name}}</td>
            </tr>
        {{else}}
            <tr>
                <td colspan="4">{{isEmptyData}}</td>
            </tr>
        {{/each}}
        </tbody>
    </table>
</script>