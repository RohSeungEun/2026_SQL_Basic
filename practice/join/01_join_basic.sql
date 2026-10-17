-- 21 BIT practice  예제 복습
-- 환경 : SQL DEVELOPER 
-- JOIN
 -- 두 테이블로부터 모든 레코드 추출 : Cross Join
const sql_cross = `SELECT first_name, emp.department_id, dept.department_id, department_name
                  FROM employees emp, departments dept
                  ORDER BY first_name`;

const sql1 = `SELECT first_name, emp.department_id, dept.department_id, department_name
                FROM employees emp, departments dept
                WHERE emp.department_id = dept.department_id`;


const sql2 = `SELECT first_name, emp.department_id, department_name
              FROM employees emp, departments dept
              WHERE emp.department_id = dept.department_id`;

-- department_id가 null인 사원
const sql3 = `SELECT * FROM employees WHERE department_id IS NULL`;

-- USING: 조인할 컬럼을 명시
const sql4 = `SELECT first_name, department_name
              FROM employees JOIN  departments USING(department_id)`;

-- ON: JOIN의 조건절
const sql5 = `SELECT first_name, department_name
              FROM employees emp JOIN departments dept
              ON (emp.department_id = dept.department_id)`;
                    
                    
-- OUTER JOIN
-- 모든 레코드를 출력할 테이블의 위쳉 따라 LEFT, RIGHT, FULL OUTER JOIN으로 구분
-- ORACLE의 경우 NULL을 출력할 조건 쪽에 (+)를 명시

const sql6 = `SELECT first_name, emp.department_id, dept.department_id, department_name
              FROM employees emp, departments dept
              WHERE emp.department_id = dept.department_id (+)`;

                    
                    
-- RIGHT OUTER JOIN: 짝이 없는 오른쪽 레코드도 NULL을 포함하여 출력
-- ORACLE SQL
const sql7 = `SELECT first_name, emp.department_id, dept.department_id, dept.department_name
              FROM employees emp, departments dept
              WHERE emp.department_id (+) = dept.department_id`;


--ANSI SQL
const sql8 = `SELECT emp.first_name, emp.department_id, dept.department_id, dept.department_name
              FROM employees emp RIGHT OUTER JOIN departments dept
              ON emp.department_id = dept.department_id`;
                    
-- FULL OUTER JOIN
-- result : outer-join된 테이블은 1개만 지정할 수 있음 => error
const sql9 = `SELECT emp.first_name, emp.department_id, dept.department_id, dept.department_name
              FROM employees emp, departments dept
              WHERE emp.department_id (+) = dept.department_id (+)`;


-- ANSI SQL
const sql10 = `SELECT emp.first_name, emp.department_id,dept.department_id, dept.department_name
               FROM employees emp FULL OUTER JOIN departments dept
                    ON emp.department_id = dept.department_id`;
                    
--SELF JOIN : 자기 자신을 두 번이상 호출, alias를 사용할 수 밖에 없는 JOIN (사원 정보, 매니저 이름을 함께 출력해보기)
-- 방법1
const sql_self_join1 = `SELECT emp.employee_id, emp.first_name,
    emp.manager_id, man.employee_id,man.first_name
FROM employees emp JOIN employees man
    ON emp.manager_id = man.employee_id
ORDER BY emp.employee_id`;

-- 방법 2.
const sql_self_join2 = `SELECT emp.employee_id,
    emp.first_name,emp.manager_id,
    man.employee_id,man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id (+) -- LEFT OUTER join : (+)추가
ORDER BY emp.employee_id`;
