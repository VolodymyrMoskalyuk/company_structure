create sequence hibernate_sequence start 1 increment 1;

  create table company (
      id int8 not null,
      child_earnings int8,
      company_name varchar(255) not null,
      earnings int8 not null,
      parent varchar(255),
      total_amount int8,
      user_id int8,
      primary key (id)
   );
  create table user_role (
      user_id int8 not null,
      roles varchar(255)
  );
  create table users (
      id int8 not null,
      active boolean not null,
      email varchar(255),
      password varchar(255) not null,
      user_name varchar(255) not null,
      primary key (id)
  );

  alter table if exists company
      add constraint company_user_fk
      foreign key (user_id) references users;

  alter table if exists user_role
      add constraint user_role_user_fk
      foreign key (user_id) references users;
