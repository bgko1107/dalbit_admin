<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
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
                            <span id="objType" onchange="init();"></span>
                            <span id="viewType" onchange="init();"></span>
                            <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-12 no-padding">
                <hr class="one">
                <div class="col-md-6 no-padding">
                    <span class="font-bold" style="font-size: 26px">방송TIP 관리</span><br/>
                    <span style="font-size: 14px">방송에서 DJ 및 청취자에게 보여지는 방송 TIP 메시지입니다.</span>
                </div>
                <div class="col-md-6 no-padding">
                    <button type="button" class="btn btn-default btn-sm pull-right" onclick="newTip()">등록</button>
                </div>
            </div>
            <div class="col-md-12 no-padding">
                <div class="widget widget-table">
                    <div class="dataTables_paginate paging_full_numbers" id="broadCastTip_paginate_top"></div>
                    <div class="widget-content mt10 mb10">
                        <table class="table table-sorting table-hover table-bordered no-margin">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>No</th>
                                    <th>노출 대상</th>
                                    <th>TIP 내용</th>
                                    <th>노출 여부</th>
                                    <th>최종 수정일시</th>
                                    <th>최종 수정자</th>
                                </tr>
                            </thead>
                            <tbody id="broadCastTip_list">

                            </tbody>
                        </table>
                    </div>
                    <div class="dataTables_paginate paging_full_numbers" id="broadCastTip_paginate"></div>
                </div>
                <button type="button" class="btn btn-default btn-sm pull-left mt5" id="tipDelete">선택삭제</button>
            </div>
            <div id="tipDetail" style="display: none">
                <div class="col-md-12 no-padding">
                    <hr class="one">
                    <span class="font-bold" style="font-size: 26px">방송 TIP 상세</span>
                    <button type="button" class="btn btn-default btn-sm pull-right" onclick="tipEdit();">저장</button>
                </div>
                <div class="col-md-12 no-padding">
                    <div id="broadCastTip_detail"></div>
                </div>
            </dif>
        </div>
        <!-- //serachBox -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var broadCastTipPagingInfo = new PAGING_INFO(0,1,50);

    var idx;
    $(document).ready(function() {
        $("#objType").html(util.getCommonCodeSelect(-1,broadTip_objType));
        $("#viewType").html(util.getCommonCodeSelect(-1,broadTip_viewType));
        init()
    });

    $('#bt_search').on('click', function(){
        broadCastTipPagingInfo.pageNo = 1;
        init();
    });

    function init(){
        var data = {
            'pageNo': broadCastTipPagingInfo.pageNo
            , 'pageCnt' : broadCastTipPagingInfo.pageCnt
            , 'searchText' : $("#txt_search").val()
            , 'viewTarget' : $("#objType").find("select[name='broadTip_objType']").val()
            , 'viewOn' : $("#viewType").find("select[name='broadTip_viewType']").val()
        };

        console.log(data);
        util.getAjaxData("broadCastTipList", "/rest/content/boardCastTip/list", data, fn_success_broadCastTipList);
    }

    function fn_success_broadCastTipList(dst_id, response){
        $("#tipDetail").hide();
        var template = $('#tmp_broadCastTip_list').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#broadCastTip_list').html(html);

        broadCastTipPagingInfo.totalCnt = response.data.totalCnt;
        util.renderPagingNavigation("list_info_paginate_top", broadCastTipPagingInfo);
        util.renderPagingNavigation("list_info_paginate", broadCastTipPagingInfo);
    }

    function tipDetail(tmp){
        idx = tmp;
        var data = {
            'idx' : idx
        };
        util.getAjaxData("broadCastTipDetail", "/rest/content/boardCastTip/detail", data, fn_success_broadCastTipDetail);
    }
    function fn_success_broadCastTipDetail(dst_id, response){
        $("#tipDetail").show();
        var template = $('#tmp_broadCastTip_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#broadCastTip_detail').html(html);
    }

    function newTip(){
        idx = "";
        $("#tipDetail").show();
        var template = $('#tmp_broadCastTip_detail').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();

        $('#broadCastTip_detail').html(html);
    }

    function tipEdit(){
        var data = {
            'idx' : idx
            ,'viewTarget' : Number($("#detail_viewTarget").find('input[name="viewTarget"]:checked').val())
            ,'viewOn' : Number($("#detail_viewOn").find('input[name="viewOn"]:checked').val())
            ,'tipDesc' : $("#content").val()
        };

        if(!common.isEmpty(idx)){        // 수정
            util.getAjaxData("broadCastTipEdit", "/rest/content/boardCastTip/edit", data, fn_success_tipEdit);
        }else{                      // 신규
            data.idx = 0;
            util.getAjaxData("broadCastTipAdd", "/rest/content/boardCastTip/add", data, fn_success_tipEdit);
        }
    }

    $('#tipDelete').on('click', function() {
        var checked = $('#broadCastTip_list > tr > td > input[type=checkbox]:checked');
        if(checked.length == 0) {
            alert('삭제할 방송Tip을 선택해 주세요.');
            return;
        }
        if(confirm(checked.length + "건의 방송Tip을 삭제하시겠습니까?")) {
            var tipIdxs = '';
            checked.each(function() {
                tipIdxs += $(this).parent().parent().find('._check').data('tipidx') + "|";
            });
            var data = {
                delete_idx_list : tipIdxs.substr(0, tipIdxs.length -1)
            };
            util.getAjaxData("broadCastTipDel", "/rest/content/boardCastTip/del", data, fn_success_tipEdit);
        }
    });

    function fn_success_tipEdit(dst_id, response){
        alert(response.message);
        init();
    }

</script>


<script id="tmp_broadCastTip_list" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
    <tr>
        <td><input type="checkbox" class="_check" data-tipidx="{{idx}}"/></td>
        <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
        <td>{{{getCommonCodeLabel viewTarget 'broadTip_objType'}}}</td>
        <td><a href="javascript://" onclick="tipDetail('{{idx}}');">{{tipDesc}}</td>
        <td>{{{getCommonCodeLabel viewOn 'broadTip_viewType'}}}</td>
        <td>{{updateDate}}</td>
        <td>{{opName}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="6">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script id="tmp_broadCastTip_detail" type="text/x-handlebars-template">
    <div class="widget widget-table">
        <div class="widget-content mt10">
            <table class="table table-sorting table-hover table-bordered datatable">
                <colgroup>
                    <col width="8%"/><col width="20%"/><col width="8%"/><col width="20%"/><col width="8%"/>
                    <col width="10%"/><col width="8%"/><col width="10%"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th>노출 대상</th>
                        <td id="detail_viewTarget">{{{getCommonCodeRadio viewTarget 'broadTip_objType_detail' 'Y' 'viewTarget'}}}</td>
                        <th>노출여부</th>
                        <td id="detail_viewOn">{{{getCommonCodeRadio viewOn 'broadTip_viewType' 'Y' 'viewOn'}}}</td>
                        <th>최종수정일시</th>
                        <td>{{updateDate}}</td>
                        <th>최종수정자</th>
                        <td>{{opName}}</td>
                    </tr>
                    <tr>
                        <th>메시지 내용</th>
                        <th colspan="7">
                            <textarea type="textarea" class="form-control" id="content" name="content" style="width: 100%; height: 100px">{{tipDesc}}</textarea>
                        </th>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</script>