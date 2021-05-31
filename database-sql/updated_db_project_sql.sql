
CREATE TYPE address_info AS object( 
	house_no varchar2(20),
	street_no varchar2(20),
	postal_code varchar2(20)	
);


drop table customer;
create table customer(
	cust_id varchar2(10) ,
	cust_name varchar2(50) CHECK (LENGTH(cust_name) >=3), 
	cust_mail varchar2(30) CHECK (cust_mail LIKE '%___@___%'),
	cust_gender varchar2(10) CHECK (cust_gender IN ('male','female')),
	cust_phone varchar2(11) CHECK (LENGTH(cust_phone)=11),
	cust_address address_info not null,
    
    primary key (cust_id) 
);

drop table order_info;
create table order_info(
    order_id varchar2(10) ,
    order_total_cost numeric(12,2) check(order_total_cost > 0),
    order_time timestamp,
    order_quantity int not null,
    
    primary key (order_id)
);

drop table admin;
create table admin(
    admin_id varchar2(10),
    admin_name varchar2(30) not null,
    admin_password varchar2(30) check(length(admin_password)>=6),
    
    primary key (admin_id)
) 
drop table product;
create table product(
    product_id varchar2(10) ,
    product_name varchar2(30) not null,
    product_quantity int,
    product_price numeric(12,2) check(product_price > 0) , 
    product_image varchar2(100) ,
    product_category varchar2(20),
    
    primary key (product_id)    
);
drop table total_sell;
create table total_sell(
    selling_id varchar2(10) ,
    selling_amount numeric(12,2) check(selling_amount>0),
    selling_date_time timestamp,
    
    primary key (selling_id)    
);

drop table employee;
create table employee(
    employee_id varchar2(10) ,
    employee_name varchar2(30) CHECK (LENGTH(employee_name) >=3),
    employee_mail varchar2(30) CHECK (employee_mail LIKE '%___@___%'),
    employee_designation varchar2(20) not null, 
    employee_phone varchar2(11) check(LENGTH(employee_phone)=11),
    employee_address address_info NOT NULL,
    
    primary key (employee_id)    
);

drop table supplier;
create table supplier(
    supplier_id varchar2(10) ,
    supplier_name varchar2(30) CHECK(LENGTH(supplier_name)>=3),
    supplier_mail varchar2(30) CHECK (supplier_mail LIKE '%___@___%'),
    supplier_phone varchar2(11) CHECK(LENGTH(supplier_phone)=11),
    supplier_address address_info not null, 
    
    primary key (supplier_id)    
);

drop table buy_cart;
create table buy_cart(
    cust_id varchar2(10),
    product_id varchar2(10),
    order_id varchar2(10),
    product_selected_quantity int ,
    primary key (cust_id,product_id,order_id),
    
    foreign key (cust_id) references customer(cust_id),
    foreign key (product_id) references product(product_id),
    foreign key (order_id) references order_info(order_id)    
);

drop table process;
create table process(    
    order_id varchar2(10),
    selling_id varchar2(10),
    admin_id varchar2(10),
    employee_id varchar2(10),
    product_status varchar2(10),
    primary key (order_id,selling_id,admin_id,employee_id),
    
    foreign key (order_id) references order_info(order_id),
    foreign key (selling_id) references total_sell(selling_id),
    foreign key (admin_id) references admin(admin_id), 
    foreign key (employee_id) references employee(employee_id) 
);

drop table admin_controls_product;
create table admin_controls_product(    
    admin_id varchar2(10),
    product_id varchar2(10),
    admin_control_datetime timestamp,
    admin_control_type varchar2(10),
    
    primary key (admin_id,product_id), 
    
    foreign key (admin_id) references admin(admin_id),
    foreign key (product_id) references product(product_id)    
 );
 
drop table handler;
create table handler(    
    employee_id varchar2(10),
    product_id varchar2(10),
    handle_datetime timestamp not null,
    
    primary key (employee_id,product_id), 
    
    foreign key (employee_id) references employee(employee_id),
    foreign key (product_id) references product(product_id)    
 );
 
drop table supplies;
create table supplies(    
    supplier_id varchar2(10),
    product_id varchar2(10),
    supplier_datetime timestamp not null,
    
    primary key (supplier_id,product_id), 
    
    foreign key (supplier_id) references supplier(supplier_id),
    foreign key (product_id) references product(product_id)    
 );



