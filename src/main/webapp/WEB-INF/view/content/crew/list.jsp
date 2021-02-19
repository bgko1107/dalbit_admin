<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <%--<span id="searchTypeAria"></span>--%>
                                    <span id="searchMemberArea" onchange="btSearchClick();"></span>
                                    <label><input type="text" class="form-control _trim" name="searchText" id="searchText" placeholder="크루원을 검색하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->

            <div class="col-lg-12 form-inline">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <h3 class="title">크루등록</h3>
                        <label>
                            <input type="text" class="form-control _trim" name="crewName" id="crewName" style="width:200px;" placeholder="등록할 크루 표식을 입력하세요.">
                        </label>
                        <button type="button" class="btn btn-danger" id="bt_insertCrewName">등록</button>
                    </div>
                </div>
            </div>

            <!-- DATA TABLE -->

             <!-- 크루 정보 -->
             <div class="col-lg-12 form-inline pt5">
                 <div class="widget widget-table">
                     <div class="widget-header">
                         <h3><i class="fa fa-table"></i>크루 정보</h3>
                     </div>
                     <div class="widget-content mt10">

                         <div class="pull-right">
                             <input type="checkbox" id="monthPayChk" /> <label for="monthPayChk">월 결제 건 순으로 보기</label>
                         </div>

                         <table class="table table-bordered">
                             <colgroup>
                                 <col width="3%"/>
                                 <col width="10%"/>
                                 <col width="15%"/>
                                 <col width="10%"/>
                                 <col width="5%"/>
                                 <col width="5%"/>
                                 <col width="10%"/>
                                 <col width="10%"/>
                                 <col width="10%"/>
                                 <col width="5%"/>
                             </colgroup>
                             <thead>
                                 <tr>
                                     <th><input type="checkbox" name="allChk_crew" /></th>
                                     <th>크루 표식</th>
                                     <th>크루명</th>
                                     <th>크루장</th>
                                     <th>인원</th>
                                     <th>평균 레벨</th>
                                     <th>월간 결제건</th>
                                     <th>월간 결제금액</th>
                                     <th>크루 등록일</th>
                                     <th>크루 진행중</th>
                                 </tr>
                             </thead>
                             <tbody id="crewInfo"></tbody>
                         </table>
                         <div class="dataTables_paginate paging_full_numbers" id="crew_paginate"></div>
                     </div>
                     <div class="widget-footer">
                         <span>
                             <button class="btn btn-default" type="button" id="bt_updateDelStateCrew">선택삭제</button>
                         </span>
                     </div>
                 </div>
             </div>
             <!-- //테스트 계정 현황 -->

             <!-- 크루원 정보 -->
             <div class="col-lg-12 form-inline pt15">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <h3 class="title">크루원 등록</h3>
                        <label>
                            <input type="text" class="form-control _trim" name="crew" id="crew" placeholder="크루 정보에서 선택하세요.">
                            <input type="hidden" id="crewIdx" name="crewIdx"/>
                        </label>
                        <span id="crewMemberInfoArea"></span>
                        <label>
                            <input type="text" class="form-control _trim" name="crewMemberInfo" id="crewMemberInfo" style="width:250px;" placeholder="등록하실 크루원 정보를 입력하세요.">
                        </label>
                        <%-- 해당되는 정보가 없으면 alert창 띄우기 --%>
                        <button type="button" class="btn btn-danger" id="bt_insertCrewMember">등록</button>
                    </div>
                </div>
             </div>

             <div class="col-lg-12 form-inline pt5">
                 <div class="widget widget-table">
                     <div class="widget-header">
                         <h3><i class="fa fa-desktop"></i>크루원 정보</h3>
                     </div>
                     <div class="widget-content mt10">
                         <div class="dataTables_paginate paging_full_numbers" id="crewMem_paginate_top"></div>
                             <table id="list_info" class="table table-sorting table-hover table-bordered">
                                 <colgroup>
                                     <col width="3%"/>
                                     <col width="4%"/>
                                     <col width="10%"/>
                                     <col width="5%"/>
                                     <col width="12%"/>
                                     <col width="11%"/>
                                     <col width="7%"/>
                                     <col width="9%"/>
                                     <col width="9%"/>
                                     <col width="7%"/>
                                     <col width="8%"/>
                                     <col width="7%"/>
                                     <col width="5%"/>
                                     <col width="5%"/>
                                 </colgroup>
                                 <thead>
                                     <tr>
                                         <th><input type="checkbox" name="allChk_crewMem" /></th>
                                         <th>No</th>
                                         <th>크루 표식</th>
                                         <th>회원상태</th>
                                         <th>닉네임</th>
                                         <th>최근 접속 일시</th>
                                         <th>최근 7일 접속</th>
                                         <th>최근 방송 일시</th>
                                         <th>보낸 달</th>
                                         <th>받은 별</th>
                                         <th>일간 DJ 랭킹</th>
                                         <th>레벨</th>
                                         <th>회원가입일</th>
                                         <th>크루장</th>
                                     </tr>
                                 </thead>
                                 <tbody id="crewMemberList">
                                 </tbody>
                             </table>
                         <div class="dataTables_paginate paging_full_numbers" id="crewMem_paginate"></div>
                     </div>
                     <div class="widget-footer">
                         <span>
                             <button class="btn btn-default" type="button" id="bt_deleteCrewMember">선택삭제</button>
                         </span>
                         <span>
                             <button class="btn btn-primary ml15" type="button" id="bt_pushSendCrewMem">PUSH 발송</button>
                         </span>
                     </div>
                 </div>
             </div>
             <!-- //검색결과 -->
            </div>
            <!-- #DataTable -->
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script>
    var crewPagingInfo = new PAGING_INFO(0,1,10);
    var crewMemberPagingInfo = new PAGING_INFO(0,1,20);

    $(document).ready(function() {
        init();
    });

    $('#bt_search').on('click', function() {
        getCrewInfo();
        getCrewMemberInfo();
    });

    $('input[id="searchText"]').keydown(function() {
        if (event.keyCode === 13) {
            getCrewInfo();
            getCrewMemberInfo();
        }
    });

    function init(){
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));
        $('#searchTypeAria').html(util.getCommonCodeSelect(null, attendance_searchType));
        $('#crewMemberInfoArea').html(util.getCommonCodeSelect(null, crew_searchType));
        $('#crew').attr('readonly', true);
        getCrewInfo();
        getCrewMemberInfo();
    }

    $('input:checkbox[name="allChk_crew"]').on('click', function() {
        if($(this).prop('checked')) {
            $('._chk_crew').prop('checked', 'checked');
        } else {
            $('._chk_crew').removeAttr('checked');
        }
    });
    $('input:checkbox[name="allChk_crewMem"]').on('click', function() {
        if($(this).prop('checked')) {
            $('._chk_crewMem').prop('checked', 'checked');
        } else {
            $('._chk_crewMem').removeAttr('checked');
        }
    });

    $('#bt_insertCrewName').on('click', function() {
        if(common.isEmpty($('#crewName').val())) {
            alert('크루 표식을 입력해주세요.');
        } else {
            if(confirm('크루 표식을 등록하시겠습니까?')) {
                insertCrewName();
            } else {
                return false;
            }
        }
    });

    $('input[id="crewName"]').keydown(function() {
        if (event.keyCode === 13) {
            if(common.isEmpty($('#crewName').val())) {
                alert('크루 표식을 입력해주세요.');
            } else {
                if(confirm('크루 표식을 등록하시겠습니까?')) {
                    insertCrewName();
                } else {
                    return false;
                }
            }
        }
    });

    $(document).on('click', '#bt_updateCrewMemo', function() {
        var crewIdx = $(this).data("idx");
        var crewMemo = $("#crewMemo_"+crewIdx).val();

        if(common.isEmpty(crewMemo)) {
            alert('크루명을 입력해주세요.');
        } else {
            if(confirm('크루명을 등록하시겠습니까?')) {
                var data = {
                    'crewIdx' : crewIdx
                    ,'crewMemo' : crewMemo
                };

                util.getAjaxData("insertCrewName", "/rest/content/crew/updateCrewMemo", data, fn_insertCrewName_success);
            } else {
                return false;
            }
        }
    });

    function insertCrewName() {
        var data = {
            'crewName' : $('#crewName').val().replace(/ /gi, '')
        };
        util.getAjaxData("insertCrewName", "/rest/content/crew/insertCrewName", data, fn_insertCrewName_success);
    }

    function fn_insertCrewName_success(dst_id, response) {
        alert(response.message);
        getCrewInfo();
        getCrewMemberInfo();
    }

    $('#bt_insertCrewMember').on('click', function() {
       if(common.isEmpty($('#crewIdx').val())) {
           alert('등록할 크루를 선택해주세요.');
       } else if(common.isEmpty($('#crewMemberInfo').val())) {
           alert('크루원 정보를 입력해주세요.');
       } else {
           if(confirm('크루원으로 등록하시겠습니까?')) {
               insertCrewMember();
           }
       }
    });

    $('input[id="crewMemberInfo"]').keydown(function() {
        if (event.keyCode === 13) {
            if(common.isEmpty($('#crewIdx').val())) {
                alert('등록할 크루를 선택해주세요.');
            } else if(common.isEmpty($('#crewMemberInfo').val())) {
                alert('크루원 정보를 입력해주세요.');
            } else {
                if(confirm('크루원으로 등록하시겠습니까?')) {
                    insertCrewMember();
                }
            }
        }
    });

    function insertCrewMember() {
        var data = {
            'searchType' : $('#crewSearchType option:selected').val()
            , 'crewIdx' : $('#crewIdx').val()
            , 'memInfo' : $('#crewMemberInfo').val()
        };
        util.getAjaxData("insertCrewMember", "/rest/content/crew/insertCrewMember", data, fn_insertCrewMember_success);
    }

    function fn_insertCrewMember_success(dst_id, response) {
        alert(response.message);
        getCrewInfo();
        getCrewMemberInfo();
    }

    function getCrewInfo() {
        var data = {
            'pageStart' : crewPagingInfo.pageNo
            , 'pageCnt' : crewPagingInfo.pageCnt
            , 'slct_type' : $('#monthPayChk').prop('checked') ? 1 : 0
            , 'newSearchType' : $("#searchMember").val()
        };
        util.getAjaxData("selectCrewInfo", "/rest/content/crew/selectCrewInfo", data, fn_selectCrewInfo_success);
    }

    function fn_selectCrewInfo_success(dst_id, response) {
        var template = $('#tmp_crewInfo').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#crewInfo').html(html);

        crewPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('crew_paginate', crewPagingInfo);
    }

    function getCrewMemberInfo() {
        var data = {
            'searchType' : $('#searchType').val()
            , 'searchText' : $('#searchText').val().replace(/ /gi, '')
            , 'pageStart' : crewMemberPagingInfo.pageNo
            , 'pageCnt' : crewMemberPagingInfo.pageCnt
            , 'newSearchType' : $("#searchMember").val()
        };
        util.getAjaxData("selectCrewMemberInfo", "/rest/content/crew/selectCrewMemberInfo", data, fn_selectCrewMemberInfo_success);
    }

    function fn_selectCrewMemberInfo_success(dst_id, response) {
        var template = $('#tmp_crewMemberList').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#crewMemberList').html(html);

        $('input:checkbox[class="_chk_crewMem"]').each(function() {
            var memState = $(this).parent().parent().find('._memState').data('mem_state');
            if(memState != 1 && memState != 2){
                $(this).attr('disabled', true);
            }
        });

        crewMemberPagingInfo.totalCnt = response.pagingVo.totalCnt;
        /*util.renderPagingNavigation('crew_paginate_top', crewPagingInfo);*/
        /*util.renderPagingNavigation('crew_paginate', crewMemberPagingInfo);*/
        util.renderPagingNavigation('crewMem_paginate_top', crewMemberPagingInfo);
        util.renderPagingNavigation('crewMem_paginate', crewMemberPagingInfo);

    }

    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == 'crew_paginate'){
            crewPagingInfo = pagingInfo;
            getCrewInfo();
        }else{
            crewMemberPagingInfo = pagingInfo;
            getCrewMemberInfo();
        }
    }

    function displayCrew(name, idx) {
        $('#crew').val(name);
        $('#crewIdx').val(idx);

        $("#searchText").val(name);
        $('#searchType').find('option[value="4"]').prop('selected', 'selected');

        getCrewMemberInfo();
    }

    $(document).on('change', '._leaderYN', function() {
        var me = $(this);
        var message = me.prop('checked') ? '크루장으로 등록하시겠습니까?' : '크루장을 해제하시겠습니까?';

        if(confirm(message)) {
            var data = {
                'idx' : $(this).data('idx')
                , 'crewIdx' : $(this).data('crewidx')
                , 'leader_yn' : $(this).prop('checked') ? 1 : 0
                , 'memNo' : $(this).data('memno')
            };
            console.log(data);

            util.getAjaxData("leaderYN", "/rest/content/crew/updateCrewLeader", data, function(dst_id, response){
                alert(response.message);
                getCrewInfo();
                getCrewMemberInfo();
            });
        }
    });

    $('#bt_updateDelStateCrew').on('click', function() {
        var checked = $('#crewInfo > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 크루명을 선택해 주세요.');
            return;
        }

        if(confirm(checked.length + "건의 크루를 삭제하시겠습니까?")) {
            var crewIdxs = '';
            checked.each(function() {
               crewIdxs += $(this).parent().parent().find('._crewInfo').data('crewidx') + ",";
            });
            var data = {
                crewIdxs : crewIdxs
            };
            util.getAjaxData("updateDelStateCrew", "/rest/content/crew/updateDelStateCrew", data, fn_updateDelStateCrew_success);
        }
    });

    function fn_updateDelStateCrew_success(dst_id, response) {
        alert(response.message + '\n-성공 : ' + response.data.sucCnt + '건\n-실패 : ' + response.data.failCnt + '건');
        getCrewInfo();
        getCrewMemberInfo();
    }

    $('#bt_deleteCrewMember').on('click', function() {
        var checked = $('#crewMemberList > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 크루원을 선택해 주세요.');
            return;
        }
        if(confirm(checked.length + "건의 크루원을 삭제하시겠습니까?")) {
            var crewMemberIdxs = '';
            checked.each(function () {
                crewMemberIdxs += $(this).parent().find('._crewMember').data('memidx') + ",";
            });
            var data = {
                crewMemberIdxs: crewMemberIdxs
            };
            console.log(data);
            util.getAjaxData("deleteCrewMember", "/rest/content/crew/deleteCrewMember", data, fn_deleteCrewMember_success);
        }
    });

    function fn_deleteCrewMember_success(dst_id, response) {
        alert(response.message + '\n-성공 : ' + response.data.sucCnt + '건\n-실패 : ' + response.data.failCnt + '건');
        getCrewInfo();
        getCrewMemberInfo();
    }


    $(document).on('click', '.onoffswitch-checkbox' , function(event){
        var me = $(this);

        if(confirm('진행중 상태를 변경하시겠습니까?')){
            var data = {
                crewIdx : me.prop('name')
                , state : me.prop('checked') ? 1 : 0
            }
            util.getAjaxData('stateChange', "/rest/content/crew/updateState", data, function(dist_id, response){

            });
        }else{
            event.preventDefault();
        }
    });

    $('#monthPayChk').on('click', function(){
        init();
    });

    $('#bt_pushSendCrewMem').on('click', function() {
        var checked = $('input:checkbox[class="_chk_crewMem"]:checked');
        if(checked.length == 0) {
            alert('PUSH 발송할 크루원을 선택해 주세요.');
            return false;
        }

        var memNoList='';
        checked.each(function() {
           memNoList += $(this).data('mem_no') + ",";
        });
        util.pushSendLink(memNoList, $(this).attr('id'));
    });

    function btSearchClick(){
        $("#bt_search").click();
    }

