const calendarEl = document.querySelector('#calendar');

// 선택된 날짜 저장 변수
let selectedDate = null;

// DB에서 받아온 일정 데이터들을 담는 변수
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
                end: fetchInfo.endStr
            },
            dataType: 'json',
            success: function (data) {
				console.log("성공: ", data);
				successCallback(data);
            },
            error: function (err) {
				console.log("에러: ", err);
            }
		});
		
		console.log('이벤트 데이터 로드 완료');
    },

    // 날짜 선택 시 새 이벤트 생성
    select: function(selectionInfo) {
        console.log("[날짜 선택] 받아온 정보: ", selectionInfo);
		selectedDate = selectionInfo.startStr.split('T')[0]; // 선택된 날짜 저장 (ex. 0000-00-00)
        showEventModal('create', selectionInfo);
    },

    // 이벤트 클릭 시 수정/삭제
    eventClick: function(clickInfo) {
		selectedDate = clickInfo.event.startStr.split('T')[0]; // 이벤트 날짜 저장
        showEventModal('edit', clickInfo);
    },
	
	// 마우스 위치에 툴팁 표시
	eventDidMount: function(info) {
	    // 기존 시간 표시 요소 삭제
		const oriTimeDiv = document.querySelector('.fc-event-time');
		oriTimeDiv.remove();
		
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
	        htmlContent = `<div style="font-size: 11px; color: #666; line-height: 1.2;">${displayText}</div><div style="font-size: 12px; line-height: 1.2;">${eventTitle}</div>`;
	        tooltipText = displayText + '\n' + eventTitle;
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

// 모달 표시 함수
function showEventModal(mode, info) {
	// 1. 모달의 요소 가져오기
    const modal = document.querySelector('#event-modal-box');
    const modalTitle = document.querySelector('#modal-title');
    const form = document.querySelector('#modal-form');
    const deleteBtn = document.querySelector('#btn-delete-event');
    
    // 2. 폼 초기화
    form.reset(); // reset(): 요소의 기본값 복원
	form.querySelector('#account-name').disabled = true;
	form.querySelector('#pet-name').disabled = true;

	// 3. 일정 등록 / 수정
    switch (mode) {
        case 'create': // 일정 등록
            modalTitle.textContent = '일정 등록';
            deleteBtn.style.display = 'none';
            // modal.removeAttribute('data-event-id');
            break;
    
        case 'edit': // 일정 수정
            modalTitle.textContent = '일정 수정';
            deleteBtn.style.display = 'inline-block';
            
            // 기존의 일정 정보 가져옴
            console.log("[일정 정보] info: ", info);
            console.log("[일정 정보] info.event: ", info.event);
            const event = info.event;
            
            // 기존의 일정에 담긴 데이터를 표시
            document.querySelector('#course-title').value = event.extendedProps.courseTitle;
            document.querySelector('#account-name').value = event.extendedProps.accountName;
            document.querySelector('#pet-name').value = event.extendedProps.petName;
            document.querySelector('#start').value = event.startStr? event.startStr.split('T')[1] : "";
            document.querySelector('#end').value = event.endStr? event.endStr.split('T')[1] : "";

            // 현재 편집 중인 이벤트 ID 저장
            // modal.setAttribute('data-event-id', event.id);
    }
    
    modal.style.display = 'flex';
}

// 날짜 + 시간 합치기 함수
function buildDateTime(date, timeStr) {
    const [h, m] = timeStr.split(':').map(String);
//   const dt = new Date(date);
//   dt.setHours(h, m, 0, 0);
//   return dt.toISOString();
    return date + 'T' + h + ':' + m;
}

// 이벤트 생성
function createEvent(eventData) { // eventData: 모달 form에서 받아온 데이터
    // TODO jsp의 모달에 데이터 뿌리고 아래의 기능 구현
    // 1. 데이터를 서버로 전송
    $.ajax({
        url: '/schedule/create',
        type: 'post',
        data: {
            start: fetchInfo.startStr,
            end: fetchInfo.endStr
        },
        dataType: 'json',
        success: function (data) {
            console.log("성공: ", data);
            successCallback(data);
        },
        error: function (err) {
            console.log("에러: ", err);
        }
    });

    // 2. 임시데이터 저장소에 추가 (굳이 해야되나?)
    eventDatas.push(newEvent);
    
    // 3. 추가된 이벤트를 캘린더에 반영
    calendar.addEvent(newEvent);
    
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

// 교육과정, 회원, 반려견 input 검증
const baseSelect = document.getElementById('course-title'); // 기준 select
const targetSelect1 = document.getElementById('account-name');
const targetSelect2 = document.getElementById('pet-name');

let courseNo;

baseSelect.addEventListener('change', function() {
	const form = document.querySelector('#modal-form');
	form.querySelector('#pet-name').disabled = true;
	
	courseNo = this.value;
	console.log("courseNo: " + courseNo);
	
	if (this.value) { // 기준 select에 값이 선택되었는지 확인
        targetSelect1.disabled = false;
		
		const accountName = document.getElementById('account-name');
		
		// 비동기통신하여 option에 데이터 뿌리기
		$.ajax({
			url: '/schedule/input',
			type: 'get',
			data: {
				valueType: "courseNo",
				courseNo: courseNo
			},
			dataType: 'json',
			success: function (data) {
			    console.log("성공: ", data);
                
                html = '<option value="" disabled selected>회원명 선택</option>';
				data.jsonArr.forEach(json => {
                    html += `<option value="${json.accountNo}">${json.accountName}</option>`;
                });
				
				accountName.innerHTML = html;
			},
			error: function (err) {
			    console.log("에러: ", err);
			}
		});
    } else {
        targetSelect1.disabled = true;
        targetSelect1.value = ''; // 값 초기화
    }
});

targetSelect1.addEventListener('change', function() {
	const accountNo = this.value;
	console.log("accountNo: " + accountNo);
	
	if (this.value) { // 기준 select에 값이 선택되었는지 확인
        targetSelect2.disabled = false;
		
		const petName = document.getElementById('pet-name');
		
		// 비동기통신하여 option에 데이터 뿌리기
		$.ajax({
			url: '/schedule/input',
			type: 'get',
			data: {
				valueType: "accountNo",
				courseNo: courseNo,
				accountNo: accountNo
			},
			dataType: 'json',
			success: function (data) {
			    console.log("성공: ", data);
		        
		        html = '<option value="" disabled selected>반려견명 선택</option>';
				data.jsonArr.forEach(json => {
		            html += `<option value="${json.petNo}">${json.petName}</option>`;
		        });
				
				petName.innerHTML = html;
			},
			error: function (err) {
			    console.log("에러: ", err);
			}
		});
    } else {
        targetSelect2.disabled = true;
        targetSelect2.value = ''; // 값 초기화
    }
});

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