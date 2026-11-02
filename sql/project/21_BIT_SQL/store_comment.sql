-----26년도 21년도 PROJECT 고객 리뷰테이블 분석/정리 + 추후 설명과 SQL 정리
---리뷰 테이블
--리뷰 테이블 최대 데이터 조회
SELECT max(comments_id) FROM comments;

--리뷰 테이블 데이터 상태에 따른 조회2
SELECT * FROM comments WHERE comments_status = 0;

--리뷰 테이블 데이터 조회3(해당 리뷰 작성한 아이디 제품 산출 SQL)
SELECT * FROM comments 
  LEFT JOIN food_items 
  ON food_items_food_id = food_id 
  WHERE comments_id = ?, id;
  
--리뷰 테이블 데이터 조회4
SELECT comments_text AS text, comments_title AS title, 
       comments_status AS status "+"
       ratings, food_name, comments_user_id AS id, 
       comments_id, food_category AS category "+"
       FROM comments "+"
       LEFT JOIN food_items ON food_items_food_id = food_id;
 
--리뷰 테이블 데이터 삽입1
INSERT INTO comments
    comments_image, comments_image2, comments_image3, comments_text, 
    ratings, food_items_food_id, comments_user_id, comments_title,
    comments_status, comments_date
    VALUES ?, ?, ?, ?, ?, ?, ?, ?, ?, ?;

--리뷰 테이블 데이터 삽입2
INSERT INTO comments 
    comments_image, comments_image2, comments_image3, comments_text, ratings, 
    food_items_food_id, comments_user_id, comments_title, comments_status, comments_date
    VALUES ?, ?, ?, ?, ?, ?, ?, ?, ?, ?;

--리뷰 테이블 데이터 수정
UPDATE comments "+"
  SET comments_image= ?, comments_text = ?, ratings = ?, comments_title = ?
  WHERE comments_id = ? AND comments_user_id = ?;

--리뷰 테이블 데이터 삭제
DELETE  FROM comments WHERE comments_id = ? AND comments_user_id = ?;

