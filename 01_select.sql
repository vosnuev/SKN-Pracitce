-- Active: 1773027509538@@127.0.0.1@3306
-- 01_SELECT : 특정 테이블에서 원하는 데이터 조회

-- 단일 열 데이터 검색
SELECT menu_name FROM tbl_menu;

-- 다중 열 데이터 검색
SELECT menu_code, menu_name, menu_price From tbl_menu;

-- tbl_menu의 모든 컬럼 조회 (*)

SELECT  * FROM tbl_menu;

--단독 select 문 사용

--연산자 테스트
SELECT 7 + 3;
SELECT 7 - 3;

--내장 함수 테스트
SELECT NOW();       --현재 날짜
SELECT CONCAT('유', ' ', '관순'); 

--컬럼에 별칭 부여
SELECT NOW() AS 현재시간;        --as 붙이나 안붙이나 똑같음
SELECT CONCAT('유',' ','관순') name;
SELECT CONCAT('유', ' ','관순') 'full name';  --띄어쓰기 있으면 안되기에 ''로 묶기

