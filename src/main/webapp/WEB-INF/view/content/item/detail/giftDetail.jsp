<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="wrapper">
    <form id="targetForm"></form>
</div>


<script src="../../../js/lib/jquery.table2excel.js"></script>

<script>
    $(document).ready(function () {
        fnc_giftDetail.init();
    });


    var fnc_giftDetail = {};
//=------------------------------ Init / Event--------------------------------------------
    fnc_giftDetail.targetId= "giftDetail";
    fnc_giftDetail.formId= "giftDetailForm";

    fnc_giftDetail.init= function() {
        fnc_giftDetail.target = $("#"+fnc_giftDetail.targetId);
        fnc_giftDetail.target.find("#targetForm").attr("id", fnc_giftDetail.targetId + "Form");
        fnc_giftDetail.formId = fnc_giftDetail.targetId + "Form";

        if(common.isEmpty(getSelectDataInfo())){
            fnc_giftDetail.insertDetail();
        }else{
            console.log(getSelectDataInfo());

            var data = new Object();
            data.item_code = getSelectDataInfo().data.item_code;

            util.getAjaxData(fnc_giftDetail.targetId, "/rest/content/item/gift/detail",data, fnc_giftDetail.fn_detail_success, fnc_giftDetail.fn_fail);
        }

        // this.initDetail();
        // this.initDetailEvent();
    };


    // 초기 설정
    fnc_giftDetail.initDetail= function() {

    };

    // 이벤트 적용
    fnc_giftDetail.initDetailEvent= function(){

        // 등록 버튼
        fnc_giftDetail.target.find("#insertBtn").on("click", function () {
            if(!confirm("등록 하시겠습니까?")){
                return false;
            }

            var data = fnc_giftDetail.getDetailData();

            if(!fnc_giftDetail.isValid(data)){
                return false;
            }
            util.getAjaxData("insert", "/rest/content/item/gift/insert", data, fnc_giftDetail.fn_insert_success, fnc_giftDetail.fn_fail);
        })


        // 수정 버튼
        fnc_giftDetail.target.find("#updateBtn").on("click", function () {
            if(!confirm("수정 하시겠습니까?")){
                return false;
            }

            var data = fnc_giftDetail.getDetailData();

            if(!fnc_giftDetail.isValid(data)){
                return false;
            }
            util.getAjaxData("upldate", "/rest/content/item/gift/update", data, fnc_giftDetail.fn_update_success, fnc_giftDetail.fn_fail);
        })

        fnc_giftDetail.target.find('#preSoundBtn').on('click', function(){
            var sound_url = $('#sound_url').val();

            if(common.isEmpty(sound_url)){
                alert('사운드 URL을 입력해주세요.');
                return;
            }
            document.getElementById("soundAudio").src = sound_url;
            document.getElementById("soundAudio").load();
            document.getElementById("soundAudio").play();
        });
    };


    //수정 데이터 조회 후 UI 처리
    fnc_giftDetail.initUpdateUI= function(){
        var detailData = getSelectDataInfo().detailData;

        //platform
        var platformCode = detailData.platform.split("");
        for(var i = 0; i < platformCode.length; i++){
            if(platformCode[i] == "1"){
                fnc_giftDetail.target.find("#platform"+(i+1)).attr("checked", true);
            }
        }


        //item_type
        var item_typeCode = detailData.item_type.split("");
        for(var i = 0; i < item_typeCode.length; i++){
            if(item_typeCode[i] == "1"){
                fnc_giftDetail.target.find("#item_type"+(i+1)).attr("checked", true);
            }
        }
    };


    // 등록 화면
    fnc_giftDetail.insertDetail= function() {
        var template = $('#tmp_giftDetailFrm').html();
        var templateScript = Handlebars.compile(template);
        fnc_giftDetail.target.find("#"+this.formId).html(templateScript);

        fnc_giftDetail.initDetail();
        fnc_giftDetail.initDetailEvent();
    };


    // 수정 화면
    fnc_giftDetail.updateDetail= function(){
        var detailData = getSelectDataInfo().detailData;
        detailData.rowNum = getSelectDataInfo().data.rowNum;


        // form 띄우기
        var template = $('#tmp_giftDetailFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = detailData;
        var html = templateScript(context);
        fnc_giftDetail.target.find("#"+ fnc_giftDetail.formId).html(html);

        fnc_giftDetail.initDetail();
        fnc_giftDetail.initDetailEvent();
        fnc_giftDetail.initUpdateUI();
    };

//=------------------------------ Option --------------------------------------------

    // 상세 목록 조회 성공 시
    fnc_giftDetail.fn_detail_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        setSelectDataInfo("detailData", data.data);

        fnc_giftDetail.updateDetail();

        var scrollPosition = $("#tab_giftDetail").offset();
        util.scrollPostion(scrollPosition.top);
    };


    // 등록 성공 시
    fnc_giftDetail.fn_insert_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        alert(data.message);

        fnc_giftList.selectMainList(false);

        //하위 탭 초기화
        initContentTab();
        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#"+fnc_giftDetail.formId).empty();
    };


    // 수정 성공 시
    fnc_giftDetail.fn_update_success= function(dst_id, data, dst_params){
        if(data.result == "fail"){
            alert(data.message);
            return false;
        }

        alert(data.message);

        fnc_giftList.selectMainList(false);

        //하위 탭 초기화
        initContentTab();
        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#"+fnc_giftDetail.formId).empty();
    };


    // Ajax 실패
    fnc_giftDetail.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };

