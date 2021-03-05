var ItemDataTableSource = {
    'charge': {
        'url': '/rest/content/item/charge/list'

        , 'columns': [
            {'title': '플랫폼', 'data': 'platform', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    var arrCode = data.split("");
                    if(arrCode.length < 3){
                        return data;
                    }
    
                    var result = "";
                    if(arrCode[0] == "1"){
                        result += "/ PC(WEB) "
                    }
    
                    if(arrCode[1] == "1"){
                        result += "/ Mobile-Android "
                    }
    
                    if(arrCode[2] == "1"){
                        result += "/ Mobile-IOS "
                    }
    
                    if(!common.isEmpty(result)){
                        result = result.substring(1);
                    }
    
                    return result;

            }},
            {'title': '코드', 'data': 'item_code', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;

            }},
            {'title': '이미지', 'data': 'item_thumbnail', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    if(common.isEmpty(data)){
                        return "";
                    }
                    return '<img class="thumbnail fullSize_background" src="'+ data +'" width="50px" height="50px" />';
            }},
            {'title': '아이템 명', 'data': 'item_name', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_getNoticeDetail" data-idx="'+meta.row+'">' + data + '</a>'
            }},
            {'title': '타입', 'data': 'item_type', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    var arrCode = data.split("");
                    if(arrCode.length < 3){
                        return data;
                    }

                    var result = "";
                    if(arrCode[0] == "1"){
                        result += "/ 신규 "
                    }

                    if(arrCode[1] == "1"){
                        result += "/ 인기 "
                    }

                    if(arrCode[2] == "1"){
                        result += "/ 한정 "
                    }

                    if(!common.isEmpty(result)){
                        result = result.substring(1);
                    }

                    return result;
            }},
            {'title': '수량', 'data': 'dal', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }},
            {'title': '가격', 'data': 'item_price', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }},
            {'title': 'IOS 가격', 'data': 'item_price_ios', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }},
            {'title': '할인율', 'data': 'discount_rate', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data + "%";
            }},
            {'title': '설명', 'data': 'desc', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }},
            {'title': '게시상태', 'data': 'view_yn', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, content_viewOn);
            }},
            {'title': '등록/수정일', 'data': 'lastUpdDateFormat', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                return data;

            }},
            {'title': '구매', 'data': 'purchase_count', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }},
            {'title': '등록자명', 'data': 'op_name', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
            }}
        ]
        , 'comments': '<div>• 스토어 페이지에서 구매 또는 선물할 수 있는 아이템을 등록 및 관리하는 페이지입니다.</div>'
    },


    'exchange': {
        'url': '/rest/content/item/exchange/list'

        , 'columns': [
            {'title': '코드', 'data': 'item_code', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;

                }},
            {'title': '이미지', 'data': 'item_thumbnail', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return '<img class="thumbnail fullSize_background" src="'+ data +'" width="50px" height="50px" />';

                }},
            {'title': '아이템명', 'data': 'item_name', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_getNoticeDetail" data-idx="'+meta.row+'">' + data + '</a>'
                    // return data;

                }},
            {'title': '타입', 'data': 'item_type', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    var arrCode = data.split("");
                    if(arrCode.length < 3){
                        return data;
                    }

                    var result = "";
                    if(arrCode[0] == "1"){
                        result += "/ 신규 "
                    }

                    if(arrCode[1] == "1"){
                        result += "/ 인기 "
                    }

                    if(arrCode[2] == "1"){
                        result += "/ 한정 "
                    }

                    if(!common.isEmpty(result)){
                        result = result.substring(1);
                    }

                    return result;
                }},
            {'title': '수량', 'data': 'dal', 'defaultContent': '0', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '가격', 'data': 'item_price', 'defaultContent': '0', 'render': function (data, type, row, meta) {
                    return data + " (별)";
                }},
            {'title': '설명', 'data': 'desc', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '게시상태', 'data': 'view_yn', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, content_viewOn);
                }},
            {'title': '등록/수정일', 'data': 'lastupdDate', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                        return data;
                }},
            {'title': '구매', 'data': 'purchase_count', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '등록자', 'data': 'op_name', 'defaultContent': '-'}
        ]
        , 'comments': '<div>• 스토어 페이지에서 별을 달로 교환 할 수 있는 아이템을 등록 및 관리하는 페이지입니다.</div>'
    },

    'gift': {
        'url': '/rest/content/item/gift/list'

        , 'columns': [
            {'title': '사용영역', 'data': 'use_area', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, item_useArea);
                }},
            {'title': '파일등록 필드', 'data': 'file_slct', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '플레이타임', 'data': 'play_time', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;

                }},
            {'title': '코드', 'data': 'item_code', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return '<a href="javascript://" class="_getNoticeDetail" data-idx="'+meta.row+'">' + data + '</a>'
                    // return data;
                }},
            {'title': '이미지', 'data': 'item_thumbnail', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return '<img class="fullSize_background _webpImage" src="'+ data +'" width="50px" height="50px" data-webpImage="' + row.webp_image+ '"/>';

                }},
            {'title': '아이템명', 'data': 'item_name', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '타입', 'data': 'item_type', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    var arrCode = data.split("");
                    if(arrCode.length < 3){
                        return data;
                    }

                    var result = "";
                    if(arrCode[0] == "1"){
                        result += "/ 신규 "
                    }

                    if(arrCode[1] == "1"){
                        result += "/ 인기 "
                    }

                    if(arrCode[2] == "1"){
                        result += "/ 한정 "
                    }

                    if(!common.isEmpty(result)){
                        result = result.substring(1);
                    }

                    return result;
                }},
            {'title': '수량', 'data': 'byeol', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '가격', 'data': 'item_price', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': 'IOS 가격', 'data': 'item_price_ios', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '설명', 'data': 'desc', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return common.replaceTag(data);
                }},
            {'title': '사운드여부', 'data': 'sound_yn', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data == 0 ? '-' : 'Y';
                }},
            /*{'title': '인앱여부', 'data': 'in_app_yn', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data == 0 ? '-' : 'Y';
                }},*/
            {'title': '게시상태', 'data': 'view_yn', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return util.getCommonCodeLabel(data, content_viewOn);
                }},
            {'title': '등록/수정일', 'data': 'lastupdDate', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return (common.isEmpty(row.lastupdDateFormat) ? row.regDateFormat : row.lastupdDateFormat);

                }},
            {'title': '선물현황', 'data': 'purchase_count', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
            {'title': '등록자', 'data': 'op_name', 'defaultContent': '-', 'render': function (data, type, row, meta) {
                    return data;
                }},
        ]
        , 'comments': '<div>• 방송 중 DJ 또는 게스트에게 선물할 수 있는 아이템을 등록 및 관리할 수 있습니다.</div>' +
                            '<div> ※ 선물아이템 영역 : 기본, 1번-파티클, 2번-콤보, 3번-상단, 4번-우측, 5번-전체</div>'
    },
}
