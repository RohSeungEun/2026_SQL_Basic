-- 26년도 11월 2과목 SQLD 기본/활용(1-53) 문제 풀이+ 오답 정리본

-- -# SQL 기본문법
-- 1. SQL 문법 종류
-- 1) 데이터 정의 언어(DDL)
-- 2) 데이터 조작 언어(DML)
-- 3) 데이터 제어 언어(DCL)


-- 1) 데이터 정의 언어, DDL
-- 데이터 베이스 정의 언어, 테이블/스키마 관리
-- 종류 :  1. CREATE : DB/테이블 생성
--         2. ALTER : DB/테이블 수정
--         3. DROP : DB/테이블 삭제
--         4. truncate : 테이블 초기화

-- 2) 데이터 조작 언어, DML
-- 데이터 베이스 테이블 입력된 데이터 검색, 입력, 수정, 삭제
-- 종류 :  1. SELECT : 데이터 검색
--         2.INSERT : 데이터 삽입
--         3. UPDATE : 데이터 수정
--         4. DELETE : 데이터 삭제

-- 3) 데이터 제어 언어(DCL)
-- DB에 접근하거나 객체 권한 부여 역할 언어
-- GRANT : 특정 DB 사용자에게 작업 특정 수행 권한 부여
-- REVOKE : 특정 DB 사용자에게 작업 특정 수행 권한 부여

-- 4)  트랜잭션제어어(TCL)
-- COMMIT : 트랜잭션 완료
-- ROLLBACK: 트랜잭션 취소 및 이전 상태로 복구하는 역할

-- #5. 
-- 정답: 1번 , 2번
-- 보기 1> : SELECT는 DML 중 하나이다.
-- 2>: COMMIT는 TCL에 속하며 ROLLBACK.
-- 3>: DROP은 DDL
-- 4>: ALTER은 DDL

--#6 DDL(Data Definition Language)
--DDL(데이터 정의어)은 데이터 구조 정의하는 명령어.
--DDL은 CREATE, ALTER,DROP, RENAME이 있다.

-- 1) 데이터 정의 언어, DDL
--데이터 베이스 정의 언어, 테이블/스키마 관리
--종류 :  1. CREATE : DB/테이블 생성
--        2. ALTER : DB/테이블 수정
--        3. DROP : DB/테이블 삭제
--        4. truncate : 테이블 초기화

--#7 테이블 컬럼 정의 변경(ALERT)
-- 선택 답안:
ALTER TABLE 기관 분류 
    ALTER COLUMN (분류명 VARCHAR(30) NOT NULL,
                 등록일자 DATE NOT NULL;
-- -> 틀린 이유: SQL에서 동시 수정하는 구문은 지원하지 않음 (오류 발생)
-- -> 수정: 
ALTER TABLE 기관 분류 ALTER COLUMN (분류명 VARCHAR(30) NOT NULL
ALTER TABLE 기관 분류 ALTER COLUMN (등록일자 VARCHAR(30) NOT NULL;

-- #12. 부서가 정의되지 않은 사원은 기본부서(코드: '0000' 배치하고,
-- 입사일지(JOIN_DATE) 기준으로  많은 조회가 발생하므로 입사일지에 index 생성함

-- 1번 풀이
CREATE TABLE EMP
    (EMP_NO VARCHAR(10) PRIMARY KEY,
    EMP_NM VARCHAR2(30) NOT NULL,
    DEPT1_CODE VARCHAR(4) DEFAULT '0000' NOT NULL,
    JOIN DATE DATE NOT NULL,
    REGIST_DATE DATE NULL);
    CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);
    
-- 2번 풀이
CREATE TABLE EMP
    (EMP_NO VARCHAR(10) NOT NULL
    EMP_NM VARCHAR2(30) NOT NULL,
    DEPT1_CODE VARCHAR(4) DEFAULT '0000' NOT NULL,
    JOIN DATE DATE NOT NULL,
    REGIST_DATE DATE);
    ALTER TABLE EMP ADD CONSTRAINT EMP_PK PRIMARY KEY
    (EMP_NO);
    CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);

-- CREATE TABLE: 테이블 생성
CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),   --  --> VARCHAR2: 가변 문자열
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
); -- 괄호 내부 : 테이블 정의



--#10.NULL(추가 정리 필요)
  

-- #35. SELET COL1 + COL3 FROM table_A;
-- 해설: NULL이 포함된 4칙 연산 결과는 NULL 이므로
-- 30 + 20 = 50 , NULL + 40 = NULL, 50 + NULL = NULL 이다.

