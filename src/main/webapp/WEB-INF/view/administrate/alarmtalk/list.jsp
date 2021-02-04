<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <input type="hidden" name="empNo" id="empNo" />

                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <select name="posType" class="form-control searchType">
                                        <option value="">직급선택</option>
                                        <c:forEach var="posCode" items="${cfn:getInforexPosCode()}" varStatus="status">
                                            <option value="${posCode.pos_code}">${posCode.pos_name}</option>
                                        </c:forEach>
                                    </select>

                                    <select name="deptType" class="form-control searchType">
                                        <option value="">부서선택</option>
                                        <c:forEach var="deptCode" items="${cfn:getInforexDeptCode()}" varStatus="status">
                                            <option value="${deptCode.dept_no}">${deptCode.new_dept_name}</option>
                                        </c:forEach>
                                    </select>

                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="all_chk" class="_chkAll" data-type='all' /></th>
                                    <th>No.</th>
                                    <th>입사일</th>
                                    <th>부서/팀명</th>
                                    <th>직급/직책</th>
                                    <th>이름</th>
                                    <th>핸드폰</th>
                                    <th>회사메일</th>
                                    <th>개인메일</th>
                                    <th>네이트ID</th>
                                    <th>대상여부</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                    </div>
                    <div class="widget-footer" style="display: none;">
                        <span>
                            <button type="button" id="authority_view" class="btn btn-danger print-btn pull-right mb10">권한부여하기</button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- #DataTable -->
            <div class="row col-lg-12 form-inline mt15" id="authArea" style="display:none;">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 권한부여</h3>
                    </div>
                    <div class="widget-content mt10">

                        <div class="pull-right mb10">
                            <button type="button" id="allSelect" class="btn btn-info">모두선택</button>
                            <button type="button" id="allSelectCancel" class="btn btn-info">모두해제</button>
                        </div>

                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th>Depth 1</th>
                                <th>Depth 2</th>
                                <th>[확인]/[등록/수정]/[삭제]</th>
                                <th>[확인]</th>
                                <th>[등록/수정]</th>
                                <th>[삭제]</th>
                            </tr>
                            </thead>
                            <tbody id="menuInfo"></tbody>
                        </table>
                    </div>
                    <div class="widget-footer">
                        <span>
                            <button type="button" id="authority_btn" class="btn btn-success print-btn pull-right mb10">권한부여</button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    $(document).ready(function() {
        getMemberList();
    });

    $('#searchText').on('keydown', function(e) {
        if (e.keyCode === 13) {
            getMemberList();
        };
    });

    $('#bt_search').on('click', function(){
        getMemberList();
    });

    $('#all_chk').on('click', function(){
        if(!confirm("대상자 전체를 적용 하시겠습니까?")){
            return false;
        }

        editTargetAll($(this).prop('checked'));
        if($(this).prop('checked')){
            $('._memberTableRow').css('color', 'blue');
            $('._chk').prop('checked', true);
            $('._chk').data('type','checked');
            $('._isTarget').text('대상');
        }else{
            $('._memberTableRow').css('color', '');
            $('._chk').prop('checked', false);
            $('._chk').data('type','unchecked');
            $('._isTarget').text('-');
        }
    });

    $(document).on('click', '._chk', function(){
        var me = $(this);

        editTarget(me, me.prop('checked'));
        if(me.prop('checked')){
            me.parent().parent('._memberTableRow').css('color', 'blue');
            me.data('type','checked');
            me.parent().parent('._memberTableRow').find('._isTarget').text('대상');
            me.prop('checked', true);
        }else{
            me.parent().parent('._memberTableRow').css('color', '');
            me.data('type','unchecked');
            me.parent().parent('._memberTableRow').find('._isTarget').text('-');
            me.prop('checked', false);
        }

        if($("input:checkbox[name=empNo]").length == $("input:checkbox[name=empNo]:checked").length){
            $('#all_chk').prop('checked', true);
        }else{
            $('#all_chk').prop('checked', false);
        }

    });


    function editTargetAll(isChecked){
        var insertTargets = [];
        var deleteTargets = [];

        if(isChecked){
            $('._chk').each(function(){
                var empno = $(this).data("empno");
                var phone = $(this).data("phone");
                if(!$(this).prop('checked')){
                    var target = {};
                    if(!common.isEmpty(empno)){
                        target["empno"] = empno;
                        target["phone"] = phone;
                        insertTargets.push(target);
                    }
                }
            })
        }else{
            $('._chk').each(function(){
                var empno = $(this).data("empno");
                var phone = $(this).data("phone");
                if($(this).prop('checked')){
                    var target = {};
                    if(!common.isEmpty(empno)){
                        target["empno"] = empno;
                        target["phone"] = phone;
                        deleteTargets.push(target);
                    }
                }
            })
        }

        var data = new Object();
        data.insertTargets = insertTargets;
        data.deleteTargets = deleteTargets;

        util.getAjaxData("memberList", "/rest/administrate/alarmtalk/edit", data, fn_editTarget_success);
    }


    function editTarget(data, isChecked){
        var insertTargets = [];
        var deleteTargets = [];

        if(isChecked){
            var target = {};
            target["empno"] = data.data("empno");
            target["phone"] = data.data("phone");
            insertTargets.push(target);
        }else{
            var target = {};
            target["empno"] = data.data("empno");
            target["phone"] = data.data("phone");
            deleteTargets.push(target);
        }

        var data = new Object();
        data.insertTargets = insertTargets;
        data.deleteTargets = deleteTargets;

        util.getAjaxData("memberList", "/rest/administrate/alarmtalk/edit", data, function(data, response, params){

        });
    }

    function getMemberList(){
        util.getAjaxData("memberList", "/rest/administrate/alarmtalk/list", $("#searchForm").serialize(), fn_memberList_success);
    }

    function fn_memberList_success(data, response, params){
        dalbitLog(response);
        var template = $('#tmp_memberList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#tableBody").html(html);


        if($("input:checkbox[name=empNo]").length == $("input:checkbox[name=empNo]:checked").length){
            $('#all_chk').prop('checked', true);
        }else{
            $('#all_chk').prop('checked', false);
        }
    }
</script>



<script id="tmp_memberList" type="text/x-handlebars-template">
    {{#each this as |member|}}

    {{#equal alarmTalkTarget '0'}}
        <tr style='cursor: pointer;' class="_memberTableRow">
    {{else}}
        <tr style='cursor: pointer;color: blue;' class="_memberTableRow">
    {{/equal}}

            <td>
                {{#equal alarmTalkTarget '0'}}
                    <input type="checkbox" name="empNo" id="empRadio_{{../emp_no}}" class="_chk" data-empno="{{../emp_no}}" data-phone="{{../staff_hphone}}">
                {{else}}
                    <input type="checkbox" name="empNo" id="empRadio_{{../emp_no}}" class="_chk" data-empno="{{../emp_no}}" data-phone="{{../staff_hphone}}" checked="checked">
                {{/equal}}
            </td>
            <td>{{index @index no}}</td>
            <td>{{staff_enter_date}}</td>
            <td>{{new_dept_name}}</td>
            <td>
                {{#equal staff_pos_name staff_duty_name}}
                    {{member.staff_pos_name}}
                {{else}}
                    {{member.staff_pos_name}}/{{member.staff_duty_name}}
                {{/equal}}
            </td>
            <td>{{staff_name}}</td>
            <td>{{staff_hphone}}</td>
            <td>{{staff_email}}@inforex.co.kr</td>
            <td>{{staff_email_etc}}</td>
            <td>
                {{#equal staff_email_nate ''}}
                    -
                {{else}}
                    {{member.staff_email_nate}}
                {{/equal}}
            </td>
            <td>
                <span class="_isTarget" id="isTarget_{{emp_no}}">
                    {{#equal alarmTalkTarget '0'}}
                        -
                    {{else}}
                        대상
                    {{/equal}}
                </span>
            </td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>