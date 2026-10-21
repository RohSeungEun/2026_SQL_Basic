// 목표: SQL문 기본
// 출처: 패캠 강의 개념 정리, 기출 문제 오답 분석!

// 1. SQL 문법 종류
// 1) 데이터 정의 언어(DDL)
// 2) 데이터 조작 언어(DML)
// 3) 데이터 제어 언어(DCL)


// 1) 데이터 정의 언어, DDL
// - 데이터 베이스 정의 언어, 테이블/스키마 관리
// - 종류 :  1. CREATE : DB/테이블 생성
// -  2. ALTER : DB/테이블 수정
// -  3. DROP : DB/테이블 삭제
// -  4. truncate : 테이블 초기화

// 2) 데이터 조작 언어, DML
// - 데이터 베이스 테이블 입력된 데이터 검색, 입력, 수정, 삭제
// - 종류 :  1. SELECT : 데이터 검색
// -  2.INSERT : 데이터 삽입
// -  3. UPDATE : 데이터 수정
// -  4. DELETE : 데이터 삭제

// 3) 데이터 제어 언어(DCL)
// - DB에 접근하거나 객체 권한 부여 역할 언어
// - GRANT : 특정 DB 사용자에게 작업 특정 수행 권한 부여
// - REVOKE : 특정 DB 사용자에게 작업 특정 수행 권한 부여

// 4)  트랜잭션제어어(TCL)
// - COMMIT : 트랜잭션 완료
// - ROLLBACK: 트랜잭션 취소 및 이전 상태로 복구하는 역할


// 2. 데이터 베이스
// 정의: 데이터 저장하는 최상위 단위
// 구조화된 데이터의 특정 집합이 저장되는 테이블 모음
// DB 내 스키마라는 하나 이상의 개체 소유권 그룹 있음
// 스키마는 테이블, 뷰, 저장, 프로시저 등 데이터베이스 개체 포함
// MYySQL은 데이터베이스 개수 무제한(OS 파일 개수 제한 따름)


// 2.1) 데이터베이스 생성
// 기본 구문 : CREATE DATABASE DB이름;

// 2.2) 데이터베이스 삭제
// 기본 구문 : DROP DATABASE DB이름;


// 3. 테이블 
// 테이블 : 행과 열의 모음 구성
// * 행 : 레코드/튜플 지칭, 열 : 특성 뜻함, 열에는 특정 유형 정보 저장됨
// 테이블은 데이터베이스 내부에생성
// MYySQL은 데이터베이스 개수 무제한(OS 파일 개수 제한 따름)
// InnoDB 스트리엔진은 40억개 테이블 지원


// 3-1. AUTO_INCREMENT
// - 테이블 열에 AUTO_INCREMENT 적용하면 해당 열 1씩 또는 사용자 정의만큼 증가 자동입력
// - AUTO_INCREMENT 열 생성 시 반드시 해당 열 PK 지정
// - AUTO_INCREMENT 값의 경우 한 번 발급되면 재사용, 증가되는 값만 기록함
// - 일반적이지 않지만 필요 시 중간에 삭제된 AUTO_INCREMENT값 입력하여 수정.


// 3-2. 테이블 생성
// 구문: CREATE TABLE 명령문 사용
// -DB 내 동일 이름의 테이블 생성 불가함

// ex) CREATE TABLE tbl_a (
//   col_1 INT AUTO_INCREMENT PRIMARY KEY,
//   col_2 VARCHAR(50),
//   col_3 DATETIME
//   );

// 3-3. 테이블 수정
// 구문: ALTER TABLE 명령문 사용
// 컬럼 추가(ADD), 컬럼 수정(MODIFY), 컬럼 이름 변경(CHANGE), 컬럼 삭제(DROP), 테이블 이름 변경(RENAME)

// 추가1. 테이블 컬럼 추가
// ALTER TABLE tbl_a 	ADD COLUMN col_4 VARCHAR(50);

// 추가2. 테이블 컬럼 추가 시 특정 컬럼 뒤에 넣기
// ALTER TABLE tbl_a ADD COLUMN col_5 INT AFTER col_2;

// 추가3. 테이블 컬럼 추가 시 맨 앞 컬럼에 넣기
// ALTER TABLE tbl_a ADD COLUMN col_6 INT FIRST;      

// 컬럼 사이즈 수정
// ALTER TABLE tbl_a MODIFY COLUMN col_4 VARCHAR(10);

// 컬럼 이름 변경
// ALTER TABLE tbl_a CHANGE COLUMN col_4 del_col VARCHAR(10);

// 컬럼 삭제
// ALTER TABLE tbl_a  DROP COLUMN del_col;

// 3-3. 테이블 삭제
// 구문: DROP TABLE 명령문 사용
// - 삭제 명령 즉시 삭제로 주의, 단 현재 삭제 테이블이 다른 테이블 종속인 경우 삭제 시 실패함.
// EX) DROP TABLE Tbl_new;    
