// '추가 등록' 버튼을 눌렀을 때 리스트에 등록되고 등록된 지점으로 페이지 이동
// 정보를 수정할 수 있도록 정보가 input 안에 표시됨 & 이미지 테두리선 색깔이 생김 
// & '수정', '삭제' 버튼이 '수정사항 저장'으로 바뀜
// 수정사항 저장 시 유효성 검사
// 유효성 검사 통과시: '수정되었습니다' 라는 메시지 창이 뜨고, '확인'을 누르면 메시지 창 사라짐

// TODO 수정, 삭제 기능 먼저 구현 후 등록 기능 구현하기

// 페이지 로드 > 요소 가져오기 > 클릭 이벤트 감지 > 

$().ready(function () {
    // alert('ready');

    // 모든 버튼 요소 가져옴
    const btnUpArr =  document.querySelectorAll('.pet-btn-up');
    const btnDelArr = document.querySelectorAll('.pet-btn-del');

    // 클릭 시 이벤트
    // JQuery는 요소 배열에 이벤트리스너 한 번에 연결 가능 (요소마다 연결하지 않아도 됨)
    btnUpArr.forEach(function (btn, idx) {
        btn.addEventListener('click', function() {
            console.log(btn.parentElement.previousSibling)
        });
    });

});