DROP DATABASE IF EXISTS project_test;

CREATE DATABASE project_test;

USE project_test;

CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

INSERT INTO article(
    regDate, updateDate, title, `body`
)
VALUES (
    NOW(), NOW(), "제목1", "내용1"
);

INSERT INTO article(
    regDate, updateDate, title, `body`
)
VALUES (
    NOW(), NOW(), "제목2", "내용2"
);

INSERT INTO article(
    regDate, updateDate, title, `body`
)
VALUES (
    NOW(), NOW(), "제목3", "내용3"
);

SELECT *
FROM article;

CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    `authlevel` SMALLINT(2) UNSIGNED NOT NULL DEFAULT 3 COMMENT '권한레벨(3=일반,7=관리자)',
    `name` CHAR(20) NOT NULL,
    `nickName` CHAR(20) NOT NULL,
    cellPhoneNo CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부(0=탈퇴전,1=탈퇴)',
    delDate DATETIME COMMENT '탈퇴날짜'
);

INSERT INTO `member`(
    regDate, updateDate, loginId, loginPw, `authlevel`, `name`, `nickName`, cellPhoneNo, email
)
VALUES (
    NOW(), NOW(), 'user1', '1234', 7, '유저1', '유저1', '010-1234-1234', 'abcde@naver.com'
);

INSERT INTO `member`(
    regDate, updateDate, loginId, loginPw, `name`, `nickName`, cellPhoneNo, email
)
VALUES (
    NOW(), NOW(), 'user2', '1234', '유저2', '유저2', '010-9876-9876', 'abcde1@naver.com'
);

SELECT *
FROM `member`;

SELECT LAST_INSERT_ID();

#게시물 테이블에 회원정보 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;
DESC article;

SELECT *
FROM article;

#기존 게시물의 작성자를 2번호로 저장
UPDATE article
SET memberId = 2
WHERE memberId = 0;

SELECT A.*,
M.nickname AS extra__writerName
FROM article AS A
LEFT JOIN MEMBER AS M
ON A.memberId = M.id
ORDER BY A.id DESC

#게시판 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항),free1(자유게시판1),free2(자유게시판2),...',
    `name` CHAR(50) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=)삭제',
    delDate DATETIME COMMENT '삭제날짜'
);

#기본 게시판 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free1',
`name` = '자유게시판';

SHOW TABLES;

#게시판 테이블에 boredId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER memberId;

DESC article;

SELECT *
FROM article;

#기존 게시물에 강제로 게시판 정보 넣기
UPDATE article
SET boardId = 1
WHERE id IN(1, 2);

UPDATE article
SET boardId = 2
WHERE id IN(3);

SELECT *
FROM article;

SELECT *
FROM board 
WHERE id =2;

/* INSERT INTO article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 1, FLOOR(RAND() * 2) + 1, CONCAT('제목_', RAND()), CONCAT('내용_', RAND())
FROM article;


SELECT COUNT(*) 
FROM article; */

ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0; 

DESC article;