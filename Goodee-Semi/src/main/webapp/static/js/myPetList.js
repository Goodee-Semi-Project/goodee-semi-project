// '추가 등록' 버튼을 눌렀을 때 리스트에 등록되고 등록된 지점으로 페이지 이동
// 정보를 수정할 수 있도록 정보가 input 안에 표시됨 & 이미지 테두리선 색깔이 생김 
// & '수정', '삭제' 버튼이 '수정사항 저장'으로 바뀜
// 수정사항 저장 시 유효성 검사
// 유효성 검사 통과시: '수정되었습니다' 라는 메시지 창이 뜨고, '확인'을 누르면 메시지 창 사라짐

// TODO 수정, 삭제 기능 먼저 구현 후 등록 기능 구현하기

// 페이지 로드 > 요소 가져오기 > 클릭 이벤트 감지 > 


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

        // 4. save 버튼 누를 시 ajax로 수정 요청 보내고 응답받아 input 안의 value 수정 &
        // 버튼 되돌리고 input disabled로 전환
        const newPetBtn = petBtnDiv.querySelector('.pet-btn-save');
        newPetBtn.addEventListener('click', function (btn) {
            // 1) ajax로 요청 보내고 응답 받아 value 수정
            // (1) input 안의 value값 가져오기
            const petName = petDetailEl.querySelector('.pet-name').value;
            const petAge = petDetailEl.querySelector('.pet-age').value;
            const petGender = petDetailEl.querySelector('.pet-gender').value;
            const petBreed = petDetailEl.querySelector('.pet-breed').value;
            const petNo = petDetailEl.querySelector('.pet-no').value;
            const accountNo = petDetailEl.querySelector('.account-no').value;

            // TODO 유효성 검사 추가하기
            // TODO 이미지 수정 기능 추가하기

            // (2) ajax
            $.ajax({
                url: '/myPet/update',
                type: 'post',
                data: {
                    petName: petName,
                    petAge: petAge,
                    petGender: petGender,
                    petBreed: petBreed,
                    petNo: petNo,
                    accountNo: accountNo,
                },
                dataType: 'json',
                success: function (data) {
                    console.log(data.resCode);
                    console.log(data.resMsg);
                    console.log(data.petName);
                    console.log(data.petAge);
                    console.log(data.petGender);
                    console.log(data.petBreed);
                    console.log(data.petNo);
                    console.log(data.accountNo);
                },
				error: function (msg) {
					console.log(msg);
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
        });            
    });
});