-- #36. COLUMN1 값이 NULL 아닌 경우
-- 올바른 답안: SELECT * FROM MYTABLE WHERE COLUMN1 IS NOT NULL;
-- 해설: NULL 값 조건절 사용하는 경우 IS NULL, IS NOT NULL로 사용한다.

--#37. SQL과 ORACLE DDL 문장 테이블 생성 시 차이
-- 보기: INSERT INTO 서비스 VALUES ('999', '', '2015-11-11');
-- 보기 처럼 데이터 입력시 ORACLE에서는 데이터 조회하려면 
SELECT * FROM 서비스 WHERE 서비스명 = IS NULL;
-- 보기처럼 데이터 입력시 SQL에서는 데이터 조회하려면
SELECT * FROM 서비스 WHERE 서비스명 = '';

--#41 ⭐⭐⭐⭐ 다시 이해할 것-> 이해하지 못함.
-- keyword: 단일행 문자형 함수 중 라인수 구하기
-- 해설
-- 1. LENGTH: 문자열 길이 반환 함수
-- 2. CHR : ASCII 코드의 문자 반환 함수 (CHR(10) -> 줄바꿈)
-- 3. REPLACE: 문자열 치환 함수 (REPLACE(C1, CHR(10) -> 줄바꿈 제거)
-- 기존 ROWNUM 1> LENGTH: 3, REPLACE 후: AA,  REPLACE(C1, CHR(10)) : 2
-- 기존 ROWNUM 2> LENGTH: 5, REPLACE 후: BBB,  REPLACE(C1, CHR(10)) : 3

-- #45 
-- ISNULL 함수 결과값이 NULL 일시 지정된 값 반환함.
-- <보기>는 실행 결과가 X를 반환한다.
--SELECT ISNULL(COL2, 'X') FROM TAB1 WHERE COL1 = 'a';
-- 왜 정답일까?
-- 결과값이 NULL이 아닌 다른 값을 얻고자 할 때 ISNULL을 확인하는 함수를 사용한다.
-- 칼럼의 NULL 값을 확인 시 ISNULL 함수 사용함.

-- #48 
-- Table1의 c1(1), c2(2,2), C3(3,3,3)
-- SLECT SUM((COALESCE (C1, C2, C3)) FROM TAB1;
-- COALESCE 함수는 임의 개수 표현식에서 NULL이 아닌 최초 표현식을 나타낸다.
-- -> 모든 표현식이 NULL, NULL을 반환함.
-- 왜 정답일까?
-- ROW 1행에서 COALESCE(C1,C2,C3) -> COALESCE(1,2,3) 이기에 수행 결과는 6이다.
-- 즉 한 행이라도 NULL이 있으면 수행 결과에 포함시키면 안된다.

-- #49. 테이블 조회 SQL 패턴
--SELECT 건수 , 금액
--FROM 현금출급기실적
--WHERE 거래일자 BETWEEN '20140701 AND '20140702'
--AND 사무소 코드 = '00368';
-- 해답 설명: 조회 시 상수 값 대입 조건 -> 범위 조회 유형 칼럼으로 하여 접근을 줄이는 것이 좋음.

--#52. 분산 데이터 환경
-- 1.공통 코드, 기준 정보 등 마스터 데이터는 복제분산 적용함.
-- 2. 실시간 업무 특성 시 분산 데이터 베이스 구성함.
-- 3. 백업 사이트 구성.
-- 4. GSI 즉 통합 데이터 베이스 구조는 분산데이터베이스와 대조되는 개념임.
-- -> 복제 분산 방법으로 분산 데이터 환경 구성해야 함.
-- : GSI, 실시간 업무, 백업 사이트 구성함.

-- #53 : 오류가 발생하는 문장
SELECT 메뉴ID, 사용유형코드, AVG(COUNT(*)) AS AVGCNT
FROM 시스템 사용 이력
GROUP BY 메뉴ID, 사용유형코드;
-- 틀린 이유: GROUP BY 절에서 실행 결과는 1건이 되야 하기에
-- SELECT 절에서 메뉴 ID와 사용유형코드는 사용할 수 없음.

-- GROUP BY 절 특성
-- 1. SELECT 절에 집계 함수 사용함 
-- 2. 해당 함수는 NULL 값 가진 행 제외하고 수행함.
-- 3. SELECT 절과 달리 별칭명 사용하지 못함.
-- 4. 집계함수는 WHERE 절 오지 못함.
  
