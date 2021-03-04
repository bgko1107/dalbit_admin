<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">

            <%@ include file="/WEB-INF/view/content/event/roulette/rouletteTab.jsp"%>
            <!-- serachBox -->
            <div class="widget widget-table mb15">
                <div class="widget-header">
                    <h3><i class="fa fa-table"></i> 기본권 응모권</h3>
                </div>
                <div class="col-md-12 no-padding">
                    <div class="widget-content mt10 no-padding ml10 mr10">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>꽝</th>
                                    <th>1 exp</th>
                                    <th>3 exp</th>
                                    <th>5 exp</th>
                                    <th>10 exp</th>
                                    <th>1달</th>
                                    <th>3달</th>
                                    <th>상품 A</th>
                                    <th>상품 B</th>
                                    <th>상품 C</th>
                                    <th>상품 D</th>
                                    <th>상품 E</th>
                                    <th>100달</th>
                                    <th>등록/수정일</th>
                                    <th>등록자명</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="giftCntArea">
                                    <th>최대 당첨<br />제한 명수</th>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="1" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="10001" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="10002" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="10003" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="10004" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="2" /></td>
                                    <td>무제한<input type="hidden" class="form-control _data" data-itemNo="3" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="4" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="5" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="6" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="7" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="8" /></td>
                                    <td><input type="text" class="form-control _data" data-itemNo="9" /></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr id="giftRate">
                                    <th>확률(100%)</th>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="form-inline pull-right mr10 mb10">
                    <button class="btn btn-success btn-sm" type="button" id="gift_bt_update">기본 응모권 수정하기</button>
                </div>
            </div>


            <div class="widget widget-table mt15 mb10">
                <div class="widget-header">
                    <h3><i class="fa fa-table"></i> 이벤트형 응모권</h3>
                </div>
                <div class="col-md-12 no-padding">
                    <div class="widget-content mt10 no-padding ml10 mr10">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                                <col width="5%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th></th>
                                <th>꽝</th>
                                <th>1 exp</th>
                                <th>3 exp</th>
                                <th>5 exp</th>
                                <th>10 exp</th>
                                <th>1달</th>
                                <th>3달</th>
                                <th>상품 A</th>
                                <th>상품 B</th>
                                <th>상품 C</th>
                                <th>상품 D</th>
                                <th>상품 E</th>
                                <th>100달</th>
                                <th>등록/수정일</th>
                                <th>등록자명</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr id="eventCntArea" style="display:none;">
                                <th>최대 당첨<br />제한 명수</th>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td>무제한<input type="hidden" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td><input type="text" class="form-control _data" /></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr id="eventRate">
                                <th>확률(100%)</th>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td><input type="text" class="form-control _data" style="width:60px; display:inherit" maxlength="5" /> %</td>
                                <td></td>
                                <td></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="form-inline pull-right mr10 mb10">
                    <button class="btn btn-success btn-sm" type="button" id="event_bt_update">이벤트 응모권 수정하기</button>
                </div>
            </div>
            <!-- // DATA TABLE -->

        </div> <!-- //container-fluid -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/content/eventDataTableSource.js?${dummyData}"></script>

<script type="text/javascript">

    $(function() {
       getList();
    });

    function getList() {

        var giftData = {
            couponType : 1
        }
        util.getAjaxData("giftData" , "/rest/content/event/roulette/selectRouletteRate", giftData, function(dst_id, response){
            if(response.result == 'success'){
                response.data.forEach(function(data, index){
                    $('#giftCntArea td:eq('+index+') input').val(data.limitCnt);
                    $('#giftRate td:eq('+index+') input').val(data.winRate / 100);
                })
            }
        });

        var eventData = {
            couponType : 2
        }
        util.getAjaxData("eventData" , "/rest/content/event/roulette/selectRouletteRate", eventData, function(dst_id, response){
            if(response.result == 'success'){
                response.data.forEach(function(data, index){
                    $('#eventCntArea td:eq('+index+') input').val(data.limitCnt);
                    $('#eventRate td:eq('+index+') input').val(data.winRate / 100);
                })
            }
        });
    }

    $(document).on('click', '#gift_bt_update, #event_bt_update', function(){

        var cntArea = 'giftCntArea';
        var rate = 'eventRate';
        var couponType = 2;

        if(-1 < $(this).prop('id').indexOf('gift')){
            var cntArea = 'giftCntArea';
            var rate = 'giftRate';
            var couponType = 1;
        }

        var isValid = true;

        var editList = '';
        var splitTxt = '|'
        $('#'+cntArea+' td input._data').each(function(index){
            var dalCnt = 0;
            var exp = 0;
            var itemNo = $(this).data('itemno');
            var giftRate = $('#'+rate+' td:eq('+index+') input').val();
            var giftCnt = $('#'+cntArea+' td:eq('+index+') input').val();
            if(common.isEmpty(giftCnt)){
                alert('최대 당첨제한 명수를 입력해주세요.');
                isValid = false;
                $('#'+cntArea+' td:eq('+index+') input').focus();
                return false;
            }

            if(common.isEmpty(giftRate)){
                alert('확률을 입력해주세요.');
                isValid = false;
                $('#'+rate+' td:eq('+index+') input').focus();
                return false;
            }

            if(itemNo == 2){
                dalCnt = 1;
            }else if(itemNo == 3){
                dalCnt = 3;
            }else if(itemNo == 9){
                dalCnt = 100;
            }else if(itemNo == 10001){
                exp = 1;
            }else if(itemNo == 10002){
                exp = 3;
            }else if(itemNo == 10003){
                exp = 5;
            }else if(itemNo == 10004){
                exp = 10;
            }

            editList += itemNo + ',' + dalCnt + ',' + (giftRate * 100) + ',' + giftCnt + ',' + exp;
            if(itemNo != 9){
                editList += splitTxt;
            }
        });
        console.log(editList);
        var param = {
            editList : editList
            , couponType : couponType
        }

        if(!isValid){
            return false;
        }

        if(confirm('수정하시겠습니까?')){
            util.getAjaxData("editRoulette" , "/rest/content/event/roulette/updateRouletteRate", param, function(dst_id, response){
                if(response.code == -1){
                    alert('파라메터가 없습니다.');
                }else if(response.code == -2){
                    alert('확률의 총 합이 100%가 아닙니다.');
                }else{
                    alert(response.message);
                }

            });
        }
    });

</script>

<script id="tmp_rouletteRate" type="text/x-handlebars-template">
    <th>최대 당첨<br />제한 명수</th>
    {{#each this as |data|}}
        <td>{{#equal }}{{/equal}}</td>
    {{/each}}

</script>