const calendarEl = document.querySelector('#calendar');

// 임시 데이터 저장소 (실제로는 서버 API와 연동)
let eventDatas = [
    {
        id: '1',
        title: "회의",
        start: '2025-07-01T10:00:00',
        end: '2025-07-01T11:00:00',
        backgroundColor: '#3788d8'
    },
    {
        id: '2',
        title: "점심 약속",
        start: '2025-07-02T12:00:00',
        end: '2025-07-02T13:00:00',
        backgroundColor: '#28a745'
    },
    {
        id: '3',
        title: "프로젝트 발표",
        start: '2025-07-03',
        backgroundColor: '#ffc107',
        textColor: '#000'
    }
];

const calendar = new FullCalendar.Calendar(calendarEl, {
	timeZone: 'Asia/Seoul', // 기준시간 설정
	headerToolbar: {
		left: 'prev,next today',
		center: 'title',
		right: 'dayGridMonth,timeGridWeek,timeGridDay'
	},
	locale: 'ko', // 언어 설정
	navLinks: true, // 요일과 날짜 클릭 시 일이나 주단위로 보여주는 화면으로 넘어감
 	editable: true, // 드래그해서 수정 가능한지
	selectable: true,
	selectMirror: true,
	dayMaxEvents: true, // +more 표시 전 최대 이벤트 갯수, default: false | true: 셀 높이에 의해 결정, false: 일정만큼 셀 높이 확장
	
    // 이벤트 데이터 로드
    events: function(fetchInfo, successCallback, failureCallback) {
		// 함수 형식으로 events 옵션을 넘기면 FullCalendar가 내부적으로 세 개의 인자를 자동으로 넘겨줌
		// fetchInfo: FullCalendar가 지금 보고 있는 달력의 날짜 범위
		// successCallback(eventsArray): 이 콜백 함수에 이벤트 배열을 넘겨주면, 달력에 그 일정들이 표시됨
		// failureCallback(): 만약 서버에서 일정 데이터를 가져오는 데 실패했을 경우 호출하면 FullCalendar가 에러 처리 (예: 메시지 표시)
		console.log(fetchInfo);
		console.log(successCallback);
		console.log(failureCallback);
		
		$.ajax({
		    url: '/schedule/list',
		    type: 'post',
		    data: {
		        start: fetchInfo.startStr,
		        end: fetchInfo.endStr
		    },
		    dataType: 'json',
		    success: function(response) {
		        successCallback(response); // 서버로부터 받은 일정 배열
		    },
		    error: function() {
		        failureCallback();
		    }
		});
    },

    // 날짜 선택 시 새 이벤트 생성
    select: function(selectionInfo) {
        showEventModal('create', selectionInfo);
    },

    // 이벤트 클릭 시 수정/삭제
    eventClick: function(clickInfo) {
        showEventModal('edit', clickInfo);
    },

    // 이벤트 드래그 앤 드롭으로 수정
    eventDrop: function(dropInfo) {
        updateEventDateTime(dropInfo.event);
    },

    // 이벤트 리사이즈로 수정
    eventResize: function(resizeInfo) {
        updateEventDateTime(resizeInfo.event);
    },
});

// 모달 HTML 생성
function createModal() {
    const modalHtml = `

    `;
    
    if (!document.getElementById('eventModal')) {
        document.body.insertAdjacentHTML('beforeend', modalHtml);
    }
}

