
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <form id="searchForm">
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table searchBoxArea">
                <div class="widget-header searchBoxRow">
                    <h3 class="title"><i class="fa fa-search"></i>검색</h3>
                    <div>
                        <span id="search_target_aria"></span>
                        <span id="search_viewYn_aria"></span>
                        <label><input type="text" class="form-control" id="txt_search"></label>
                        <button type="button" class="btn btn-success" id="bt_search">검색</button>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <!-- //serachBox -->
        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline" style="padding-bottom: 15px">
            <div class="pull-left">
                <h4>청취자 행위 유도 관리</h4>
                방송에서 청취자에게 보여지는 방송방 행위 유도 관리입니다.<br />등장 시간은 청취자 입장 후 입니다.
            </div>
            <div class="pull-right">
                <button type="button" id="bt_addMsg" class="btn btn-primary mt10 mr10">추가</button>
            </div>
        </div>
        <div class="row col-lg-12 form-inline">
            <div class="widget widget-table">
                <div class="widget-content">
                    <div class="dataTables_paginate paging_full_numbers" id="behaviorList_paginate_top"></div>
                        <table class="table table-sorting table-hover table-bordered mt15">
                            <thead>
                            <colgroup>
                                <col width="3%"/><col width="3%"/><col width="5%"/><col width="20%"/><col width="5%"/><col width="5%"/>
                                <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                            </colgroup>
                            <tr>
                                <th><input type="checkbox" id="allChk"/></th>
                                <th>No</th>
                                <th>노출 대상</th>
                                <th>행위 유도 내용</th>
                                <th>버튼 명</th>
                                <th>호출(액션)</th>
                                <th>등장 시간</th>
                                <th>지속 시간</th>
                                <th>게시 여부</th>
                                <th>최종 수정 일시</th>
                                <th>최종 수정자</th>
                            </tr>
                            </thead>
                            <tbody id="behaviorList"></tbody>
                        </table>
                    <div class="dataTables_paginate paging_full_numbers" id="behaviorList_paginate"></div>
                </div>
                <div class="widget-footer">
                    <span>
                        <button class="btn btn-danger" type="button" id="bt_deleteBehaviorMsg">선택삭제</button>
                    </span>
                </div>
            </div>
        </div>
        <!-- DATA TABLE END -->

        <div class="row col-lg-12 form-inline">
            <form id="behaviorDetail"/>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var behaviorPagingInfo = new PAGING_INFO(0,1,10);
    $(document).ready(function() {
       getBehaviorList();
       // $('#search_target_aria').html(util.getCommonCodeSelect(-1, behavior_target_search)) // 노출대상 추가 될 시 사용될 예정입니다.
       $('#search_viewYn_aria').html(util.getCommonCodeSelect(-1, behavior_viewYn_search))
    });

    $('#bt_search').on('click', function() {
        getBehaviorList();
    });

    $('input[id="txt_search"]').keydown(function(e){
        if(e.keyCode === 13) {
            getBehaviorList();
        }
    });

    function getBehaviorList() {
        var data = {
            target : $('select[name="target"]').val()
            , viewYn : $('select[name="viewYn"]').val()
            , searchText : $('#txt_search').val()
            , pageNo : behaviorPagingInfo.pageNo
            , pageCnt : behaviorPagingInfo.pageCnt
        }
        util.getAjaxData("getBehaviorList", "/rest/broadcast/behavior/list", data, function fn_getBehaviorList_success(dst_id, response) {
            var template = $('#tmp_behaviorList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#behaviorList').html(html);

            behaviorPagingInfo.totalCnt = response.data.paging.totalCnt;
            util.renderPagingNavigation('behaviorList_paginate_top', behaviorPagingInfo);
            util.renderPagingNavigation('behaviorList_paginate', behaviorPagingInfo);

            if(response.data.length == 0) {
                $('#behaviorList_paginate_top').hide();
                $('#behaviorList_paginate').hide();
            } else {
                $('#behaviorList_paginate_top').show();
                $('#behaviorList_paginate').show();
            }
        });
    }

    $('#bt_addMsg').on('click', function() {
        generateForm();
    });

    function generateForm() {
        if($('#detailTable').length > 0 && common.isEmpty($('#idx').val())) {
            $('#behaviorDetail').empty();
        } else {
            var template = $('#tmp_behaviorDetail').html();
            var templateScript = Handlebars.compile(template);
            var data = {
                target : 1
                , viewYn : 0
                , type : 1
            }
            var context = data;
            var html = templateScript(context);
            $('#behaviorDetail').html(html);
        }
    }

    $(document).on('click', '._viewDetail', function () {
        var data = {
            idx : $(this).data('idx')
        }
        util.getAjaxData("getBehaviorDetail", "/rest/broadcast/behavior/detail", data, function fn_getBehaviorDetail_success(dst_id, response) {
            var template = $('#tmp_behaviorDetail').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $('#behaviorDetail').html(html);
        });
    });

    function validation() {
        if(common.isEmpty($('#conTime').val()) || $('#conTime').val() == 0) {
            alert("등장 시간을 1초 이상 입력해주세요.")
            return false;
        }
        if(common.isEmpty($('#runTime').val()) || $('#runTime').val() == 0) {
            alert("지속 시간을 1초 이상 입력해주세요.")
            return false;
        }
        if(common.isEmpty($('#desc1').val()) || common.isEmpty($('#desc2').val()) || common.isEmpty($('#desc3').val())) {
            alert("행위 유도 내용을 입력해주세요.")
            return false;
        }
        if(common.isEmpty($('#title').val())) {
            alert("버튼명을 입력해주세요.")
            return false;
        }
        return true;
    }

    function handlebarsPaging(targetId, pagingInfo){
        behaviorPagingInfo = pagingInfo;
        getBehaviorList();
    }

    // $(document).on('click', '._chk', function() {
    //     if($(this).prop('checked')) {
    //         $(this).prop('checked', 'checked');
    //         $(this).parent().parent().find('._viewDetail').click();
    //     } else {
    //         $('#behaviorDetail').empty();
    //     }
    // });

    $(document).on('click', '#bt_applyBehaviorMsg', function(){
        if(validation()) {
            if(confirm('메시지를 적용시키시겠습니까?')) {
                var data = {
                    idx : common.isEmpty($('#idx').val()) ? 0 : $('#idx').val()
                    , target : $('input:radio[name="target"]:checked').val()
                    , viewYn : $('input:radio[name="viewYn"]:checked').val()
                    , type : $('input:radio[name="type"]:checked').val()
                    , conTime : $('#conTime').val()
                    , runTime : $('#runTime').val()
                    , desc1 : $('#desc1').val()
                    , desc2 : $('#desc2').val()
                    , desc3 : $('#desc3').val()
                    , title : $('#title').val()
                }
                util.getAjaxData("applyBehaviorMsg", "/rest/broadcast/behavior/apply", data, function fn_applyBehaviorMsg_success(dst_id, response) {
                    alert(response.message);
                    if(response.result == 'success'){
                        getBehaviorList();
                        $("#behaviorDetail").empty();
                    }
                });
            }
        }
    });

    $(document).on('click', '#bt_deleteBehaviorMsg', function() {
        var checked = $('#behaviorList > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 메시지를 선택해주세요.');
            return false;
        }
        if(confirm(checked.length + '건의 메시지를 삭제하시겠습니까?')) {
            var idxs = '';
            checked.each(function() {
               idxs += $(this).parent().parent().find('._viewDetail').data('idx') + "|";
            });
            idxs = idxs.slice(0,-1);
            var data = {
                delete_idx_list : idxs
            }
            util.getAjaxData("deleteBehaviorMsg", "/rest/broadcast/behavior/delete", data, function fn_deleteBehaviorMsg_success(dst_id, response) {

                alert(response.message);
                if(response.result == 'success'){
                    getBehaviorList();
                    $("#behaviorDetail").empty();
                }
            });
        }
    });

    $('#allChk').on('click', function(){
        if($(this).prop('checked')){
            $('._chk').prop('checked', 'checked');
        }else{
            $('._chk').removeAttr('checked');
        }
    });


