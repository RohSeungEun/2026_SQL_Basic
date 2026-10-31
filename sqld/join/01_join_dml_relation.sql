------24년도 패캠 강의+SQL 문서=> JOIN 이해와 실습
----- 조인(JOIN) 
-- -두개 이상의 테이블이나 데이터 베이스 연결하여 데이터 검색
-- -추출 컬럼이 타테이블 있을 경우 주로 사용함.
-- -여러 테이블 데이터 조합하여 하나의 데이터 셋 반환함.

-- 1.조인 필요성
-- -중복 저장한 열 데이터 수정 시 해당 컬럼 가진 다른 데이터 찾아 모두 수정 필요함.
-- -데이터 중복 최소화, 데이터 무결성 => 여러개 테이블 분리/저장 => 관계 형성!

-- 1.2 조인의 종류
-- 1.2-1 INNER 조인
-- -조인키에 해당하는 각 테이블 열값 비교해 조건에 맞는 값 검색
-- -업무에 주로 사용  

-- * ON 문과 WHERE 문의 차이
-- -ON문: 데이터 필터링, "조인 조건"을 위해 사용함.
-- -WHERE문: "조인 완료 상태"에서 조건에 맞는 값 필터함
-- -ON문=>WHERE문 효과 낼 수 있지만, 조인 만족하는 데이터 매칭시 오차 발생=>반드시 성격 분리


SELECT first_name, emp.department_id, dept.department_id, department_name 
  FROM employees emp, departments dept
  WHERE emp.department_id = dept.department_id (+);

-- 1-2-2. OUTER JOIN 
-- -조인 여러 테이블에서 한 쪽 데이터가 있고 한쪽 데이터 없는 경우 데이터 내용 전부 출력할 때 사용함.
-- -조인의 조건에 맞지 않는 행까지도 포함시키는 것, 가끔 유용한 방식.
-- -OUTER JOIN은 LEFT, RIGHT, FULL 중 한 옵션 지정함.
-- -LEFT(왼쪽 테이블 기준 출력하여 조회), RIGHT(오른쪽 테이블 기준 출력하여 조회)는 기준 테이블 정함.
-- -LEFT OUTER JOIN에서 OUTER 생략 가능함.
-- -FULL JOIN : LEFT, RIGHT 합친 것이지만 양쪽 모두 조건에 일치 하지 않는 것 모두 출력함.
-- -FULL JOIN은 MySQL 지원하지 않음 => LEFT JOIN과 RIGHT 조인 합칠 것.

-- LEFT OUTER JOIN 예시              
SELECT first_name, emp.department_id, dept.department_id, dept.department_name
  FROM employees emp, departments dept
  WHERE emp.department_id (+) = dept.department_id;

-- FULL OUTER JOIN 예시              
SELECT emp.first_name, emp.department_id, dept.department_id, dept.department_name
  FROM employees emp, departments dept
  WHERE emp.department_id (+) = dept.department_id (+);

-- 1-2-3. CROSS JOIN(상호조인)
-- -조인에 포함된 테이블 카티션 곱을 산출함.
-- -한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행 조인시킴, 결과 개수는 두 테이블 곱한 개수임.
-- -각 테이블 모든 경우의 수 조합한 데이터가 필요할 경우 사용함.
-- -FROM 구문에 조인 조건 없는 것이 특징임.

-- 1-2-4. SELF JOIN
-- -같은 테이블 사용하는 특수 조인
-- -테이블의 행을 같은 테이블 내 다른 행과 조인임.
-- -계층적 구조 테이블화 시 사용함.
-- -받드시 테이블 ALIAS 명 사용해서 질의함
-- -SELF JOIN 개념적으로 별도의 JOIN 구문 없음.

SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
    FROM employees emp 
    JOIN employees man
    ON emp.manager_id = man.employee_id
    ORDER BY emp.employee_id;

-- 1-3. 조인 주의사항
-- -OUTER JOIN : 기준 테이블 순서 주의
-- -ON 절/WHERE 절: 목적에 반드시 구분해서 사용함.
-- -OUTER JOIN 과정 시 행수 늘어날 수 있음 인지해야 함.
-- -LEFT JOIN: 1:1, 1:N 테이블 행수 X, 1:N 경우 기준 데이터 중복, 결과 행수 늘어날 수 있음.
