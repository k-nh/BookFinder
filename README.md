### 개요
* `오픈 API`([Google Books API](https://developers.google.com/books/docs/overview))를 이용하여 사용자의 검색어에 대한 결과를 리스트로 표시

![Simulator Screen Recording - iPhone 13 Pro - 2022-09-15 at 20 23 18](https://user-images.githubusercontent.com/53509789/190391773-b0dd0710-e38f-4ed7-8998-32d10c824be1.gif) ![Simulator Screen Recording - iPhone 13 Pro - 2022-09-15 at 20 20 07](https://user-images.githubusercontent.com/53509789/190391666-bfad653c-dd1d-4daf-b434-8d3355adff7f.gif)

### 프로젝트 상세
* `Clean Swift` 아키텍처 사용
* 리스트 하단에 도달했을 경우, `페이지네이션을 통해 무한 스크롤 구현`
* 데이터를 호출 중일때, `로딩 애니메이션` 구현
* 불러온 이미지를 `cache에 저장`하여 성능 개선
* `테스트 코드` 작성
