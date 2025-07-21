// TODO 차수 관련 기능 추가
const calendarEl = document.querySelector('#calendar');
const petNo = document.querySelector('input[type="hidden"').value;
	
console.log("일정 조회 중인 petNo : ", petNo)
	
// 선택된 날짜 저장 변수
let selectedDate = null;

// DB에서 받아온 일정 데이터들을 담는 변수 (fullcalendar의 임시 데이터 저장소)
let eventDatas = [];

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
	dayMaxEvents: false, // +more 표시 전 최대 이벤트 갯수, default: false | true: 셀 높이에 의해 결정, false: 일정만큼 셀 높이 확장
	
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
                end: fetchInfo.endStr,
				petNo: petNo
            },
            dataType: 'json',
            success: function (data) {
				console.log("성공: ", data);
				eventDatas = data;
				successCallback(data);
            },
            error: function (err) {
				console.log("에러: ", err);
            }
		});
		
		console.log('이벤트 데이터 로드 완료');
    },

	// 마우스 위치에 툴팁 표시
	eventDidMount: function(info) {
	    // 기존 시간 표시 요소 삭제
	    const oriTimeDiv = document.querySelector('.fc-event-time');
	    if (oriTimeDiv) {
	        oriTimeDiv.remove();
	    }
	    
	    let tooltipText = '';
	    let displayText = '';
	    
	    // 시간 정보 생성 (timezone 고려)
	    if (info.event.start && !info.event.allDay) {
	        // 한국 시간으로 변환
	        const startTime = new Date(info.event.startStr).toLocaleTimeString('ko-KR', {
	            hour: '2-digit',
	            minute: '2-digit',
	            hour12: false,
	            timeZone: 'Asia/Seoul'
	        });
	        
	        if (info.event.end) {
	            const endTime = new Date(info.event.endStr).toLocaleTimeString('ko-KR', {
	                hour: '2-digit',
	                minute: '2-digit',
	                hour12: false,
	                timeZone: 'Asia/Seoul'
	            });
	            displayText = `${startTime} - ${endTime}`;
	        } else {
	            displayText = startTime;
	        }
	    }
	    
	    // 캘린더 표시용 HTML 생성
	    const eventTitle = info.event.title;
	    let htmlContent = '';
	    
	    if (displayText) {
	        // 교육과정명과 회원명-반려견명을 분리
	        const titleMatch = eventTitle.match(/\(([^)]+)\)\s*(.+)/);
	        if (titleMatch) {
	            const courseTitle = titleMatch[1];  // 교육과정명
	            const memberInfo = titleMatch[2];   // 회원명-반려견명
	            
	            htmlContent = `
	                <div style="font-size: 11px; color: #666; line-height: 1.2;">${displayText}</div>
	                <div style="font-size: 12px; line-height: 1.2; margin-bottom: 2px;">${courseTitle}</div>
	                <div style="font-size: 11px; line-height: 1.2; color: #555;">${memberInfo}</div>
	            `;
	            tooltipText = displayText + '\n' + courseTitle + '\n' + memberInfo;
	        } else {
	            htmlContent = `
	                <div style="font-size: 11px; color: #666; line-height: 1.2;">${displayText}</div>
	                <div style="font-size: 12px; line-height: 1.2;">${eventTitle}</div>
	            `;
	            tooltipText = displayText + '\n' + eventTitle;
	        }
	    } else {
	        htmlContent = `<div style="font-size: 12px;">${eventTitle}</div>`;
	        tooltipText = eventTitle;
	    }
	    
	    // 기존 title 속성 제거 (중복 방지)
	    info.el.removeAttribute('title');
	    
	    // 이벤트 요소의 내용 수정
	    const titleElement = info.el.querySelector('.fc-event-title');
	    if (titleElement) {
	        titleElement.innerHTML = htmlContent;
	    }
	    
	    // 전체 이벤트 요소의 내용을 직접 수정 (더 확실한 방법)
	    const eventMain = info.el.querySelector('.fc-event-main');
	    if (eventMain) {
	        eventMain.innerHTML = htmlContent;
	    }
	    
	    // 새로운 툴팁용 title 속성 추가
	    info.el.setAttribute('title', tooltipText);
	}
});

// 캘린더 렌더링
calendar.render();