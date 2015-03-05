calendar.asp 는 작은 카렡다로서 메인 페이지 같은 곳에 iframe으로 삽입할 수 있게 설계


<script>
<!--
function calreSize() {
    try {
        var objBody = calendar_iframe.document.body;
        var objFrame = document.all["calendar_iframe"];
        ifrmHeight = objBody.scrollHeight + (objBody.offsetHeight - objBody.clientHeight);
        objFrame.style.height = ifrmHeight;
    }
        catch(e) {}
}

function init_califrame() {
    calreSize();
    setTimeout('init_califrame()',1)
}

init_califrame();
//-->
</script>

<iframe src="/util/wizdiary/calendar.asp" width="170" height="200" frameborder="0" framespacing="0" name="calendar_iframe" id="calendar_iframe" scrolling="no"></iframe>
