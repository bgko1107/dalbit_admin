Handlebars.registerHelper("openTr", function (index, rowCnt, options) {
    var idx = index + 1;
    return (idx % rowCnt == 1) ? options.fn(this) : options.inverse(this);
});

Handlebars.registerHelper("closeTr", function (index, rowCnt, isLast, options) {
    var idx = index + 1;
    return (idx % rowCnt == 0) || isLast ? options.fn(this) : options.inverse(this);
});

Handlebars.registerHelper("timeEventStatus", function (startDate, endDate, state) {

    var start = moment(startDate).format('YYYYMMDDHHmmss');
    var end = moment(endDate).format('YYYYMMDDHHmmss');
    var now = moment(new Date()).format('YYYYMMDDHHmmss');

    if(state == 1){
        return '진행중지';
    }else if(state == 0){
        if(start <= now && now <= end) {
            return '진행중';
        }else if(end < now){
            return '완료';
        }else if(now < start){
            return '예정';
        }
    }

    return state;
});

Handlebars.registerHelper("timeEventStatusButton", function (startDate, endDate, state, idx) {

    var start = moment(startDate).format('YYYYMMDDHHmmss');
    var end = moment(endDate).format('YYYYMMDDHHmmss');
    var now = moment(new Date()).format('YYYYMMDDHHmmss');

    if(state == 0){
        if(start <= now && now <= end) {
            return '<button class="btn btn-sm btn-danger _timeEventStopBtn" type="button" data-idx="'+idx+'">진행중지</button>';
        }else if(now < start){
            return '<button class="btn btn-sm btn-warning _timeEventDelBtn" type="button" data-idx="'+idx+'">취소</button>';
        }
    }else{
        return '-';
    }
});