<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
    <div class="main-header">
        <h2>레이어팝업 샘플</h2>
    </div>

    <div class="row">
        <div class="widget">
            <div class="widget-header">
                <h3>레이어팝업 띄우기</h3>
            </div>
            <div class="widget-content">
                <button class="btn btn-primary btn-lg _layerOpen" data-toggle="modal" data-target="#myModal">누르면 나와요</button>

                <button class="example2 btn btn-primary" onclick="testConfirm()">example confirm</button>

                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="_layerTitle">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                <p id="_layerBody">Modal dialog content...</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
                                <button type="button" class="btn btn-custom-primary"><i class="fa fa-check-circle"></i> 저장</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="_layerTitle">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                <p id="_layerBody">Modal dialog content...</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times-circle"></i> 닫기</button>
                                <button type="button" class="btn btn-custom-primary"><i class="fa fa-check-circle"></i> 저장</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).on('click', '._layerOpen', function(title, content){
        $("#_layerTitle").html('제목이에요');
        $("#_layerBody").html("여기에 내용을 넣어주세요.");
    });

    function testConfirm(){
        $.confirm({
            title: 'Confirm!',
            content: 'Simple confirm!',
            buttons: {
                confirm: function () {
                    $.alert('Confirmed!');
                },
                cancel: function () {
                },
                somethingElse: {
                    text: 'Something else',
                    btnClass: 'btn-blue',
                    keys: ['enter', 'shift'],
                    action: function(){
                        $.alert('Something else?');
                    }
                }
            }
        });
    }
</script>
