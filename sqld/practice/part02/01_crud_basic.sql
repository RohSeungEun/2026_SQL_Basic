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
  
-- STUDY P.60 (41~
-- Searched Case Expression
-- LOC 조건에 따라 결과값을 리턴한다.
-- Q43
SELECT LOC, 
    CASE WHEN LOC = "NEW YORK" THEN "EAST"
        ELSE 'ETC'
    END as AREA
FROM DEPT;

-- Simple Case Expression
-- LOC의 해당 값에 따라 결과값을 리턴한다.
SELECT LOC, 
    CASE LOC WHEN "NEW YORK" THEN "EAST"
        ELSE 'ETC'
    END as AREA
FROM DEPT;

3  2  X
4  2 NULLIF

-- Q44 ⭐⭐⭐

-- Q45 : NULL의 올바른 특성 
--1. 공집합 아님
--2. 값이 NULL인 경우 숫자 데이터는 0, 문자 데이터는 X로 치환한다. -> 정답
--3. 실행결과는 모른다.
--4. 실행결과는 2다.

-- Q46 : 단일행 NULL 함수
SELECT ENAME, EMPNO, MGR, NULLIF(MGR, 7698) as NM FROM EMP;

-- Q47 : NULL 포함된 연산 
-- NULL 포함된 연산 결과는 NULL이다.
-- NULL 포함된 연산에서 부모가 0이 들어가는 경우 Error 발생함.
-- 문장 1 > 0 / 300 = 0
-- 문장 2 > 5000 / 0 = error
-- 문장 3 > 1000 / null = null

-- #48.
-- COALESCE 함수는 NULL이 아닌 값을 반환한다.
SELECT SUM(COALESCE(C1,C2,C3)) FROM TAB1;
-- COASLESCE(1,2,3) = 6

-- #49.
-- NVL(): 표현식의 결과값이 NULL이면 표현식 1 반환함.
-- NULLIF(): 표현식의 1이 표현식이 2와 같으면 NULL, 같지 않으면 표현식 1을 반환한다.
-- COALESCE(): NULL이 아닌 값을 반환한다.

-- #50.
SELECT AVG(COL3) FROM TABA;
SELECT AVG(COL3) FROM TABA WHERE COL1 > 0;
SELECT AVG(COL3) FROM TABA WHERE COL1 IS NOT NULL;
-- NULL이 포함된 연산의 결과는 NULL이다.
-- 문장 1> COL3(20, 0, NULL) ---> AVG(10)
-- 문장 2> AVG(20)
-- 문장 3> AVG(20)

-- #51
SELECT COUNT(GRADE) FROM EMPL
SELECT GRADE FROM EMP WHERE GRADE IN ("차장", "부장", "널");
SELECT GRADE COUNT(*) FROM EMP GROUP BY GRADE;

-- 문장 1> 500+ 100+ 30 + 10 + 5 = 645 (단 , NULL 제외)
-- 문장 2> 10 + 5 = 15 (단, NULL 제외)
-- 문장 3>  5 + NULL = 6건

-- #52 이해 필요.

-- #54
SELECT MAX(가) AS 가, SUM(다) AS 다
FROM A 
GROUP BY 나
HAVING COUNT(*) > 1
ORDER BY 다 DESC;

-- 가    나    다 
-- 009  A003  600
-- 005  A002  500
-- 002  A001  300
-- 010  A004  200
-- COUNT 2이상 인 경우 A003 ~ A001 까지임

--#56: 오류 발생하는 문장
--보기2 
SELECT 지역, 매출 금액
FROM 지역별 매출
ORDER BY  년 ASC;
-- ORACLE은 행기반 DBMS로 SELECT 절에 없는 칼럼도 정렬할 수 있다.
-- SQL 실행 순서는 SELECT 절 이후 ORDER BY 절 수행으로 논리적으로 맞지 않다.

-- #57: 0RDER BY 절 특성
-- 1. SQL 문장으로 조회된 데이터들을 다양한 목적에 맞게 특정 컬럼을 기준으로 정렬함.
-- 2. DBMS마다 NULL에 정의된 정렬 순서가 다를 수 있으므로 주의해야 한다.
-- 3. ORDER BY절에 ALIAS(별칭), 컬럼 순서 나타낸 정수를 혼용해서 사용 가능함.
-- 4. GROUP BY 절에 ORDER BY 절 집계 함수를 사용할 수 있다.

--#63: JOIN 설명
-- JOIN: 두 개 테이블 혼합하여 테이블 출력
-- 1. JOIN은 일반적으로 PK, FK 연관성에 의해 성립된다
-- 2. EQUI JOIN은 테이블 간 컬럼값들이 정확하게 일치하는 경우 성립된다.
-- 3. EQUI JOIN은 "="에 의해서만 수행되고 그 이외 연산자를 사용하는 경우
--    NONE EQUI JOIN이다.
-- 4. 대부분 NONE EQUI JOIN을 수행할 수 있지만, 때로는 설계상의 이유로
--   수행이 불가능한 경우도 있다.

--#65 순수 관계 연산자 설명
-- 순수 관계 연산자는 SELECT, JOIN, PROJECT, DIVIDE 로 구성된다.
-- SELECT는 WHERE 절로 구현함
-- JOIN은 다양한 JOIN으로 구현함
-- DIVIDE 연산은 현재 사용되지 않지만 순수 관계 연산자.

-- #68 JOIN
-- 정답은 맞췄지만 정확한 해설이 필요함.
-- 조건: 구매 이략이 있는 고객 중 구매 횟수가 3회 이상인
--       고객의 이름과 등급을 출력하시오.
-- 보기> TAB1: 고객(고객번호(PK), 이름, 등급)
--      TAB2: 구매정보(구매번호(PK), 구매금액, 고객번호(FK))
--  * 구매 정보 테이블의 고객번호는 고객 테이블의 고객 번호를 참조하는 외래키이다.
-- 스스로 생각한 답안 : LEFT OUTER JOIN은 왼쪽 테이블을 읽은 후 우측의 테이블 데이터 불러온다.
-- 조건에 따라 구매한 정보들이 고객 테이블에 동일한 값으로 담겨져야 하고 구매 횟수가 3회 이상으로
-- WHERE 절보다는 COUNT가 적합하다.
-- 해설: 구매 이력이 있어야 하므로 INNER JOIN, 구매 횟수이므로 COUNT 함수를 사용한다.

-- #74 LEFT , FULL, RIGHT 외부 조인에 대한 설명
-- FULL OUTER JOIN: 수행 시 좌측과 우측의 데이터를 합집합한 결과 -> 5건
-- ! 해당 줄 부터 이해되지 않음 ( 다시 이해 할 것)
-- RIGHT OUTER JOIN: 우측이 기준으로 우측의 데이터를 먼저 읽고 
--  좌측의 테이블데이터를 가져온다. 같은 값이 없을 시 가져오는 좌측 테이블 NULL로 채움 -> 4건
-- LEFT OUTER JOIN: 좌측 테이블의 데이터를 기준으로 데이터를 먼저 읽은 후 우측 테이블
-- 데이터를 읽은다. 같은 값이 없을 시 가져오는 우측 테이블 NULL -> 3건
-- 해설: 주키와 왜래키는 영향에 미치지 않는다.

-- #76 : OUTER JOIN
SELECT * FROM TAB1 LEFT OUTER JOIN TAB2 B 
    ON (A.C1 = B.C1 AND B.C2 BETWEEN 1 AND 3)
-- LEFT OUTER JOIN은 왼쪽 테이블의 데이터를 읽어 온 뒤 오른쪽 테이블의 데이터를 읽어온다.
-- 기준 테이블을 항상 표시하고 조건에 맞게 수행한다.

--#81 : SET OPERATOR
-- UNION: 합집합
-- INTERSECT : 교집합
-- MINUS: 차집합
-- EXCEPT: 차집합 

--#82 : 문제 자체를 풀지 못함
-- UNION ALL 사용 시 칼럼 별칭은 첫번째 모듈 기준으로 표시하며
-- ORDER BY 절은 집합 연산을 적용한 최종 결과에 대한 처리이고
-- 가장 마지막에 한번에 실행된다.

--#90 계층형 질문에 대한 설명
-- 1. SQL server 계층형 질문은 CTE를 재귀 호출함으로써 계층 구조를 전개한다.
-- 2. SQL server 계층형 질의문은 앵커 멤버를 실행하여 기본 결과 집합을 만들고
--  이후 재귀 멤버를 지속적으로 실행한다.
-- 3. ORACLE server 계층형 질의문에서 WEHREㅈ 절에서 모든 전개를 진행한 이후
-- 필터 조건으로 맞는 데이터만 추출하여 활용된다.
-- 4. ORACLE server 계층형 질의문에서 PRIOR 키워드는 SELECT, WHERE 절에서 사용한다.

--#92 SELF JOIN 수행해야하는 경우
-- 한 테이블 내에서 연관된 컬럼이 있다.
-- SELF-JOIN: 동일 테이블 사이 조인 수행 시 테이블, 컬럼 모두 동일하여 별칭을 사용해야 한다.

-- #93 WINDOW FUNCTION을 사용하지 않고 일자별누적매출액을 구할 것.
-- 해설 참고해서 다시 공부해보기 !! 가장 중요함

-- #95 서브쿼리에 설명 
-- 1. 서브 쿼리는 단일행 또는 복수행 비교 연산자와 함께 사용된다.
-- 2. SELECT 절, FROM 절, HAVING 절, ORDER BY 절에서 사용 가능함.
-- 3. 연관 서브 커리는 서브 쿼리가 메인 쿼리 컬럼을 포함하는 형태이다. --> 다시 찾아보기
-- 4. 서브쿼리의 결과가 복수행 결과를 반환하는 경우 복수형 비교 연산자와 사용해야 한다.
-- 5. 다중컬럼 서브 쿼리는 SQL Server에서 현재 지원하지 않음.

-- #96  SQL 빈칸 찾기(틀림)
-- 보기: 현재 부양하는 가족들이 없는 사원들의 이름을 구할 것.
SELECT 이름 FROM 사원 WHERE NOT EXISTS (SELECT * FROM 가족 WHERE 사번 = 부양사번);

-- #98  SQL 바른 설명 찾기
-- 1이 틀린 이유: 이메일이 발송된 기록이 있는 모든 회원 추출이 아닌 이메일 발송 누락된 회원을 추출하는 것임.
-- 4이 틀린 이유: HAVING 절을 사용했더라도 오류가 발생하지 않는다. 
-- 3이 틀린 이유: 해설 참고 >>  비연고나 서브쿼리가 주로 메인쿼리에 값을 제공하기 위한 목적으로 사용됨 --> 다시 이해하기

-- #99 서브쿼리 설명(2)
-- 1이 틀린 이유: 단일행 서브쿼리는 IN , ALL 비교 연산자를 사용하지 않는다. 
-- => 복수행 결과 반환 시 IN, ALL 등 복수형 비교 연산자 사용함.
-- 3이 틀린 이유: 비연관 서브쿼리가 주로 메인 쿼리에 값을 제공하기 위한 목적이므로 헷갈리지 말 것.
-- 4이 틀린 이유: 해설 참고>> 메인 쿼리의 결과가 서브쿼리로 제공되거나 서브쿼리의 결과가 메인쿼리로 제공될 수도 있음.
-- 주의 : 다중 행 서브쿼리 비교 연산자는 단일 행 서브쿼리의 비교 연산자로도 사용할 수 있음을 주의하자!
