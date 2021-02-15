# テーブル設計

## usersテーブル

| Column                  | Type    | Options     |
| ----------------------- | ------- | ----------- |
| nickname                | string  | null: false |
| last_name               | string  | null: false |
| first_name              | string  | null: false |
| last_name_kana          | string  | null: false |
| first_name_kana         | string  | null: false |
| user_birth_date_year    | integer | null: false |
| user_birth_date_month   | integer | null: false |
| user_birth_date_day     | integer | null: false |

### Association
- has_many :items
- has_many :orders

## itemsテーブル

| Column                | Type    | Options           |
| --------------------- | ------- | ----------------- |
| name                  | string  | null: false       |
| image                 | text    | null: false       |
| explain               | text    | null: false       |
| category              | string  | null: false       |
| sales_status          | string  | null: false       |
| shopping_fee_status   | string  | null: false       |
| prefecture            | string  | null: false       |
| scheduled_delivery    | string  | null: false       |
| price                 | integer | null: false       |
| user_id               | integer | foreign_key: true |


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
|postal_code    | integer    | null: false       |
|prefecture     | string     | null: false       |
|city           | string     | null: false       |
|addresses      | text       | null: false       |
|building       | text       |                   |
|phone_number   | integer    | null: false       |
|order_id       | references | foreign_key: true |


### Association
- belongs_to :order
