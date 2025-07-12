// '추가 등록' 버튼을 눌렀을 때 리스트에 등록되고 등록된 지점으로 페이지 이동
// 정보를 수정할 수 있도록 정보가 input 안에 표시됨 & 이미지 테두리선 색깔이 생김 
// & '수정', '삭제' 버튼이 '수정사항 저장'으로 바뀜
// 수정사항 저장 시 유효성 검사
// 유효성 검사 통과시: '수정되었습니다' 라는 메시지 창이 뜨고, '확인'을 누르면 메시지 창 사라짐

// TODO 수정, 삭제 기능 먼저 구현 후 등록 기능 구현하기

// 페이지 로드 > 요소 가져오기 > 클릭 이벤트 감지 > 


// 요소를 클릭하는 함수
function clickElement (e) {
	e.click();
};

// 모든 버튼 요소 가져옴
const btnUpArr =  document.querySelectorAll('.pet-btn-up');
const btnDelArr = document.querySelectorAll('.pet-btn-del');

// 수정 버튼 클릭 시 이벤트
btnUpArr.forEach(function (btn, idx) {
    btn.addEventListener('click', function handleEditClick() {
        // 1. 반려견 정보가 있는 input 요소들을 가져옴
        const petBtnDiv = this.parentElement;
        const petDetailEl = petBtnDiv.parentElement.querySelector('.pet-detail');
        const petDetailsEl = petDetailEl.querySelectorAll('input');
        
        // 2. input 요소들의 disabled 속성 제거
        petDetailsEl.forEach(function (el) {
            el.removeAttribute("disabled");
        });
        
        // 3. 버튼 바꾸기
        const oriPetBtnsHtml = petBtnDiv.innerHTML;
        const btnSave = '<button class="pet-btn-save">수정 완료</button>';
        petBtnDiv.innerHTML = btnSave;

        // TODO 반려견 이미지 삭제 기능 추가
        // 1) 반려견 이미지 img 클릭 시 input:file의 클릭 이벤트(파일 선택창 열기)를 발생시킴
        const petImg = petBtnDiv.parentElement.querySelector('.pet-img');
        const petImgInput = petBtnDiv.parentElement.querySelector('.pet-img-input');

		petImg.addEventListener('click', function() {
			clickElement(petImgInput); // 파일 input 클릭 유도
		});

        // 2) 파일을 선택하면 이미지 프리뷰를 반려견 이미지 img에 띄움
        petImgInput.addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    petImg.src = e.target.result; // 미리보기
                };
                reader.readAsDataURL(file); // reader.onload 실행
            }
        });

        // 4. save 버튼 누를 시 ajax로 수정 요청 보내고 응답받아 input 안의 value 수정 &
        // 버튼 되돌리고 input disabled로 전환
        const newPetBtn = petBtnDiv.querySelector('.pet-btn-save');
        newPetBtn.addEventListener('click', function (btn) {
            // 1) ajax로 요청 보내고 응답 받아 value 수정
            // (1) 이미지 파일도 가져와야 하므로 input 안의 value값을 가져와서 FormData에 바인딩
            const petName = petBtnDiv.parentElement.querySelector('.pet-name').value;
            const petAge = petBtnDiv.parentElement.querySelector('.pet-age').value;
            const petGender = petBtnDiv.parentElement.querySelector('.pet-gender').value;
            const petBreed = petBtnDiv.parentElement.querySelector('.pet-breed').value;
            const petNo = petBtnDiv.parentElement.querySelector('.pet-no').value;
            const accountNo = petBtnDiv.parentElement.querySelector('.account-no').value;
            
            const formData = new FormData();
            formData.append("petName", petName);
            formData.append("petAge", petAge);
            formData.append("petGender", petGender);
            formData.append("petBreed", petBreed);
            formData.append("petNo", petNo);
            formData.append("accountNo", accountNo);
            formData.append("petImg", petImgInput.files[0]);

            // TODO 정보, 사진 유효성 검사 추가하기

            // (2) ajax
            $.ajax({
                url: '/myPet/update',
                type: 'post',
                data: formData,
                processData: false, //  jQuery가 데이터를 문자열로 변환하지 않게 함
                contentType: false, // multipart/form-data 헤더를 브라우저가 자동으로 넣게 함
                dataType: 'json',
                success: function (data) {
                    console.log('응답:', data);
                },
				error: function (err) {
					console.log('에러:', err);
				}
            });
            
            // 1) 버튼 복원
            petBtnDiv.innerHTML = '';
            petBtnDiv.innerHTML = oriPetBtnsHtml;
            
            // 2) input disabled로 전환
            petDetailsEl.forEach(function (el) {
                el.setAttribute("disabled", true);
            });

            // 3) 수정 버튼 클릭 시 이벤트 다시 달기 (재귀적으로 호출)
            const newEditBtn = petBtnDiv.querySelector('.pet-btn-up');
            newEditBtn.addEventListener('click', handleEditClick);
			
			// 4) 이미지 클릭 시의 이벤트리스너 제거
			petImg.removeEventListener('click', clickElement);
        });            
    });
});

// TODO 삭제 버튼 클릭 시 이벤트