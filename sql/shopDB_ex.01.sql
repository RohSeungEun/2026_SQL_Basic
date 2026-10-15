-- 2026 SQL(출처:나혼자 SQL 분석 책) 활용
-- SELECT 데이터 활용
SELECT * FROM shop_db.member;
-- SELECT (데이터 조건부 WHERE 활용)
SELECT `member_name` FROM member; -- 머라이어, 임영웅, 아이유, 박진영, 나훈아 
SELECT * FROM member WHERE `member_name`= '머라이어';

-- 테이블 생성
CREATE TABLE `shop_db`.`member` (
  `member_id` CHAR(8) NOT NULL,
  `member_name` CHAR(45) NOT NULL,
  `member_address` CHAR(45) NULL,
  PRIMARY KEY (`member_id`));


CREATE TABLE `shop_db`.`product` (
  `product_id` INT NOT NULL,
  `product_cost` INT NOT NULL,
  `product_makeDate` DATE NOT NULL,
  `product_company` CHAR(45) NULL,
  `product_account` INT NOT NULL,
  PRIMARY KEY (`product_id`, `product_cost`));


-- 테이블 삽입 INSERT문
INSERT INTO `shop_db`.`member` (`member_id`, `member_name`, `member_address`) VALUES ('tess', '나훈아', '경기도 부천시 중동');
INSERT INTO `shop_db`.`member` (`member_id`, `member_name`, `member_address`) VALUES ('hero', '임영웅', '서울 은평구 중산동');
INSERT INTO `shop_db`.`member` (`member_id`, `member_name`, `member_address`) VALUES ('iyou', '아이유', '인천 남구 주안동');
INSERT INTO `shop_db`.`member` (`member_id`, `member_name`, `member_address`) VALUES ('jyp', '박진영', '경기 고양시 장항동');

-- 테이블 수정 UPDATE문
UPDATE `shop_db`.`member` SET `member_id` = '', `member_name` = '', `member_address` = '' WHERE (`member_id` = 'tess');
-- 테이블 삭제 DELET문
DELETE FROM `shop_db`.`member` WHERE (`member_id` = 'jyp');