---리뷰-댓글 테이블

--댓글 테이블 데이터 조회1
SELECT * FROM reply WHERE comments_comments_id = ?;

--댓글 테이블 데이터 조회2
SELECT comments_text AS text, comments_title AS title,
        ratings, food_name, 
        user_id AS id, user_name AS name, 
        user_gender AS gender, comments_image AS image ,
        comments_id, food_category AS category
    FROM comments
    LEFT JOIN food_items ON food_items_food_id = food_id
    LEFT JOIN users ON users_user_id = user_id;

--댓글 테이블 데이터 삽입1
INSERT INTO reply
  reply_text, comments_comments_id,
  users_user_id, food_items_food_id, reply_date
  VALUES (?, ?, ?, ?, ?);

--댓글 테이블 데이터 수정
UPDATE reply
 SET reply_text = ?
 WHERE comments_comments_id = ?
 AND id_reply = ?
 AND users_user_id = ?;


--댓글 테이블 데이터 삭제1
DELETE FROM reply
  WHERE comments_comments_id = ?
  AND id_reply = ?
  AND users_user_id = ?;


--댓글 테이블 데이터 삭제2
DELETE FROM comments WHERE comments_id = ?;

  
--댓글-상태(좋아요/싫어요)-1:N관계
-- 좋아요 상태 테이블 데이터 조회1
SELECT *
  FROM user_like
  LEFT JOIN comments ON comments_id = comments_comments_id
  WHERE comments_status = 0 AND users_user_id = ?;

-- 좋아요 상태 테이블 데이터 조회2
SELECT users_user_id AS user_id
   FROM user_like 
   WHERE comments_comments_id = ?;

-- 좋아요 상태 테이블 데이터 삽입
INSERT INTO user_like comments_comments_id, users_user_id VALUES (?, ?);

--싫어요 상태 테이블 데이터 삭제
DELETE FROM user_like
    WHERE users_user_id = ?
    AND comments_comments_id = ?;


---리뷰-키워드 테이블(일대다 관계)
-- 키워드 테이블 데이터 조회
SELECT max(comments_id) FROM comments;

--키워드 테이블 데이터 조회2
SELECT * FROM keyword
   WHERE comments_comments_id = '?', id;

--키워드 테이블 데이터 조회3
SELECT * FROM comments WHERE comments_status = 0;

--키워드 테이블 데이터 조회4
SELECT * FROM comments
   LEFT JOIN food_items
   ON food_items_food_id = food_id
   WHERE comments_id = '?', id;

--키워드 테이블 데이터 삽입1
INSERT INTO keyword (keyword, comments_comments_id) VALUES (?, ?);

--키워드 테이블 데이터 삽입2
INSERT INTO keyword (keyword, comments_comments_id) VALUES (?, ?);

--키워드 테이블 데이터 수정
UPDATE comments 
  SET comments_image= ?, comments_text = ?, ratings = ?, comments_title = ? "+
      "WHERE comments_id = ? AND comments_user_id = ?;

--키워드 테이블 데이터 삭제
DELETE FROM comments
  WHERE comments_id = ?
  AND comments_user_id = ?"

