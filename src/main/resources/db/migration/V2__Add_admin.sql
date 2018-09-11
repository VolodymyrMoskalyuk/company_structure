insert into users (id, user_name, email, password, active)
        values (1,'admin', 'admin@mail.com','admin', true);

insert into user_role (user_id, roles)
        values (1,'USER'), (1,'ADMIN');