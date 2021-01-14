<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .lb_style{
        border: 1px solid #DDDDDD;
        background-color: #DCE6F2;
        height: 34px;
        padding-left: 0px;
        padding-right: 0px;
    }
</style>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="col-md-12 no-padding">
            <label id="mail_title"></label><br>
        </div>
        <div class="row col-md-12">
            <div class="col-md-8 no-padding">
                <div class="col-md-2 no-padding">
                    <div class="col-md-6 lb_style" style="height:68px"><label>No</label></div>
                    <div class="col-md-6"><label>41</label></div>
                </div>
                <div class="col-md-3 no-padding">
                    <div class="col-md-5 lb_style"><label>문의유형</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>방송하기</label></div>
                    <div class="col-md-5 lb_style"><label>플랫폼</label></div>
                    <div class="col-md-7" style="height: 34px;">
                        <select class="form-control" name="sortType" id="platformType">
                            <option value="9999">플랫폼</option>
                            <option value="1">PC</option>
                            <option value="2">Android-Mobile</option>
                            <option value="3">IOS-Mobile</option>
                            <option value="4">Web-Mobile</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4 no-padding">
                    <div class="col-md-5 lb_style"><label>Browser</label></div>
                    <div class="col-md-7" style="height: 34px;">
                        <select class="form-control" name="sortType" id="browserType">
                            <option value="9999">Browser</option>
                            <option value="1">Chrome</option>
                            <option value="2">Internet Explorer</option>
                            <option value="3">Firefox</option>
                        </select>
                    </div>
                    <div class="col-md-5 lb_style"><label>IP Address</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>789.123.123</label></div>
                </div>
                <div class="col-md-3 no-padding">
                    <div class="col-md-5 lb_style"><label>회원번호</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>123123123</label></div>
                    <div class="col-md-5 lb_style"><label>문의자UserID</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>DalDalDal</label></div>
                </div>
            </div>
            <div class="col-md-4 no-padding">
                <div class="col-md-6 no-padding">
                    <div class="col-md-6 lb_style" style="height:68px"><label>접수일시</label></div>
                    <div class="col-md-6"><label>2020.02.02 09:10</label></div>
                </div>
                <div class="col-md-6 no-padding">
                    <div class="col-md-5 lb_style"><label>첨부파일</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>00건</label></div>
                    <div class="col-md-5 lb_style"><label>처리상태</label></div>
                    <div class="col-md-7" style="height: 34px;">
                        <select class="form-control" name="sortType" id="procesType">
                            <option value="9999">처리상태(전체)</option>
                            <option value="1">Chrome</option>
                            <option value="2">Internet Explorer</option>
                            <option value="3">Firefox</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="row col-md-12">
            <div class="col-md-8 no-padding">
                <div class="col-md-2 no-padding lb_style"><label>문의제목</label></div>
                <div class="col-md-7"><input type="text" class="form-control" id="txt_phon" style="width: 100%"></div>
                <div class="col-md-3 no-padding">
                    <div class="col-md-5 lb_style"><label>문의자닉네임</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>달달이</label></div>
                </div>
            </div>
            <div class="col-md-4 no-padding">
                <div class="col-md-6 no-padding">
                    <div class="col-md-6 lb_style"><label>처리일시</label></div>
                    <div class="col-md-6" style="height: 34px;"><label>-</label></div>
                </div>
                <div class="col-md-6 no-padding">
                    <div class="col-md-5 lb_style"><label>처리자명</label></div>
                    <div class="col-md-7" style="height: 34px;"><label>-</label></div>
                </div>
            </div>
        </div>
        <div class="row col-md-12">
            <div class="col-md-8 no-padding">
                <div class="col-md-2 no-padding lb_style"  style="height: 160px"><label>문의내용</label></div>
                <div class="col-md-10"  style="height: 160px"><textarea id="question" style="width: 100%; height: 100%"></textarea></div>
            </div>
            <div class="col-md-4 no-padding">
                <div class="col-md-3 no-padding lb_style" style="height: 160px"> <label>첨부파일</label>
                </div>
                <div class="col-md-8"  style="height: 160px">
                    <form id="profileImg" method="post" enctype="multipart/form-data">
                        <img id="image_section" src="#" alt="your image" style="width: 100%;height: 100%"/>
                    </form>
                </div>
            </div>
        </div>
        <div class="row col-md-12">
            <div class="col-md-8 no-padding">
                <div class="col-md-2 no-padding lb_style"><label>매크로 답변하기</label></div>
                <div class="col-md-3">
                    <select class="form-control" name="searchType" id="searchType">
                        <option value="9999">문의구분</option>
                        <option value="1">회원정보</option>
                        <option value="2">방송하기</option>
                        <option value="3">청취하기</option>
                        <option value="4">결제</option>
                        <option value="5">건의하기</option>
                        <option value="6">장애/버그</option>
                        <option value="7">선물/아이템</option>
                        <option value="8">기타</option>
                    </select>
                    <select class="form-control" name="sortType" id="sortType">
                        <option value="1">음란성</option>
                        <option value="2">방송</option>
                        <option value="3">욕설</option>
                    </select>
                </div>
                <div class="col-md-4 no-padding">
                </div>
                <div class="col-md-3 no-padding">
                    <div class="col-md-12 lb_style"><label>바로가기 버튼</label></div>
                </div>
            </div>
            <div class="col-md-4 no-padding">
                <button type="button" id="bt_moon" class="btn-sm">달결제</button>
                <button type="button" id="bt_star" class="btn-sm">별전환</button>
                <button type="button" id="bt_wallet" class="btn-sm">내지갑</button>
                <button type="button" id="bt_photo" class="btn-sm">사진등록</button>
                <button type="button" id="bt_broad" class="btn-sm">방송방법</button>
            </div>
        </div>
        <div class="row col-md-12">
            <div class="col-md-8 no-padding">
                <div class="col-md-2 no-padding lb_style"><label>신고처리</label></div>
                <div class="col-md-10">
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_pre" checked>유지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_war">경고</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_1">1일 정지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_3">3일 정지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_7">7일 정지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_15">15일 정지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_30">30일 정지</label>
                    <label class="radio-inline"><input type="radio" name="radio_ban" value="ban_ban">강제탈퇴</label>
                    <button type="button" id="bt_ban" class="btn-sm">완료</button>
                </div>
            </div>
        </div>
        <div class="row col-md-12" style="margin-top: 5px;">
            <div class="main-content">
                <!-- WYSIWYG EDITOR -->
                <div class="widget">
                    <div class="widget-content no-padding">
                        <div class="summernote">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        /* summernote */
        var targetEditor = $('.summernote');

        targetEditor.summernote({
            height: 300,
            focus: true,
            // onpaste: function() {
            //     alert('You have pasted something to the editor');
            // },
            callbacks: { // 콜백을 사용
                // 이미지를 업로드할 경우 이벤트를 발생
                onImageUpload: function(files, editor, welEditable) {
                    console.log("[onImageUpload]")

                    var formData = new FormData();
                    formData.append("file",files[0]);
                    //TODO  업로드 타입은 상황에 맞게 수정 부탁드립니다.
                    formData.append("uploadType","bg");
                    util.fileUpdate("https://devphoto2.dalbitlive.com/upload",formData, function (data) {
                        var json = jQuery.parseJSON(data);
                        console.log(json);
                        if(json.code != "0"){
                            alert(json.message);
                            return;
                        }
                        // UPLOAD IMAGE URL 적용
                        var imgURL = json.data.url;
                        targetEditor.summernote('editor.insertImage', imgURL);
                    });
                }
            }
        });

        $("#bt_ban").on("click", function () {
            console.log(targetEditor.summernote("code"))
            // $(".viewer").empty().append(targetEditor.summernote("code"))
            // $(".code").text(targetEditor.summernote("code"))
        });

    })



</script>
