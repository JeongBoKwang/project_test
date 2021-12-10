DROP DATABASE IF EXISTS project_test;

CREATE DATABASE project_test;

USE project_test;

-- 게시물 테이블
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

-- 회원 테이블
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

-- 게시물 테이블에 회원정보 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;
DESC article;

SELECT *
FROM article;

-- 기존 게시물의 작성자를 2번호로 저장
UPDATE article
SET memberId = 2
WHERE memberId = 0;