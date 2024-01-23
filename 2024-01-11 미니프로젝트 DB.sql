drop table member cascade constraints purge;
drop table board cascade constraints purge;
drop table reply cascade constraints purge;
drop table saved cascade constraints purge;

create sequence member_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;


create sequence board_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;


create sequence reply_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;
    
create sequence save_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;    
    
    

create table member (
    idx         number              default member_seq.nextval primary key,
    userid      varchar2(100)       unique not null,
    userpw      varchar2(100)       not null,
    username    varchar2(100)       not null,
    email       varchar2(500)       not null
);


create table board (    --  외래키 : member에 있는 회원만 게시글을 작성할 수 있음 
    idx         number              default board_seq.nextval primary key,
    title       varchar2(1000)      not null,
    image       varchar2(3000)      default 'default.jpg',
    category    varchar2(100)       check (category in('관광' , '맛집')) not null,
    writer      varchar2(100),      
    content     varchar2(4000)      not null,
    writeDate   Date                default sysdate,
    deleted     number              default 0 check(deleted between 0 and 1),
    
    constraint board_member_fk 
    foreign key(writer) 
    REFERENCES member(userid) on delete set null
);



create table reply (    --  외래키 1 : 원본 게시글의 순번 == reply 테이블의 board_idx
                        --  외래키 2 : member 테이블에 있는 회원만 댓글을 작성할 수 있다
    idx             number          default reply_seq.nextval primary key,
    board_idx       number          not null, 
    writer          varchar2(100),
    content         varchar2(2000)  not null,
    writeDate       date            default sysdate,
    parent_idx      NUMBER          DEFAULT 0,
    reply_depth     number          default 0,
    
    constraint reply_board_fk
    foreign key(board_idx)
    REFERENCES board(idx),
    
    constraint reply_member_fk 
    foreign key(writer) 
    REFERENCES member(userid) on delete set null
);



create table saved (  
                        
    idx         number          default save_seq.nextval primary key,
    board_idx   number          not null, 
    memberId    varchar2(100),
    
    
    constraint save_board_fk
    foreign key(board_idx)
    REFERENCES board(idx),
    
    constraint save_member_fk
    foreign key(memberId)
    REFERENCES member(userid) on delete set null
);


--  더미데이터 원본
insert into member (userid, userpw, username, email) values ('test', '1234', '테스트', 'test@naver.com');
insert into member (userid, userpw, username, email) values ('it', 'it', '아이티', 'it@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju1', '1234','제주살고싶퍼용','jeju1@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju2', '1234','제주뭐랭','jeju2@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju3', '1234','제주한량','jeju3@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju4', '1234','자연인','jeju4@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju5', '1234','제주낭만사진가','jeju5@naver.com');


insert into board (title, image, category, writer, content) values ('제주산 해물', '1.jpg', '맛집', 'test', '제주도에 가면 해물을 꼭 먹어야한다..');
insert into board (title, image, category, writer, content) values ('고기국수 맛집', '2.jpg', '맛집', 'test', '고기국수 너무 맛있어요');
insert into board (title, image, category, writer, content) values ('제주도 카페', '3.jpg', '맛집', 'it', '스콘이랑 커피랑 잘어울립니다');
insert into board (title, image, category, writer, content) values ('협재 맛집', '4.jpg', '맛집', 'test', '오므라이스가 최고');
insert into board (title, image, category, writer, content) values ('해물라면', '5.jpg', '맛집', 'jeju1', '제주도 해물이 참 싱싱합니다');
insert into board (title, image, category, writer, content) values ('협재 해수욕장', '6.jpg', '관광', 'it', '바다가 너무 예쁩니다 ~ ^^');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '제주 나무식탁','고등어온소바.jpg', '맛집' , 'jeju1' , '제주 고등어 온소바/국물만 먹으면 다소 심심할 수 있지만 영귤청이 우려지면 우려질수록 달콤한 맛을 느낄 수 있습니다 먹으면 먹을수 록 국물의 감칠맛이 계속 국물을 먹게 한다 고등어에 간이 되어 있어 같이 먹으면 간이 아주 적절하게 맞는다 
밑반찬인 줄기 상추 무침의 특유의 식감으로 먹는 재미 또한 있다 디저트로 나오는 옥수수 아이스크림은 입안에서 옥수수가 씹히면서 재밌는 식감과 달콤함을 함께 즐길 수 있다');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '제주 모리노아루요', '메로동.jpg', '맛집', 'jeju2', '제주 모리노 아루요 /
TBC 효리네 민박2에서 박보검이 먹으면서 화제가 된 메로동 달큰한 간장과 부드러운 메로가 만나서 밥과 아주 잘 어울리는 조화가 펼쳐진다');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '제주 삼성혈', '삼성혈.jpg' , '관광', 'jeju1', '삼성혈 개인적으로 제주에서 벚꽃이 필 무렵에 가면 이쁜 장소이다 근처에 전농로 벚꽃거리가 있어서 벚꽃 개화시기에 맞추어 제주가게 된다면 
이쁜 사진들을 많이 담을 수 있는 장소이기도 하다 ');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '한라산 백록담', '백록담.jpg', '관광', 'jeju4', '제주 한라산 백록담 /
제주에 간다면 꼭 가보기를 추천하는 백록담 1년 중 운해가 없는 날이 손에 꼽기 때문에 3대가 덕을 쌓아야 볼 수 있다는 말이 있다 살면서 한번쯤 가본다면 자연의 경치에 매료될 수 있는 장소이다');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '제주 새별오름', '새별오름.jpg' , '관광', 'jeju5', '새별오름 /
가을에 가면 이쁜 새별오름이지만 밤에 별을 보러 가는 것이 10배 더 이쁜 제주의 오름중 하나이다 언덕이나 산을 올라갈 필요없이 주차장에서 제주 밤하늘에 수 놓은 별들의 바다를 볼 수 있는 곳 중 하나이다');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '제주 김녕해수욕장', '김녕해수욕장.jpg', '관광', 'jeju5', '김녕해수욕장 /
제주 동쪽의 바다중 차분한 바다를 느낄수 있는 장소 중 하나이다 봄 늦은 오후시간에 방문하면 오묘한 분위기를 느낄 수 있는 바다 중 하나 해수욕장이 오픈하기 전에는 사람이 많이 없어 조용하게 바다 산책을 하고 싶다면 추천하는 여행지');



--  더미데이터 생성
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;

INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;

INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
    
    

commit;