</script>

<script id="tmp_behaviorList" type="text/x-handlebars-template">
    {{#each this.list as |data|}}
        <tr>
            <td><input type="checkbox" class="_chk" /></td>
            <td>{{indexDesc ../paging.totalCnt data.rowNum}}</td>
            <td>
                {{{getCommonCodeLabel target "behavior_target"}}}
            </td>
            <td class="word-break" style="width: 400px">
                <a href="javascript://" class="_viewDetail" data-idx="{{idx}}">
                {{^equal desc1 ''}}
                   <div>1. {{replaceHtml ../desc1}}</div>
                {{/equal}}
                {{^equal desc2 ''}}
                    <div>2. {{replaceHtml ../desc2}}</div>
                {{/equal}}
                {{^equal desc3 ''}}
                    <div>3. {{replaceHtml ../desc3}}</div>
                {{/equal}}
                </a>
            </td>
            <td>
                {{title}}
            </td>
            <td>
                {{{getCommonCodeLabel type "behavior_type"}}}
            </td>
            <td>{{addComma conTime}}초</td>
            <td>{{addComma runTime}}초</td>
            <td>{{{getCommonCodeLabel viewYn "behavior_viewYn"}}}</td>
            <td>{{convertToDate last_upd_date "YYYY-MM-DD HH:mm:ss"}}</td>
            <td>
                {{opName}}
            </td>
        </tr>
    {{else}}
        <tr>
            <td colspan="11">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_behaviorDetail" type="text/x-handlebars-template">
    <hr class="separator"/>
    <div class="pull-left">
        <h4>청취자 행위 유도 상세</h4>
    </div>
    <div class="pull-right">
        <button type="button" id="bt_applyBehaviorMsg" class="btn btn-primary mr10">적용</button>
        <input type="hidden" id="idx" value="{{idx}}"/>
    </div>
    <table class="table table-bordered table-dalbit mt15" id="detailTable">
        <colgroup>
            <col width="5%" />
            <col width="5%" />
            <col width="5%" />
            <col width="5%" />
            <col width="5%" />
            <col width="5%" />
        </colgroup>
        <tbody>
            <tr class="align-middle">
                <th>노출 대상</th>
                <td>{{{getCommonCodeRadio target "behavior_target" }}}</td>
                <th>등장 시간</th>
                <td>
                    <input type="text" class="form-control _trim" id="conTime" value="{{conTime}}" style="width: 50%;"/> 초
                </td>
                <th>지속 시간</th>
                <td>
                    <input type="text" class="form-control _trim" id="runTime" value="{{runTime}}" style="width: 50%;"/> 초
                </td>
            </tr>
            <tr class="align-middle">
                <th>게시 여부</th>
                <td>{{{getCommonCodeRadio viewYn "behavior_viewYn"}}}</td>
                <th>호출(액션)</th>
                <td colspan="3">{{{getCommonCodeRadio type "behavior_type"}}}</td>
            </tr>
            <tr class="align-middle">
                <th>행위 유도 내용1</th>
                <td colspan="5">
                    <input type="text" class="form-control" id="desc1" value="{{desc1}}" maxlength="100" style="width: 80%;"/>
                </td>
            </tr>
            <tr class="align-middle">
                <th>행위 유도 내용2</th>
                <td colspan="5">
                    <input type="text" class="form-control" id="desc2" value="{{desc2}}" maxlength="100" style="width: 80%;"/>
                </td>
            </tr>
            <tr class="align-middle">
                <th>행위 유도 내용3</th>
                <td colspan="5">
                    <input type="text" class="form-control" id="desc3" value="{{desc3}}" maxlength="100" style="width: 80%;"/>
                </td>
            </tr>
            <tr class="align-middle">
                <th>버튼명</th>
                <td colspan="5">
                    <input type="text" class="form-control" id="title" value="{{title}}" maxlength="20" style="width: 80%;"/>
                </td>
            </tr>
        </tbody>
    </table>
</script>