</script>

<script id="tmp_crewInfo" type="text/x-handlebars-template">
    {{#each this}}
        <tr>
            <td><input type="checkbox" class="_chk_crew"></td>
            <td><a href="javascript://" onclick="displayCrew('{{this.crewName}}', '{{this.crewIdx}}');" class="_crewInfo" data-crewidx="{{this.crewIdx}}">{{crewName}}</a></td>
            <td>
                <input type="text" id="crewMemo_{{crewIdx}}" value="{{crewMemo}}" style="width:70%">
                <button type="button" class="btn btn-success btn-xs" id="bt_updateCrewMemo" data-idx="{{crewIdx}}"> 저장</button>
            </td>
            <td>
                {{#equal crewLeader ''}}
                -
                {{else}}
                {{../crewLeader}}
                {{/equal}}
            </td>
            <td>{{addComma crewCnt}}명</td>
            <td>{{addComma levelAvg}}</td>
            <td>{{addComma payCnt}}</td>
            <td>{{addComma payAmtSum}}</td>
            <td>{{regDate}}</td>
            <td>{{{getOnOffSwitch state crewIdx}}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_crewMemberList" type="text/x-handlebars-template">
    {{#each this.data as |user|}}
        <tr>
            <td><input type="checkbox"  class="_chk_crewMem" data-mem_no="{{user.mem_no}}"/><input type="hidden" class="_crewMember" data-memidx="{{user.idx}}"/> </td>
            <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
            <td>
                {{#equal user.crewName ''}}
                    -
                {{else}}
                    {{user.crewName}}
                {{/equal}}
            </td>
            <td class="_memState" data-mem_state="{{user.memState}}">{{{getMemStateName user.memState}}}</td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{user.mem_no}}">{{user.memNick}}</a>
            </td>
            <td>{{user.lastLoginDate}}</td>
            <td>{{user.weekLoginCnt}}회</td>
            <td>{{user.broadDate}}</td>
            <td>{{addComma user.present}}</td>
            <td>{{addComma user.receive}}
            <td>
                {{#equal user.ranking '9999'}}
                    -
                {{else}}
                    {{user.ranking}}
                {{/equal}}
            </td>
            <td>{{user.level}}</td>
            <td>{{user.mem_join_date}}</td>
            <td>
                <div class="control-inline onoffswitch">
                    <input type="checkbox" name="leaderYN" id="leaderYN{{user.idx}}" class="onoffswitch-checkbox _leaderYN" data-memno="{{user.mem_no}}" data-idx="{{user.idx}}" data-crewidx="{{user.crewIdx}}" {{#dalbit_if user.leader_yn "==" "1"}}checked{{/dalbit_if}}>
                    <label class="onoffswitch-label" for="leaderYN{{user.idx}}">
                        <span class="onoffswitch-inner"></span>
                        <span class="onoffswitch-switch"></span>
                    </label>
                </div>
            </td>
        </tr>
    {{else}}
        <tr>
            <td colspan="14">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>