//=------------------------------ Data Handler ----------------------------------

    // 데이터 가져오기
    fnc_giftDetail.getDetailData= function(){
        var resultJson ={};

        var formArray = fnc_giftDetail.target.find("#" + this.formId).serializeArray();
        for (var i = 0; i < formArray.length; i++){
            resultJson[formArray[i]['name']] = formArray[i]['value'];
        }

        //platform
        var platformCnt = fnc_giftDetail.target.find("input[name=platform]").length;
        var platform = "";
        for(var i = 0; i < platformCnt; i++){
            if(fnc_giftDetail.target.find("#platform"+(i+1)).is(":checked")){
                platform += "1";
            }else{
                platform += "0";
            }
        }
        resultJson['platform'] = platform;

        //item_type
        var item_typeCnt = fnc_giftDetail.target.find("input[name=item_type]").length;
        var item_type = "";
        for(var i = 0; i < item_typeCnt; i++){
            if(fnc_giftDetail.target.find("#item_type"+(i+1)).is(":checked")){
                item_type += "1";
            }else{
                item_type += "0";
            }
        }
        resultJson['item_type'] = item_type;

        //discount_rate
        var discount_rate = fnc_giftDetail.target.find("input[name=discount_rate]:checked");
        if(discount_rate.val() == "-1"){
            resultJson['discount_rate'] = fnc_giftDetail.target.find("#inputDiscountEtc").val();
        }


        //item_price_ios TODO 알아봐야함...
        resultJson['item_price_ios'] = 0;

        //sound 아이템
        var sound_yn = fnc_giftDetail.target.find("input[name=sound_yn]");
        if(sound_yn.prop('checked')){
            //webp 파일명 && lottie 파일명 수정
            var sound_url = fnc_giftDetail.target.find("input[name=sound_url]");
            resultJson['sound_file_name'] = util.getFileName(sound_url.val(), false);
        }else{
            resultJson['sound_url'] = '';
            resultJson['sound_file_name'] = '';
        }

        //webp 파일명 && lottie 파일명 수정
        var webp_image = fnc_giftDetail.target.find("input[name=webp_image]");
        resultJson['webp_file_name'] = util.getFileName(webp_image.val(), false);

        var jason_image = fnc_giftDetail.target.find("input[name=jason_image]");
        resultJson['jason_file_name'] = util.getFileName(jason_image.val(), false);

        return resultJson;
    };


    fnc_giftDetail.isValid= function(data){

        if(common.isEmpty(data.platform) || data.platform == "000"){
            alert("플랫폼을 선택하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=platform]").focus();
            return false;
        }

        if(data.platform == "001" && common.isEmpty(data.item_code)){
            alert("아이템 코드를 입력하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=item_code]").focus();
            return false;
        }

        if(common.isEmpty(data.item_name)){
            alert("아이템 명을 입력하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=item_name]").focus();
            return false;
        }

        if(common.isEmpty(data.play_time)){
            alert("플레이타임을 입력하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=play_time]").focus();
            return false;
        }

        if(common.isEmpty(data.byeol)){
            alert("지급 별 수량을 입력하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=byeol]").focus();
            return false;
        }

        if(common.isEmpty(data.item_price)){
            alert("아이템 가격을 입력하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=item_price]").focus();
            return false;
        }

        if(common.isEmpty(data.view_yn)){
            alert("게시 여부를 확인하여 주시기 바랍니다.");
            fnc_giftDetail.target.find("input[name=view_yn]").focus();
            return false;
        }

        //sound
        if(data.sound_yn == 1 && common.isEmpty(data.sound_url)){
            alert('사운드URL을 입력해주세요.');
            return false;
        }
        return true;
    };

