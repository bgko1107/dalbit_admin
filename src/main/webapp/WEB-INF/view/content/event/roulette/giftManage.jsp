<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">

            <%@ include file="/WEB-INF/view/content/event/roulette/rouletteTab.jsp"%>
            <!-- serachBox -->
            <div class="widget widget-table mb10">
                <div class="widget-header">
                    <h3><i class="fa fa-table"></i> <span id="summary_today"></span> 선물지급관리</h3>
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
                            </colgroup>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>꽝</th>
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
                            <tbody id="loginLiveTableBody">
                                <tr id="giftCntArea">
                                    <th>최대 당첨<br />제한 명수</th>
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
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- // DATA TABLE -->
            <div class="form-inline pull-right">
                <button class="btn btn-success btn-sm" type="button" id="bt_update">수정하기</button>
            </div>
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
        util.getAjaxData("today_summary" , "/rest/content/event/roulette/selectRouletteRate", null, function(dst_id, response){
            if(response.result == 'success'){
                response.data.forEach(function(data, index){
                    $('#giftCntArea td:eq('+index+') input').val(data.limitCnt);
                    $('#giftRate td:eq('+index+') input').val(data.winRate / 100);
                })
            }
        });
    }

    $(document).on('click', '#bt_update', function(){
        var isValid = true;

        var editList = '';
        var splitTxt = '|'
        $('#giftCntArea td input._data').each(function(index){
            var dalCnt = 0;
            var giftRate = $('#giftRate td:eq('+index+') input').val();
            var giftCnt = $('#giftCntArea td:eq('+index+') input').val();
            if(common.isEmpty(giftCnt)){
                alert('최대 당첨제한 명수를 입력해주세요.');
                isValid = false;
                $('#giftCntArea td:eq('+index+') input').focus();
                return false;
            }

            if(common.isEmpty(giftRate)){
                alert('확률을 입력해주세요.');
                isValid = false;
                $('#giftRate td:eq('+index+') input').focus();
                return false;
            }

            if(index == 1){
                dalCnt = 1;
            }else if(index == 2){
                dalCnt = 3;
            }
            editList += index + 1 + ',' + dalCnt + ',' + (giftRate * 100) + ',' + giftCnt;
            if(index != 8){
                editList += splitTxt;
            }
        });
        console.log(editList);
        var param = {
            editList : editList
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