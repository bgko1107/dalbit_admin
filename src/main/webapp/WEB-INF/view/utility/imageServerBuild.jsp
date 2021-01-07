<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content">
    <div class="main-header">
        <h2>이미지서버 빌드</h2>
        <em>FTP로 이미지 서버에 업로드 후 아래 버튼을 눌러야 이미지가 올라갑니다.</em>
    </div>
    <div class="main-content">
        <!-- FILE UPLOAD -->
        <div class="widget">
            <div class="widget-header">
                <h3><i class="fa fa-cloud-upload"></i> 이미지 서버 파일업로드</h3>
            </div>
            <div class="widget-content">

                <div class="mb15">
                <ol class="mt15">
                    <li>
                        이미지 서버에 FTP로 업로드 합니다. <br />
                        <span class="font-bold">
                        주의<br />
                        - 파일명엔 띄어쓰기가 들어가지 않도록 해주세요.<br />
                        - 업로드 시에는 한글 파일명은 영문으로 변경해주세요.<br />
                        </span>
                    </li>
<pre>
[ 업로드 폴더 경로 ]
- 배너               /public_html/banner

- 아이템
    lottie (JSON) : /public_html/ani/lottie
    webp :          /public_html/ani/webp
    썸네일 :         /public_html/ani/thumbs
</pre>

                    <li>
                        하단에 이미지 서버 빌드 버튼을 클릭합니다. (버튼 클릭 시 이미지 서버에 배포됩니다.)
                    </li>
                    <li>
                        * FTP 경로에서 /public_html 을 뺀 경로가 url에 들어갑니다.
                        <br />
                        https://image.dalbitlive.com/{{FTP 경로}}/{{파일명}}</li>
                </ol>

                <button type="button" class="_buildBtn">이미지 서버 빌드</button>

                </div>

                <div>
                    경로 : FTP 폴더경로
                    <input type="text" class="form-control" style="width:400px;" id="imageFilePath" />
                    <br />
                    파일명 : 파일명(한글 x)
                    <input type="text" class="form-control" style="width:400px;" id="imageName" />
                    <br />
                    <button type="button" class="_imageViewBtn">이미지 확인</button>
                    <br />
                    <div id="imageViewArea"></div>
                </div>
            </div>
        </div>
        <!-- END FILE UPLOAD -->
    </div>
</div>

<script type="text/javascript">

    $(document).on('click', '._buildBtn', function(){
        var data = {};
        util.getAjaxData("imageServerBuild", "/rest/utility/imageServerBuild", data, function(dist_id, data){
            console.log(data);
        });
    });

    $(document).on('click', '._imageViewBtn', function(){
        var preFix = 'https://image.dalbitlive.com'
        var filePath = $("#imageFilePath").val();
        if(!filePath.startsWith("/")){
            filePath += '/';
        }
        if(filePath.startsWith("/public_html")){
            filePath = common.replace(filePath, '/public_html', '')
        }
        var imageName = '/'+ $("#imageName").val();

        var imageUrl = preFix + filePath + imageName;

        var imageRender = '<img src="'+preFix + filePath + imageName+ '" style="max-width:100%; height:auto;border: solid 1px black;" />'
        $("#imageViewArea").html(imageUrl + '<br />' + imageRender);

    });


</script>