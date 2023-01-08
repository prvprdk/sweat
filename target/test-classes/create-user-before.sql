delete from user_role;
delete from usr;

insert into usr (id,active, password, username) values
        (1,true,'$2a$08$o6OkJh8q55XKARXe0zIMbO/trUVIoj/J2c8uPf9/DcP4zCSTieL76', 'useronetest'),
        (2,true, '$2a$08$o6OkJh8q55XKARXe0zIMbO/trUVIoj/J2c8uPf9/DcP4zCSTieL76', 'usertwotest');
insert into user_role (user_id, roles) values
        (1, 'USER'), (1,'ADMIN'),
        (2, 'USER');
