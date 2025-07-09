팀 프로젝트 페이지에서 Fork, main branch only 체크박스 해제

개인 리포지토리에서 git clone 받고 로컬에서 test 브랜치로 checkout


=============== push 할 때 ===============

각자 수정한 내용 test 브랜치로 push (브랜치 확인)

깃허브에서 풀 리퀘스트 (본인 리포지토리 test 브랜치에서, 팀 리포지토리 test 브랜치로)


=============== pull 받을 때 ===============

git remote add upstream https://github.com/Goodee-Semi-Project/goodee-semi-project.git

깃 업스트림 추가

이클립스 Git Repository에서 Remotes - upstream - upstream/main, upstream/test 추가 된 것 확인

upstream 우클릭 fetch

Remote Tracking - upstream/main, upstream/test 추가 된 것 확인

필요에 따라 upstream 브랜치 우클릭 Merge 또는 Rebase 활용