//=------------------------------ Modal ----------------------------------



</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_giftDetailFrm" type="text/x-handlebars-template">
    <input type="hidden" name="item_code" value="{{item_code}}" />
    <div class="row col-lg-12">
        <div class="row col-md-12" style="padding-bottom: 15px">
            <div class="pull-left">
                • 스토어 페이지에서 구매 또는 선물할 수 있는 아이템을 등록 및 관리하는 페이지입니다.
            </div>
            <div class="pull-right">
                {{^item_code}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/item_code}}
                {{#item_code}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/item_code}}
            </div>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
                <tr class="align-middle">
                    <th rowspan="2">No</th>
                    <td rowspan="2">{{rowNum}}</td>

                    <th rowspan="2">플랫폼</th>
                    <td rowspan="2">{{{getCommonCodeHorizontalCheck platform 'content_platform2' 'Y' 'platform'}}}</td>

                    <th rowspan="2">아이템 코드</th>
                    <td rowspan="2">
                        {{#item_code}}{{this}}{{/item_code}}
                    </td>

                    <th>등록/수정자</th>
                    <td >{{opName}}</td>
                </tr>
                <tr>
                    <th>등록/수정일시</th>
                    <td >{{lastupdDate}}</td>
                </tr>
                <tr>
                    <th>아이템명</th>
                    <td colspan="3">
                        <input type="text" class="form-control" id="gift-item_name" name="item_name" placeholder="아이템명을 입력하여 주시기 바랍니다." value="{{item_name}}">
                    </td>

                    <th>사운드여부</th>
                    <td>
                        <label class="control-inline fancy-checkbox custom-color-green">
                            <input type="checkbox" value="1" id="sound_yn" name="sound_yn" class="form-control" {{#equal sound_yn 1}}checked{{/equal}} />
                            <span><i></i>사운드여부</span>
                        </label>
                    </td>

                    <th>게시여부</th>
                    <td>{{{getCommonCodeRadio view_yn 'content_viewOn' 'N' 'view_yn'}}}</td>
                </tr>
                <tr>
                    <th>구분</th>
                    <td>{{{getCommonCodeSelect item_slct 'item_itemSlct'}}}</td>

                    <th>사용영역</th>
                    <td>{{{getCommonCodeSelect use_area 'item_useArea' 'N' 'use_area'}}}</td>

                    <th>파일등록 필드</th>
                    <td>{{{getCommonCodeSelect file_slct 'item_fileField' 'N' 'file_slct'}}}</td>

                    <th>플레이타임 제한</th>
                    <td>
                        <div class="form-inline">
                            <input type="text" class="form-control _trim" id="gift-play_time" name="play_time" placeholder="아이템 노출 시간" value="{{play_time}}" style="width:70%;" onkeydown="common.inputFilterNumber(event)" />
                            <span>(초)</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td>{{{getCommonCodeSelect category 'item_itemCategory' 'Y' 'category'}}}</td>

                    <th>타입</th>
                    <td>{{{getCommonCodeHorizontalCheck item_type 'item_itemType'}}}</td>

                    <th>지급 수량 (별)</th>
                    <td>
                        <div class="form-inline">
                            <input type="text" class="form-control _trim" id="exchange-byeol" name="byeol" placeholder="지급될 별 수량." value="{{byeol}}" style="width: 70%;" onkeydown="common.inputFilterNumber(event)">
                            <span>(별)</span>
                        </div>
                    </td>

                    <th>가격 (달)</th>
                    <td>
                        <div class="form-inline">
                            <input type="text" class="form-control _trim" id="gift-item_price" name="item_price" placeholder="아이템 구매 달 수량." value="{{item_price}}" style="width: 70%;" onkeydown="common.inputFilterNumber(event)">
                            <span>(달)</span>
                        </div>
                    </td>
                </tr>
                <%--
                <tr>
                    <th>할인율</th>
                    <td colspan="11">{{{getCommonCodeRadio discount_rate 'item_discount'}}}</td>
                </tr>
                --%>
                <tr>
                    <th>Webp 이미지 URL</th>
                    <td colspan="3">
                        <input type="text" class="_trim" id="gift-webp_image" name="webp_image" style="width:70%" value="{{webp_image}}">
                        <input type="button" value="미리보기" onclick="getImg('gift-webp_image')">
                    </td>

                    <th>Json 이미지 URL</th>
                    <td colspan="3">
                        <input type="text" class="_trim" id="gift-jason_image" name="jason_image" style="width:70%" value="{{jason_image}}">
                        <input type="button" value="미리보기" onclick="getImg('gift-jason_image')">
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <!--미리보기-->
                        <a href="javascript:;"><img id="gift-webp_imageViewer" style="max-width:360px; max-height:450px;" src="" alt="" data-toggle="modal" data-target="#imgModal" onclick="fullSize(this.src);"/></a>
                    </td>

                    <td colspan="4">
                        <!--미리보기-->
                        <a href="javascript:;"><img id="gift-jason_imageViewer" style="max-width:360px; max-height:450px;" src="" alt="" data-toggle="modal" data-target="#imgModal" onclick="fullSize(this.src);"/></a>
                    </td>
                </tr>
                <tr>
                    <th>사운드 URL</th>
                    <td colspan="2">
                        <input type="text" class="_trim" id="sound_url" name="sound_url" style="width:70%" value="{{sound_url}}">
                        <input type="button" value="미리듣기" id="preSoundBtn">
                    </td>
                    <td>
                        <!--미리듣기-->
                        <audio controls loop id="soundAudio">
                          <source src="{{sound_url}}">
                          Your browser does not support the audio tag.
                        </audio>
                    </td>

                    <th></th>
                    <td colspan="3"></td>

                    <!-- 인앱여부 사용안한다고 해서 일단 안보이게 처리 -->
                    <th style="display:none;">인앱 여부</th>
                    <td colspan="3" style="display:none;">
                        <label class="control-inline fancy-checkbox custom-color-green">
                            <input type="checkbox" value="1" id="in_app_yn" name="in_app_yn" class="form-control" {{#equal in_app_yn 1}}checked{{/equal}} />
                            <span><i></i>선택 시 APP 안에 다운로드 되어 사용됩니다.</span>
                        </label>
                    </td>
                </tr>
                <tr>
                    <th>썸네일</th>
                    <td colspan="2">
                        <input type="text" class="_trim" id="gift-item_thumbnail" name="item_thumbnail" style="width:70%" value="{{item_thumbnail}}">
                        <input type="button" value="미리보기" onclick="getImg('gift-item_thumbnail')">
                    </td>
                    <td>
                        <!--미리보기-->
                        <a href="javascript:;"><img id="gift-item_thumbnailViewer" style="width:70px; height:70px;" src="" alt="" data-toggle="modal" data-target="#imgModal" onclick="fullSize(this.src);"/></a>
                    </td>

                    <th>운영자 메모</th>
                    <td colspan="3">
                        <textarea class="form-control" id="gift-desc" name="desc" rows="5" cols="30" placeholder="메모." style="resize: none" maxlength="200">{{desc}}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</script>