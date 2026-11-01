----가게 제품(Product),주문(OrderList)테이블

--- 가게 제품(Product) SQL
--제품 테이블 조회(전체 데이터 조회 => 데이터 산출 내역 속도 저하)
SELECT * FROM food_items;

-- 제품 테이블 데이터 삽입
INSERT INTO "food_items" + 
            "(food_name, food_image1, food_image2, food_image3, food_info, food_price, food_category)" +
            "VALUES(?, ?, ?, ?, ?, ?, ?)";

--** 제품 테이블 수정, 삭제(관리자ID가 맞을 경우로 이후 추가 보완할 것)
--제품 테이블 수정
UPDATE food_items " +
  "SET food_name = ?, food_price = ?,
       food_category = ?, food_info =  ? "+"
  WHERE food_id = ?;

--제품 테이블 삭제
DELETE FROM food_items WHERE food_id = ?

  
---주문테이블과 주문리스트 테이블 (1:N 관계)
---주문테이블  
  
-- 주문테이블 주문 많은 데이터 수 조회
SELECT max(id_order_num) FROM order_num;

-- 주문테이블, 제품 테이블, 사용자 테이블 LEFT OUTER JOIN => 주문 상태시 산출
SELECT * " +
  "FROM order_num " +
  "LEFT JOIN order_list ON id_order_num = order_num_id_order_num " +
  "LEFT JOIN food_items ON food_items_food_id = food_id " +
  "LEFT JOIN users ON users_user_id = user_id " +
  "WHERE order_status = 1;

--주문테이블 주문 데이터 삽입
INSERT INTO order_num' +
        '(order_total_price, users_user_id, order_date)' +
        'VALUES(?, ?, ?);

---주문내역 테이블
-- 주문내역 테이블 부분 데이터 조회1
SELECT id_order_list AS id ,id_order_num, 
        order_quantity AS quantity, order_date, 
        order_status AS status, 
        order_total_price AS price, food_name, food_id "+"
   FROM order_list "+"
   LEFT JOIN order_num 
    ON order_num_id_order_num = id_order_num "+"
   LEFT JOIN food_items
    ON food_items_food_id = food_id "+"
   WHERE users_user_id = ?;

--주문내역 테이블 삽입
INSERT INTO order_list' +
            '(food_items_food_id, order_quantity, order_num_id_order_num)' +
            'VALUES(?, ?, ?);

-- ** 보완 필요함**
--주문내역 테이블 수정(주문한 고객이 맞을 경우)
UPDATE order_list SET order_status = 1 WHERE id_order_list = ?;

--주문내역 테이블 삭제(주문한 고객이 맞을 경우)
DELETE FROM order_list WHERE id_order_list = ?
