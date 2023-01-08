create table  user_subscriptions (
    channel_id bigint not null references usr,
    subscriber_id bigint not null references usr,
    primary key (channel_id , subscriber_id),
    constraint channel_id foreign key (channel_id) references usr(id),
    constraint subscriber_id foreign key (subscriber_id) references usr(id)
            ) engine=InnoDB;


