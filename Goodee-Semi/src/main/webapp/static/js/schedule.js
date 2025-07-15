const calendarEl = document.querySelector('#calendar');

// 선택된 날짜 저장 변수
let selectedDate = null;

// 임시 데이터 저장소 (실제로는 서버 API와 연동)
let eventDatas = [
    {
        id: '1',
        title: "회의",
        start: '2025-07-01T10:00:00',
        end: '2025-07-01T11:00:00',
        backgroundColor: '#3788d8',
		extendedProps: {
			courseName: 'sdf'
		}
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
		
        // TODO 아래의 ajax에 응답해주는 서블릿 구현
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
		
		successCallback(eventDatas);
		console.log('이벤트 데이터 로드 완료');
    },

    // 날짜 선택 시 새 이벤트 생성
    select: function(selectionInfo) {
		selectedDate = selectionInfo.startStr.split('T')[0]; // 선택된 날짜 저장
        showEventModal('create', selectionInfo);
    },

    // 이벤트 클릭 시 수정/삭제
    eventClick: function(clickInfo) {
		selectedDate = clickInfo.event.startStr.split('T')[0]; // 이벤트 날짜 저장
        showEventModal('edit', clickInfo);
    },
});

// 모달 표시 함수
function showEventModal(mode, info) {
	// 1. 모달의 요소 가져오기
    const modal = document.querySelector('#event-modal-box');
    const modalTitle = document.querySelector('#modal-title');
    const form = document.querySelector('#modal-form');
    const deleteBtn = document.querySelector('#btn-delete-event');
    
    // 2. 폼 초기화
    // reset(): 요소의 기본값 복원
    form.reset();

	// 3-1. 일정 등록
    if (mode === 'create') {
        modalTitle.textContent = '일정 등록';
        deleteBtn.style.display = 'none';
		modal.removeAttribute('data-event-id');
    // 3-2. 일정 수정
    } else if (mode === 'edit') {
        modalTitle.textContent = '일정 수정';
        deleteBtn.style.display = 'inline-block';
        
        // 기존의 일정 가져옴
        const event = info.event;
        
		console.log(info);
        // 기존의 일정에 담긴 데이터를 표시
        document.querySelector('#course-name').value = event.extendedProps.courseName;
        document.querySelector('#member-name').value = event.extendedProps.memberName;
        document.querySelector('#pet-name').value = event.extendedProps.petName;
        document.querySelector('#start-time').value = event.start? event.start.toTimeString().substring(0, 5) : '';
        document.querySelector('#end-time').value = event.end? event.end.toTimeString().substring(0, 5) : '';
        
        // 현재 편집 중인 이벤트 ID 저장
        modal.setAttribute('data-event-id', event.id);
    }
    
    modal.style.display = 'flex';
}

// 날짜 + 시간 합치기 함수
function buildDateTime(date, timeStr) {
  const [h, m] = timeStr.split(':').map(Number);
  const dt = new Date(date);
  dt.setHours(h, m, 0, 0);
  return dt.toISOString();
}

// 이벤트 생성
function createEvent(eventData) {
    const newId = Date.now().toString();
    const newEvent = {
        title: `(${eventData.courseName}) ${eventData.memberName}-${eventData.petName}`,
		id: newId,
        start: eventData.start,
        end: eventData.end,
		extendedProps: {
			courseName: eventData.courseName,
			memberName: eventData.memberName,
			petName: eventData.petName,
		}
    };
    
    // 임시데이터 저장소에 추가
    eventDatas.push(newEvent);
    
    // 추가된 이벤트를 캘린더에 반영
    calendar.addEvent(newEvent);
    
    // TODO 서버로 데이터 전송
    console.log('이벤트 생성:', newEvent);
    
    return newEvent;
}

// 이벤트 수정
function updateEvent(eventId, eventData) {
    const event = calendar.getEventById(eventId);
    if (event) {
		event.setProp('title', `(${eventData.courseName}) ${eventData.memberName}-${eventData.petName}`)
        // event.setId(eventData.id);
        event.setExtendedProp('courseName', eventData.courseName);
        event.setExtendedProp('memberName', eventData.memberName);
        event.setExtendedProp('petName', eventData.petName);
        event.setStart(eventData.start);
        event.setEnd(eventData.end);
        
		// 데이터 저장소 업데이트
	    const dataIndex = eventDatas.findIndex(e => e.id === eventId);
	    if (dataIndex !== -1) {
	        eventDatas[dataIndex] = {
	            ...eventDatas[dataIndex],
	            title: `(${eventData.courseName}) ${eventData.memberName}-${eventData.petName}`,
	            start: eventData.start,
	            end: eventData.end,
	            extendedProps: {
	                courseName: eventData.courseName,
	                memberName: eventData.memberName,
	                petName: eventData.petName,
	            }
	        };
	    }
        
	    // TODO 서버로 데이터 전송
	    console.log('이벤트 수정:', event);
    }
}

// 이벤트 삭제
function deleteEvent(eventId) {
    const event = calendar.getEventById(eventId);
    if (event) {
        event.remove();
        
        // 데이터 저장소에서 삭제
        const dataIndex = eventDatas.findIndex(e => e.id === eventId);
        if (dataIndex !== -1) {
            eventDatas.splice(dataIndex, 1);
        }
        
        // TODO 서버로 데이터 전송
        console.log('이벤트 삭제:', eventId);
    }
}

// 모달 이벤트 리스너
$(document).on('click', '#btn-cancel-event', function() {
    document.getElementById('event-modal-box').style.display = 'none';
});

$(document).on('click', '#btn-add-event', function() {
    const form = document.getElementById('modal-form');
    const formData = new FormData(form);
    const modal = document.getElementById('event-modal-box');
    const eventId = modal.getAttribute('data-event-id');
    
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
	// 시간 검증
    const startTime = formData.get('startTime');
    const endTime = formData.get('endTime');
    
    if (!startTime || !endTime) {
        alert('시작 시간과 종료 시간을 입력해주세요.');
        return;
    }
    
    if (startTime >= endTime) {
        alert('종료 시간은 시작 시간보다 늦어야 합니다.');
        return;
    }
	
	const eventData = {
	    courseName: formData.get('courseName'),
	    memberName: formData.get('memberName'),
	    petName: formData.get('petName'),
	    start: buildDateTime(selectedDate, startTime),
	    end: buildDateTime(selectedDate, endTime)
	};
    
    if (eventId) {
        // 수정
        updateEvent(eventId, eventData);
    } else {
        // 생성
        createEvent(eventData);
    }
    
    modal.style.display = 'none';
    calendar.unselect();
});

$(document).on('click', '#btn-delete-event', function() {
    const modal = document.getElementById('event-modal-box');
    const eventId = modal.getAttribute('data-event-id');
    
    if (eventId && confirm('이 일정을 삭제하시겠습니까?')) {
        deleteEvent(eventId);
        modal.style.display = 'none';
    }
});

// 모달 외부 클릭 시 닫기
$(document).on('click', '#event-modal-box', function(e) {
    if (e.target === this) {
        this.style.display = 'none';
    }
});

// 캘린더 렌더링
calendar.render();