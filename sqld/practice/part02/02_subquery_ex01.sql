-- 검정문제-서브쿼리 문제 필수 정리+오답#51~
-- 1.1 서브 쿼리 특징
-- - 서브 쿼리는 반드시 소괄호로 감싸 사용함
-- - 서브 쿼리는 주 쿼리 실행 전 1번만 실행함
-- - 비교 연산자에 서브 쿼리를 사용하는 경우 서브 쿼리를 오른쪽 기술함
-- - 서브 쿼리 내부에는 정렬 구문인 ORDER BY 문 사용할 수 없음

--#51 서브쿼리의 종류 설명 옳은 것은?
-- 다중 칼럼 서브쿼리
-- 서브 쿼리의 실행결과로 여러 칼럼을 반환함
-- 메인쿼리의 조건절에 여러 칼럼을 동시 비교할 수 있음.
-- 서브 쿼리와 메인쿼리에서 비교하고자 하는 칼럼 개수와 칼럼 위치 동일해야 함.

-- #52. SQL 실행 결과 다른 것은? 
-- 2번만 COL1별 합계 값만 구하는 SQL이기에 결과 건수가 달라지기에 2번이 정답임
-- 1,3,4번은 COL1별 합계 값과 전체 합계 값까지 구하는 SQL이기에 결과 건수가 동일함


-- 1번
-- - * 다중행 연산자 : 서브 쿼리의 결과가 2건 이상일 것
-- ALL : 모든 비교 집합일 참일 경우에 해당 데이터 조회
SELECT COL1, SUM(CO2)
FROM T1
GROUP BY COL1
UNION ALL
SELECT NULL, SUM(CO2)
FROM T1
ORDER BY 1 ASC;

-- 2번
-- GROUPING SETS
-- - 인수 2개 이상 일때 :모두 다른 결과
-- - 인수 순서 무관
SELECT COL1, SUM(CO2)
FROM T1
GROUP BY GROUPING SETS(COL1)
ORDER BY 1 ASC;

--3번 
-- ROLLUP 
-- - 인수 1개 일때 : CUBE 와 같은 결과
-- - 인수 2개 이상 일때 : 모두 다른 결과
-- - 인수 순서에 따른 다른 결과

SELECT COL1, SUM(CO2)
FROM T1
GROUP BY ROLLUP(COL1)
ORDER BY 1 ASC;

--4번
-- CUBE (SUBTOTAL 생성 시 바람직 O, 시스템 많은 부하 주므로 주의!)
-- - 인수 1개 일때 : ROLLUP 와 같은 결과
-- - 인수 2개 이상 일때 :모두 다른 결과
-- - 인수 순서 무
SELECT COL1, SUM(CO2)
FROM T1
GROUP BY CUBE(COL1)
ORDER BY 1 ASC;


--#53 SET OPERATOR 중에서 수학 교집합 같은 기능을 하는 연산자.
-- 1번 UNION 2번 INTERSECT 3번 MINUS 4번 EXCEPT

--*집합 연산자의 종류
-- 1. UNION : 합집합 
--    - 여러개 SQL문 결과의 합집합
--    - 모든 중복된 행은 하나의 행으로 만든다.
-- 2. UNION ALL : 합집합
-- 3. INTERSECT : 교집합
--    - 여러개 SQL문 결과의 교집합
--    -중복된 행은 하나의 행으로 만든다.
-- 4. EXCEPT : 차집합       
--    - 앞의 SQL문 결과에서 뒤의 SQL문 결과를 제거한 차집합
--    - 중복된 행은 하나의 행으로 만든다.(일부 DB MINUS를 사용함)


-- 54. 집합 연산자에 대한 설명으로 가장 적절하지 않은 것은?
-- 1. UNION 연산자는 합집합 결과에서 중복된 행을 하나의 행으로 만듬.
-- 2. UNION ALL 연산자는 집합 간의 결과가 중복되지 않은 경우 UNION 결과가 동일함.
-- 3. UNION 연산자 사용한 SQL은 각각의 집합에 GROUP BY 절을 사용할 수 있음.
-- 4. UNION 연산자 사용한 SQL은 각각의 집합에 ORDER BY 절을 사용할 수 있음.
