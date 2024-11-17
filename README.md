# coinguesser-front

레포지토리의 브랜치 관리

main 브랜치는 항상 배포 가능한 상태를 유지

develop 브랜치는 기능을 테스트하고 안정화 하는 브랜치

feature/* 브랜치 개발자가 새로운 기능을 개발하는 브랜치

새로운 기능을 추가할 때 test/ 디렉토리에 자신이 개발한 기능에 대한 feature*.test.js파일도 작성해야함

git action으로 feature 브랜치에서 develop 브랜치로 PR시 자동으로 테스트
