-- 26년도 SQL DOCS 분석+나혼자SQL책=> SQL 응용+실습
------JOIN------

---1. INNER JOIN(내부 조인)
-- 두 테이블에 모두 데이터가 있어야만 결과가 나옴.

--*INNER JOIN <-> 1:N 관계 연관성
--1:1 관계: 한쪽 테이블에 하나의 값만 존재함
--1:N 관계: 한쪽 테이블에 하나의 값만 존재해야 하지만,연결된 다른 테이블에는 N개 값 가짐.

--1:N 관계(일대 다 관계)
--1.마켓-회원:회원(본인)이 마켓에서 여러번 구매 내역을 받음.
--2.회사-회사원:회사원(본인)이 회사에서 여러 급여를 받음.
--3.학교-학생:학교에서 회원(본인)이 여러 과목의 학점과 점수를 이수함.

-- 특징
-- 1:N 관계 테이블에서 하나의 고유 값만 PK,다른 쪽 테이블의 고유 값(ID)는 외래키를 지정함.

--실습
USE shop_db;

--INNER JOIN 조회 시 WHERE구문 이용
-- 해당 아이디 추출 후 회원 테이블-동일 아이디 검색-두행을 결합
SELECT customer_id, customer_name, product_name, customer_phone_number, customer_addr,
    FROM order_list
    INNER JOIN customer
    ON order_list.customer_id = customer.customer_id
    WHERE order_list.customer_id = '구매한 사람 이름';

-- 위 구문 간결화
SELECT c.customer_id, c.customer_name, o.product_name, c.customer_phone_number, c.customer_addr,
    FROM order_list o
    INNER JOIN customer c
    ON o.customer_id = c.customer_id
    WHERE o.customer_id = '구매한 사람 이름';

---2. OUTER JOIN(외부 조인)
-- INNER JOIN과 달리 한 쪽 테이블에 데이터 있어도 결과가 나옴.
-- LEFT OUTER JOIN(LEFT JOIN)은 이력이 없는 데이터도 추출 가능함. 
-- RIGHT OUTER JOIN(RIGHT JOIN)은 LEFT JOIN 구문-테이블 위치만 변경하면 됨(동일 결과 얻음).

--LEFT JOIN
SELECT c.customer_id, c.customer_name, o.product_name, c.customer_phone_number, c.customer_addr,
    FROM order_list o
    LEFT OUTER JOIN customer c
    ON o.customer_id = c.customer_id
    ORDER BY c.customer_id;

--RIGHT JOIN
SELECT c.customer_id, c.customer_name, o.product_name, c.customer_phone_number, c.customer_addr,
    FROM order_list o
    RIGHT OUTER JOIN customer c
    ON o.customer_id = c.customer_id
    ORDER BY c.customer_id;

--LEFT JOIN으로 상태 구매 이력 없는 회원 SQL
SELECT DISTINCT c.customer_id, c.customer_name, o.product_name, c.customer_phone_number, c.customer_addr,
    FROM order_list o
    LEFT OUTER JOIN customer c
    ON o.customer_id = c.customer_id
    WHERE o.order_history IS NULL
    ORDER BY c.customer_id;

---+PLUS DISTINCT 구문:
--SELECT구문에서 사용, 중복된 데이터 제거하고 데이터 조회 사용함.
--예시
--쇼핑몰 내 제품 리스트 중 제품 이름명 
SELECT DISTINCT product_name FROM product_list;

--쇼핑몰 내 제품 리스트 중 고유 제품 이름 개수 추출.
SELECT count(DISTINCT product_name) FROM product_list;

--쇼핑몰 내 제품 리스트- 24년도 이후 입고된 제품 쿼리문
SELECT count(DISTINCT p.product_name) 
    FROM product_list p
    WHERE p.product_store_year => 24;
