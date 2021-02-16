# テーブル設計

## usersテーブル

| Column              | Type    | Options     |
| ------------------- | ------- | ----------- |
| nickname            | string  | null: false |
| email               | string  | null: false |
| password            | string  | null: false |
| last_name           | string  | null: false |
| first_name          | string  | null: false |
| last_name_kana      | string  | null: false |
| first_name_kana     | string  | null: false |
| birth_date          | date    | null: false |


### Association
- has_many :items
- has_many :orders

## itemsテーブル

| Column                 | Type    | Options           |
| ---------------------- | ------- | ----------------- |
| name                   | string  | null: false       |
| explain                | text    | null: false       |
| category_id            | integer | null: false       |
| sales_status_id        | integer | null: false       |
| shopping_fee_status_id | integer | null: false       |
| prefecture_id          | integer | null: false       |
| scheduled_delivery_id  | integer | null: false       |
| price                  | integer | null: false       |
| user_id                | integer | foreign_key: true |


### Association
- belongs_to :user
- has_one :order

## ordersテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| item_id          | references | foreign_key: true |
| user_id          | references | foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| postal_code   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| addresses     | string     | null: false       |
| building      | text       |                   |
| phone_number  | integer    | null: false       |
| order_id      | references | foreign_key: true |


### Association
- belongs_to :order
